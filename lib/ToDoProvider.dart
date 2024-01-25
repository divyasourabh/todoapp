import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

import 'ToDoModel.dart';

class ToDoProvider extends ChangeNotifier {
  List<ToDoModel>? todoList = [];
  static late Isar isar;

  ToDoProvider() {
    init();
  }

  init() async{
    await openDatabase();
    fetchToDoList();
}

  Future<void> openDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [ToDoModelSchema],
      directory: dir.path,
      inspector: true,
    );
    print("OpenDatabase End");
  }
  String convertDateTime (DateTime dateTimeString) {
    DateFormat format = new DateFormat("dd-MM-yyyy");
    return DateFormat.yMMMEd().format(dateTimeString);
  }


  void addToDoItem(ToDoModel toDoItem) async {
    print("Title = ${toDoItem.title}");
    print("Add Date and Time ${DateTime.now()}");
    toDoItem.createdDate = convertDateTime(DateTime.now());
    await isar.writeTxn(() => isar.toDoModels.put(toDoItem));
    print('ToDoItem Added');
    fetchToDoList();
  }

  void toggleFinishedStatus(ToDoModel toDoItem) async {
    print("Title = ${toDoItem.title}");
    print("Update Date and Time ${DateTime.now()}");
    toDoItem.updatedDate = convertDateTime(DateTime.now());
    await isar.writeTxn(() => isar.toDoModels.put(toDoItem));
    fetchToDoList();
  }

  void deleteToDoItem(ToDoModel toDoItem) async {
    print("Title = ${toDoItem.title}");
    print("Delete Icon Tap ${toDoItem.id}");
    await isar.writeTxn(() => isar.toDoModels.delete(toDoItem.id));
    print("Delete Icon Tap");
    fetchToDoList();
  }

  void fetchToDoList () async {
    List<ToDoModel> list = await isar.toDoModels.where().findAll();
    todoList?.clear();
    todoList?.addAll(list);
    print("ToDo notifyListeners Size = ${todoList?.length}");
    notifyListeners();
    print("ToDo notifyListeners");
  }
}
