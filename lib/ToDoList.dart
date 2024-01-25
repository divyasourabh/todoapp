import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/ToDoItem.dart';

import 'ToDoModel.dart';
import 'ToDoProvider.dart';

class ToDoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => ToDoProvider(),
        child: Consumer<ToDoProvider>(
          builder: (BuildContext context, ToDoProvider toDoProvider,
              Widget? child) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("ToDo List"),
              ),
              body:
              ListView(
                children: _getItems(toDoProvider),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () =>
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Add Your Task"),
                          content: TextField(
                            controller: _textFieldController,
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                //Navigator.pop(context, 'Add');
                                Navigator.of(context).pop();
                                ToDoModel toDoItem = ToDoModel()
                                ..title = _textFieldController.text
                                ..isFinished = false;
                                toDoProvider.addToDoItem(toDoItem);
                                _textFieldController.clear();
                              },
                              child: const Text('Add'),
                            ),
                          ],
                        );
                      },
                    ),
                child: Icon(Icons.add),
              ),
            );
          },)
    );
  }
}

List<Widget> _getItems(ToDoProvider toDoProvider) {
  print("Get Item size = ${toDoProvider.todoList?.length}");
  final List<Widget> _todoWidgets = <Widget>[];
  for (int i = 0; i < toDoProvider.todoList!.length;i++) {
    ToDoModel _toDoModel = toDoProvider.todoList!.elementAt(i);
    _todoWidgets.add(
        ToDoItem(
            toDoProvider: toDoProvider,
            toDoModel: _toDoModel
        )
    );
  }
  print("get Item Done");
  return _todoWidgets;
}