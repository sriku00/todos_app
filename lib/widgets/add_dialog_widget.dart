import 'package:flutter/material.dart';
import 'package:todo_app/Models/todo_model.dart';
import 'package:todo_app/Services/riverpod_services.dart';
import 'package:todo_app/Utils/utils.dart';
import 'package:todo_app/widgets/todo_form_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddTodoDialogWidget extends StatefulWidget {
  @override
  _AddTodoDialogWidgetState createState() => _AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends State<AddTodoDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Todo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 8),
              TodoFormWidget(
                onChangedTitle: (title) => setState(() => this.title = title),
                onChangedDescription: (description) =>
                    setState(() => this.description = description),
                onSavedTodo: onSave,
              ),
            ],
          ),
        ),
      );

  void onSave() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    } else {
      final todo = Todo(
        createdTime: DateTime.now(),
        title: title,
        description: description,
        id: DateTime.now().toString(),
      );
      final todoProvider = context.read(todosProvider);
      todoProvider.addTodos(todo);
      Utils.showSnackBar(context, "Todo Added");
      Navigator.of(context).pop();
    }
  }
}
