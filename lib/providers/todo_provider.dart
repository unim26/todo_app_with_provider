import 'package:flutter/material.dart';
import 'package:todo_provider/models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoModel> _todos = [];

  //get todos
  List<TodoModel> get todos => _todos;

  //add todos
  void addtodo(TodoModel todo) {
    _todos.add(todo);
    notifyListeners();
  }

  //delete a todo
  void deletetodo(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }

  //update todo status
  void updatetodostatus(bool value, int index) {
    _todos[index].iscompleted = value;
    notifyListeners();
  }

  //update todo
  void updatetodo(int index, TodoModel todo) {
    _todos.insert(index, todo);
    notifyListeners();
  }
}
