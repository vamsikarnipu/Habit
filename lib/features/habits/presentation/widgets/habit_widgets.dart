import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/ui.dart';
import '../../data/habit_models.dart';
import '../providers/habit_providers.dart';

class HabitCard extends ConsumerWidget {
  const HabitCard({super.key, required this.habit, required this.date, this.onEdit});
  final Habit habit; final DateTime date; final VoidCallback? onEdit;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final complete = ref.watch(completionsProvider).any((c) => c.habitId == habit.id && DateUtils.isSameDay(c.date, date));
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SoftCard(
        color: habit.color.withOpacity(.08), borderColor: habit.color.withOpacity(.24), padding: const EdgeInsets.all(16), onTap: onEdit,
        child: Row(children: [
          EmojiTile(emoji: habit.icon, color: habit.color, size: 72), const SizedBox(width: 18),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(habit.title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)), const SizedBox(height: 6), Text(habit.subtitle, style: const TextStyle(color: AppColors.muted, fontSize: 16))])),
          Column(children: [Text('🔥  ${_mockStreak(habit)}', style: TextStyle(color: habit.color, fontWeight: FontWeight.w800, fontSize: 18)), const Text('day streak', textAlign: TextAlign.center, style: TextStyle(color: AppColors.muted)), const SizedBox(height: 6)]), const SizedBox(width: 12),
          InkWell(onTap: () => ref.read(habitsControllerProvider.notifier).toggle(habit, date), child: AnimatedContainer(duration: const Duration(milliseconds: 220), width: 52, height: 52, decoration: BoxDecoration(shape: BoxShape.circle, color: complete ? AppColors.green : Colors.transparent, border: Border.all(color: complete ? AppColors.green : habit.color, width: 3)), child: complete ? const Icon(Icons.check, color: Colors.white, size: 30) : null)),
        ]),
      ),
    );
  }
  int _mockStreak(Habit h) => switch (h.id) { 'water' => 8, 'walk' => 12, 'read' => 6, 'workout' => 5, 'journal' => 7, _ => 1 };
}

class MetricCard extends StatelessWidget {
  const MetricCard({super.key, required this.icon, required this.title, required this.value, required this.subtitle, required this.color});
  final String icon; final String title; final String value; final String subtitle; final Color color;
  @override
  Widget build(BuildContext context) => Expanded(child: SoftCard(color: color.withOpacity(.08), borderColor: color.withOpacity(.14), child: Column(children: [Text(icon, style: const TextStyle(fontSize: 34)), const SizedBox(height: 10), Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 15)), const SizedBox(height: 10), Text(value, style: TextStyle(color: color, fontSize: 32, fontWeight: FontWeight.w900)), const SizedBox(height: 6), Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.muted, fontSize: 14))])));
}
