

import 'package:isar/isar.dart';

part 'ToDoModel.g.dart';

@Collection()
class ToDoModel {
  Id id = Isar.autoIncrement;
  late String title;
  late bool isFinished;
  String? createdDate;
  String? updatedDate;
}