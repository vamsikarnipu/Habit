import 'package:hive/hive.dart';

@HiveType(typeId: 3)
class UserPreferences extends HiveObject {
  UserPreferences({this.darkMode = false, this.remindersEnabled = true, this.weekStartsMonday = true, this.avatarEmoji = '👨🏽‍💻'});

  @HiveField(0)
  bool darkMode;
  @HiveField(1)
  bool remindersEnabled;
  @HiveField(2)
  bool weekStartsMonday;
  @HiveField(3)
  String avatarEmoji;

  UserPreferences copyWith({bool? darkMode, bool? remindersEnabled, bool? weekStartsMonday, String? avatarEmoji}) => UserPreferences(
        darkMode: darkMode ?? this.darkMode,
        remindersEnabled: remindersEnabled ?? this.remindersEnabled,
        weekStartsMonday: weekStartsMonday ?? this.weekStartsMonday,
        avatarEmoji: avatarEmoji ?? this.avatarEmoji,
      );
}

class UserPreferencesAdapter extends TypeAdapter<UserPreferences> {
  @override
  final int typeId = 3;
  @override
  UserPreferences read(BinaryReader reader) {
    final n = reader.readByte();
    final fields = <int, dynamic>{for (var i = 0; i < n; i++) reader.readByte(): reader.read()};
    return UserPreferences(
      darkMode: (fields[0] as bool?) ?? false,
      remindersEnabled: (fields[1] as bool?) ?? true,
      weekStartsMonday: (fields[2] as bool?) ?? true,
      avatarEmoji: (fields[3] as String?) ?? '👨🏽‍💻',
    );
  }
  @override
  void write(BinaryWriter writer, UserPreferences obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)..write(obj.darkMode)
      ..writeByte(1)..write(obj.remindersEnabled)
      ..writeByte(2)..write(obj.weekStartsMonday)
      ..writeByte(3)..write(obj.avatarEmoji);
  }
}
