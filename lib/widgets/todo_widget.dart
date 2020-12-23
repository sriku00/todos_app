import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/Models/todo_model.dart';
import 'package:todo_app/Screens/edit_todo_screen.dart';
import 'package:todo_app/Services/riverpod_services.dart';
import 'package:todo_app/Utils/utils.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;

  const TodoWidget({
    @required this.todo,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          key: Key(todo.id),
          actions: [
            IconSlideAction(
              color: Colors.green,
              onTap: () => editTodos(context, todo),
              caption: 'Edit',
              icon: Icons.edit,
            )
          ],
          secondaryActions: [
            IconSlideAction(
              color: Colors.red,
              caption: 'Delete',
              onTap: () => deleteTodos(context, todo),
              icon: Icons.delete,
            )
          ],
          child: buildTodo(context),
        ),
      );

  Widget buildTodo(BuildContext context) => Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Checkbox(
              activeColor: Theme.of(context).primaryColor,
              checkColor: Colors.white,
              value: todo.isDone,
              onChanged: (_) => toogleTodos(context, todo),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                      fontSize: 22,
                    ),
                  ),
                  if (todo.description.isNotEmpty)
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Text(
                        todo.description,
                        style: TextStyle(fontSize: 20, height: 1.5),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      );

  editTodos(BuildContext context, Todo todo) => Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => EditTodosScreen(todo: todo,)),
  );

  toogleTodos(BuildContext context, Todo todo) {
    final todos = context.read(todosProvider);
    final isDone = todos.toggleTodosStatus(todo);
    Utils.showSnackBar(
      context,
      isDone ? "Task completed" : "Task Incompleted",
    );
  }
}

void deleteTodos(BuildContext context, Todo todo) {
  final todos = context.read(todosProvider);
  todos.deleteTodos(todo);
  Utils.showSnackBar(context, "Task Deleted");
}
