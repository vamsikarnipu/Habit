import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/storage/hive_boxes.dart';
import 'habit_models.dart';

class HabitRepository {
  HabitRepository(this._habits, this._completions);
  final Box<Habit> _habits;
  final Box<HabitCompletion> _completions;
  static const _uuid = Uuid();

  static HabitRepository instance() => HabitRepository(Hive.box<Habit>(HiveBoxes.habits), Hive.box<HabitCompletion>(HiveBoxes.completions));

  List<Habit> watchSeededHabits() {
    if (_habits.isEmpty) seed();
    return _habits.values.where((h) => h.active).toList()..sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }

  List<HabitCompletion> completions() => _completions.values.toList();

  Future<void> seed() async {
    final now = DateTime.now();
    final samples = [
      Habit(id: 'water', title: 'Drink Water', subtitle: '2 Liters daily', category: 'Health', icon: '💧', colorValue: AppColors.blue.value, frequency: 'Daily', difficulty: 'Easy', xpReward: 10, reminderTimes: ['8:00 AM'], createdAt: now.subtract(const Duration(days: 40))),
      Habit(id: 'walk', title: 'Morning Walk', subtitle: '30 minutes', category: 'Health', icon: '🚶', colorValue: AppColors.green.value, frequency: 'Daily', difficulty: 'Medium', xpReward: 15, reminderTimes: ['7:30 AM'], createdAt: now.subtract(const Duration(days: 35))),
      Habit(id: 'read', title: 'Read 20 Minutes', subtitle: 'Learn something new', category: 'Learning', icon: '📖', colorValue: AppColors.purple.value, frequency: 'Daily', difficulty: 'Medium', xpReward: 10, reminderTimes: ['9:00 AM'], createdAt: now.subtract(const Duration(days: 25))),
      Habit(id: 'workout', title: 'Workout', subtitle: 'Stay strong, stay healthy', category: 'Health', icon: '🏋️', colorValue: AppColors.orange.value, frequency: 'Daily', difficulty: 'Hard', xpReward: 50, reminderTimes: ['6:00 PM'], createdAt: now.subtract(const Duration(days: 18))),
      Habit(id: 'journal', title: 'Journal', subtitle: 'Reflect and grow', category: 'Wellness', icon: '📓', colorValue: AppColors.amber.value, frequency: 'Daily', difficulty: 'Easy', xpReward: 10, reminderTimes: ['9:30 PM'], createdAt: now.subtract(const Duration(days: 12))),
    ];
    for (final habit in samples) {
      await _habits.put(habit.id, habit);
    }
    for (var daysAgo = 0; daysAgo < 31; daysAgo++) {
      final date = DateUtils.dateOnly(now.subtract(Duration(days: daysAgo)));
      for (var i = 0; i < samples.length; i++) {
        final complete = daysAgo == 0 ? i == 1 : (daysAgo + i) % 5 != 0;
        if (complete) await completeHabit(samples[i], date, seedMode: true);
      }
    }
  }

  bool isComplete(String habitId, DateTime date) => _completions.values.any((c) => c.habitId == habitId && DateUtils.isSameDay(c.date, date));

  Future<void> toggle(Habit habit, DateTime date) async {
    final day = DateUtils.dateOnly(date);
    final existing = _completions.values.where((c) => c.habitId == habit.id && DateUtils.isSameDay(c.date, day)).toList();
    if (existing.isNotEmpty) {
      for (final c in existing) {
        await c.delete();
      }
    } else {
      await completeHabit(habit, day);
    }
  }

  Future<void> completeHabit(Habit habit, DateTime day, {bool seedMode = false}) async {
    final id = '${habit.id}-${day.toIso8601String()}';
    if (_completions.containsKey(id)) return;
    await _completions.put(id, HabitCompletion(id: id, habitId: habit.id, date: DateUtils.dateOnly(day), completedAt: seedMode ? day.add(const Duration(hours: 8)) : DateTime.now(), xpEarned: habit.xpReward));
  }

  Future<void> upsert(Habit habit) => _habits.put(habit.id, habit);
  Future<Habit> create({required String title, required String subtitle, required String category, required String icon, required Color color, required String frequency, required String difficulty, required int xpReward, required List<String> reminders}) async {
    final habit = Habit(id: _uuid.v4(), title: title, subtitle: subtitle, category: category, icon: icon, colorValue: color.value, frequency: frequency, difficulty: difficulty, xpReward: xpReward, reminderTimes: reminders, createdAt: DateTime.now());
    await upsert(habit);
    return habit;
  }
}
