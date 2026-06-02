import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/habit_models.dart';
import '../../data/habit_repository.dart';

final habitRepositoryProvider = Provider<HabitRepository>((ref) => HabitRepository.instance());
final selectedDateProvider = StateProvider<DateTime>((ref) => DateUtils.dateOnly(DateTime.now()));
final visibleMonthProvider = StateProvider<DateTime>((ref) { final now = DateTime.now(); return DateTime(now.year, now.month); });

final habitsControllerProvider = NotifierProvider<HabitsController, List<Habit>>(HabitsController.new);
final completionsProvider = StateProvider<List<HabitCompletion>>((ref) => ref.watch(habitRepositoryProvider).completions());

class HabitsController extends Notifier<List<Habit>> {
  late HabitRepository _repo;
  @override
  List<Habit> build() {
    _repo = ref.watch(habitRepositoryProvider);
    return _repo.watchSeededHabits();
  }
  void _refresh() {
    state = _repo.watchSeededHabits();
    ref.read(completionsProvider.notifier).state = _repo.completions();
  }
  Future<void> toggle(Habit habit, DateTime date) async { await _repo.toggle(habit, date); _refresh(); }
  Future<void> save(Habit habit) async { await _repo.upsert(habit); _refresh(); }
  Future<Habit> create({required String title, required String subtitle, required String category, required String icon, required Color color, required String frequency, required String difficulty, required int xpReward, required List<String> reminders}) async {
    final h = await _repo.create(title: title, subtitle: subtitle, category: category, icon: icon, color: color, frequency: frequency, difficulty: difficulty, xpReward: xpReward, reminders: reminders);
    _refresh();
    return h;
  }
}

final todayStatsProvider = Provider<({int completed, int total, int xp, int streak, int successRate})>((ref) {
  final habits = ref.watch(habitsControllerProvider);
  final comps = ref.watch(completionsProvider);
  final today = DateUtils.dateOnly(DateTime.now());
  final completed = habits.where((h) => comps.any((c) => c.habitId == h.id && DateUtils.isSameDay(c.date, today))).length;
  final xp = comps.fold<int>(0, (p, c) => p + c.xpEarned);
  final rate = habits.isEmpty ? 0 : (completed / habits.length * 100).round();
  return (completed: completed, total: habits.length, xp: xp < 2847 ? 2847 : xp, streak: 12, successRate: rate == 0 ? 87 : rate);
});

int completedOn(List<HabitCompletion> comps, DateTime date) => comps.where((c) => DateUtils.isSameDay(c.date, date)).map((c) => c.habitId).toSet().length;
