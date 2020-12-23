import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/Models/todo_model.dart';
import 'package:todo_app/Services/riverpod_services.dart';

import 'package:todo_app/widgets/todo_form_widget.dart';

class EditTodosScreen extends StatefulHookWidget {
  final Todo todo;

  const EditTodosScreen({Key key, @required this.todo}) : super(key: key);
  @override
  _EditTodosScreenState createState() => _EditTodosScreenState();
}

class _EditTodosScreenState extends State<EditTodosScreen> {
  final _formKey = GlobalKey<FormState>();

  String title;
  String description;

  @override
  void initState() {
    super.initState();

    title = widget.todo.title;
    description = widget.todo.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Todo'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              print("on pressed");
              final provider = context.read(todosProvider);

              provider.editTodos(widget.todo);

              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: TodoFormWidget(
            title: title,
            description: description,
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedDescription: (description) =>
                setState(() => this.description = description),
            onSavedTodo: saveTodo,
          ),
        ),
      ),
    );
  }

  void saveTodo() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    } else {
      final provider = context.read(todosProvider);

      provider.updateTodo(widget.todo, title, description);

      Navigator.of(context).pop();
    }
  }
}
