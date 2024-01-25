
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/ToDoModel.dart';

import 'ToDoProvider.dart';

class ToDoItem extends StatelessWidget {
  ToDoItem({super.key, required this.toDoProvider, required this.toDoModel});

  final ToDoProvider toDoProvider ;
  final ToDoModel toDoModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text(toDoModel.title),
        onTap: () {
          print("On Tap ToDo Tile = ${toDoModel.title}");
          },
        subtitle: Text(
            toDoModel.updatedDate == null?"Created On ${toDoModel.createdDate}"
                :"Updated on ${toDoModel.updatedDate}"
        ),
        leading: Checkbox(
            value: toDoModel.isFinished,
            onChanged: (bool? value){
              print("onChnaged checkBox Value = ${value}");
              toDoModel.isFinished = !toDoModel.isFinished;
              toDoProvider.toggleFinishedStatus(toDoModel);
            },
        ),
        trailing: GestureDetector (
          onTap: () {
            print("Delete Icon Tap");
            toDoProvider.deleteToDoItem(toDoModel);
            },
          child: Icon(
            Icons.delete,
          ),
        ),
      ),
    );
  }
}