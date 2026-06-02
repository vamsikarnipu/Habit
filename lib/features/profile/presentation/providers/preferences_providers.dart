import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/preferences_model.dart';
import '../../data/preferences_repository.dart';

final preferencesRepositoryProvider = Provider((ref) => PreferencesRepository.instance());
final preferencesProvider = NotifierProvider<PreferencesController, UserPreferences>(PreferencesController.new);

class PreferencesController extends Notifier<UserPreferences> {
  late PreferencesRepository _repo;
  @override
  UserPreferences build() { _repo = ref.watch(preferencesRepositoryProvider); return _repo.get(); }
  Future<void> setDark(bool value) async { state = state.copyWith(darkMode: value); await _repo.save(state); }
  Future<void> setReminders(bool value) async { state = state.copyWith(remindersEnabled: value); await _repo.save(state); }
  Future<void> setWeekStartsMonday(bool value) async { state = state.copyWith(weekStartsMonday: value); await _repo.save(state); }
}
