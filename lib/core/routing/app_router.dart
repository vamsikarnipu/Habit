import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/habits/presentation/screens/add_habit_screen.dart';
import '../../features/habits/presentation/screens/calendar_screen.dart';
import '../../features/habits/presentation/screens/home_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/settings_detail_screen.dart';
import '../../features/progress/presentation/screens/progress_screen.dart';
import '../widgets/ui.dart';

final routerProvider = Provider<GoRouter>((ref) => GoRouter(initialLocation: '/home', routes: [
  ShellRoute(builder: (context, state, child) {
    final path = state.uri.path;
    final index = path.startsWith('/calendar') ? 1 : path.startsWith('/add') ? 2 : path.startsWith('/progress') ? 3 : path.startsWith('/profile') ? 4 : 0;
    return ShellScaffold(index: index, child: child);
  }, routes: [
    GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
    GoRoute(path: '/calendar', builder: (_, __) => const CalendarScreen()),
    GoRoute(path: '/add', builder: (_, state) => AddHabitScreen(habitId: state.uri.queryParameters['habitId'])),
    GoRoute(path: '/progress', builder: (_, __) => const ProgressScreen()),
    GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
  ]),
  GoRoute(path: '/settings/:section', builder: (_, state) => SettingsDetailScreen(section: state.pathParameters['section'] ?? 'Settings')),
]));
