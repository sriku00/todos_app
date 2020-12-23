import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:todo_app/Services/riverpod_services.dart';
import 'package:todo_app/widgets/todo_widget.dart';

class TodoListWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final todsProvider = useProvider(todosProvider);
    final todos = todsProvider.todos;
    return todos.isEmpty
        ? Center(
            child: Text(
              "No Todos",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          )
        : ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(15),
            itemCount: todos.length,
            separatorBuilder: (BuildContext context, int index) => Divider(
              color: Colors.grey,
            ),
            itemBuilder: (context, index) {
              final todo = todos[index];
              return TodoWidget(
                todo: todo,
              );
            },
          );
  }
}
