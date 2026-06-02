import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/ui.dart';
import '../providers/habit_providers.dart';
import '../widgets/habit_widgets.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(habitsControllerProvider);
    final stats = ref.watch(todayStatsProvider);
    final today = DateTime.now();
    return AppPage(children: [
      Row(children: [const SmallAvatar(), const SizedBox(width: 24), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Good Morning,', style: Theme.of(context).textTheme.headlineSmall), Text('$mockUserName 👋', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w900)), const SizedBox(height: 10), Text(DateFormat('EEEE, MMMM d').format(today), style: const TextStyle(fontSize: 22, color: AppColors.muted))])), Stack(children: [SoftCard(padding: const EdgeInsets.all(14), child: const Icon(Icons.notifications_none, size: 30)), Positioned(right: 12, top: 10, child: Container(width: 12, height: 12, decoration: const BoxDecoration(color: AppColors.red, shape: BoxShape.circle)))])]),
      const SizedBox(height: 20), Align(alignment: Alignment.centerRight, child: SoftCard(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(mainAxisSize: MainAxisSize.min, children: [const Text('🔥', style: TextStyle(fontSize: 30)), const SizedBox(width: 8), Text('${stats.streak}', style: const TextStyle(fontSize: 34, color: AppColors.orange, fontWeight: FontWeight.w900)), const SizedBox(width: 8), const Text('Day Streak', style: TextStyle(fontSize: 20))]))),
      const SizedBox(height: 28), Row(children: [Expanded(child: SoftCard(color: AppColors.green.withOpacity(.08), borderColor: AppColors.green.withOpacity(.18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Today’s Progress', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)), const SizedBox(height: 20), Text('${stats.completed} / ${stats.total}', style: const TextStyle(color: AppColors.green, fontSize: 44, fontWeight: FontWeight.w900)), const Text('Habits Completed', style: TextStyle(color: AppColors.muted, fontSize: 19)), const SizedBox(height: 22), LinearProgressIndicator(value: stats.total == 0 ? 0 : stats.completed / stats.total, minHeight: 10, borderRadius: BorderRadius.circular(20), color: AppColors.green), const SizedBox(height: 20), const Text('Small steps, big progress 🌿', style: TextStyle(fontSize: 18, color: AppColors.muted))]))), const SizedBox(width: 18), Expanded(child: SoftCard(color: AppColors.purple.withOpacity(.08), borderColor: AppColors.purple.withOpacity(.18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('⭐', style: TextStyle(fontSize: 54)), const Text('Level 13', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: AppColors.purple)), const Text('Peak Performer', style: TextStyle(fontSize: 18, color: AppColors.muted)), const SizedBox(height: 34), LinearProgressIndicator(value: .71, minHeight: 10, borderRadius: BorderRadius.circular(20), color: AppColors.purple), const SizedBox(height: 24), const Text('2,847 XP to Level 14', style: TextStyle(fontSize: 18, color: AppColors.muted))])))]),
      const SizedBox(height: 34), SectionHeader('Today’s Habits', trailing: OutlinedButton.icon(onPressed: () => context.go('/add'), icon: const Icon(Icons.tune), label: const Text('Edit'))), const SizedBox(height: 18),
      if (habits.isEmpty) const SoftCard(child: Center(child: Padding(padding: EdgeInsets.all(24), child: Text('No habits yet. Tap + to add your first habit.')))) else ...habits.map((h) => HabitCard(habit: h, date: today, onEdit: () => context.go('/add?habitId=${h.id}'))),
      const SizedBox(height: 12), const SoftCard(color: Color(0xFFF0F8ED), child: Row(children: [Text('🌱', style: TextStyle(fontSize: 54)), SizedBox(width: 28), Expanded(child: Text('Discipline today,\nfreedom tomorrow.', style: TextStyle(fontSize: 22, height: 1.5, fontWeight: FontWeight.w600))), Text('💚', style: TextStyle(fontSize: 30))])),
    ]);
  }
}
