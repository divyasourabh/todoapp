import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/ToDoModel.dart';
import 'package:todoapp/ToDoProvider.dart';

import 'ToDoList.dart';

void main() {
//  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      MaterialApp(
        title: "My ToDo List",
          home: ToDoList()
      ));
}