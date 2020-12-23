import 'package:flutter/material.dart';

import 'package:hooks_riverpod/all.dart';
import 'package:todo_app/Models/todo_model.dart';
import 'package:todo_app/widgets/completed_todos_widget.dart';

final todosProvider = ChangeNotifierProvider<TodosProvider>((ref) {
  return TodosProvider();
});

class TodosProvider extends ChangeNotifier {
  List<Todo> _todos = [];
  Todo _todo;

  // in completed todos
  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();
//completed todos
  List<Todo> get completedTodos =>
      _todos.where((todo) => todo.isDone == true).toList();

  // get todos

  void getTodos() async {
    ;
    notifyListeners();
  }

  // Add todos
  void addTodos(Todo todo) async {
    ;
    notifyListeners();
  }

  void deleteTodos(Todo todo) async {
    notifyListeners();
  }

  void editTodos(Todo todo) {
    notifyListeners();
  }

  bool toggleTodosStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    notifyListeners();
    return todo.isDone;
  }

  // update todos
  void updateTodo(Todo todo, String title, String description) {
    todo.title = title;
    todo.description = description;

    notifyListeners();
  }
}
