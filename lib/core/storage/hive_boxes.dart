import 'package:hive_flutter/hive_flutter.dart';
import '../../features/habits/data/habit_models.dart';
import '../../features/profile/data/preferences_model.dart';

class HiveBoxes {
  static const habits = 'habits';
  static const completions = 'habit_completions';
  static const preferences = 'preferences';

  static Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(HabitAdapter());
    if (!Hive.isAdapterRegistered(2)) Hive.registerAdapter(HabitCompletionAdapter());
    if (!Hive.isAdapterRegistered(3)) Hive.registerAdapter(UserPreferencesAdapter());
    await Hive.openBox<Habit>(habits);
    await Hive.openBox<HabitCompletion>(completions);
    await Hive.openBox<UserPreferences>(preferences);
  }
}
