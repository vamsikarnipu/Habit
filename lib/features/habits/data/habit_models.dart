import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Habit extends HiveObject {
  Habit({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.icon,
    required this.colorValue,
    required this.frequency,
    required this.difficulty,
    required this.xpReward,
    required this.reminderTimes,
    required this.createdAt,
    this.active = true,
  });

  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String subtitle;
  @HiveField(3)
  String category;
  @HiveField(4)
  String icon;
  @HiveField(5)
  int colorValue;
  @HiveField(6)
  String frequency;
  @HiveField(7)
  String difficulty;
  @HiveField(8)
  int xpReward;
  @HiveField(9)
  List<String> reminderTimes;
  @HiveField(10)
  DateTime createdAt;
  @HiveField(11)
  bool active;

  Color get color => Color(colorValue);

  Habit copyWith({String? title, String? subtitle, String? category, String? icon, int? colorValue, String? frequency, String? difficulty, int? xpReward, List<String>? reminderTimes, bool? active}) => Habit(
        id: id,
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
        category: category ?? this.category,
        icon: icon ?? this.icon,
        colorValue: colorValue ?? this.colorValue,
        frequency: frequency ?? this.frequency,
        difficulty: difficulty ?? this.difficulty,
        xpReward: xpReward ?? this.xpReward,
        reminderTimes: reminderTimes ?? this.reminderTimes,
        createdAt: createdAt,
        active: active ?? this.active,
      );
}

@HiveType(typeId: 2)
class HabitCompletion extends HiveObject {
  HabitCompletion({required this.id, required this.habitId, required this.date, required this.completedAt, required this.xpEarned});

  @HiveField(0)
  String id;
  @HiveField(1)
  String habitId;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  DateTime completedAt;
  @HiveField(4)
  int xpEarned;
}

class HabitAdapter extends TypeAdapter<Habit> {
  @override
  final int typeId = 1;
  @override
  Habit read(BinaryReader reader) {
    final n = reader.readByte();
    final fields = <int, dynamic>{for (var i = 0; i < n; i++) reader.readByte(): reader.read()};
    return Habit(
      id: fields[0] as String,
      title: fields[1] as String,
      subtitle: fields[2] as String,
      category: fields[3] as String,
      icon: fields[4] as String,
      colorValue: fields[5] as int,
      frequency: fields[6] as String,
      difficulty: fields[7] as String,
      xpReward: fields[8] as int,
      reminderTimes: (fields[9] as List).cast<String>(),
      createdAt: fields[10] as DateTime,
      active: (fields[11] as bool?) ?? true,
    );
  }
  @override
  void write(BinaryWriter writer, Habit obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)..write(obj.id)
      ..writeByte(1)..write(obj.title)
      ..writeByte(2)..write(obj.subtitle)
      ..writeByte(3)..write(obj.category)
      ..writeByte(4)..write(obj.icon)
      ..writeByte(5)..write(obj.colorValue)
      ..writeByte(6)..write(obj.frequency)
      ..writeByte(7)..write(obj.difficulty)
      ..writeByte(8)..write(obj.xpReward)
      ..writeByte(9)..write(obj.reminderTimes)
      ..writeByte(10)..write(obj.createdAt)
      ..writeByte(11)..write(obj.active);
  }
}

class HabitCompletionAdapter extends TypeAdapter<HabitCompletion> {
  @override
  final int typeId = 2;
  @override
  HabitCompletion read(BinaryReader reader) {
    final n = reader.readByte();
    final fields = <int, dynamic>{for (var i = 0; i < n; i++) reader.readByte(): reader.read()};
    return HabitCompletion(id: fields[0] as String, habitId: fields[1] as String, date: fields[2] as DateTime, completedAt: fields[3] as DateTime, xpEarned: fields[4] as int);
  }
  @override
  void write(BinaryWriter writer, HabitCompletion obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)..write(obj.id)
      ..writeByte(1)..write(obj.habitId)
      ..writeByte(2)..write(obj.date)
      ..writeByte(3)..write(obj.completedAt)
      ..writeByte(4)..write(obj.xpEarned);
  }
}
