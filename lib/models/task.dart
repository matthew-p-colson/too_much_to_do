import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  DateTime doBy;

  @HiveField(3)
  bool completed;

  Task(
      {required this.title,
      required this.description,
      required this.doBy,
      required this.completed});
}
