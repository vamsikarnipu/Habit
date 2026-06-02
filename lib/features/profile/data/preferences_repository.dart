import 'package:hive/hive.dart';
import '../../../core/storage/hive_boxes.dart';
import 'preferences_model.dart';

class PreferencesRepository {
  PreferencesRepository(this._box);
  final Box<UserPreferences> _box;
  static const key = 'user';
  static PreferencesRepository instance() => PreferencesRepository(Hive.box<UserPreferences>(HiveBoxes.preferences));
  UserPreferences get() {
    final current = _box.get(key);
    if (current != null) return current;
    final prefs = UserPreferences();
    _box.put(key, prefs);
    return prefs;
  }
  Future<void> save(UserPreferences prefs) => _box.put(key, prefs);
}
