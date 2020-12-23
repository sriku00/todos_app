import 'package:flutter/material.dart';
import 'package:todo_app/widgets/add_dialog_widget.dart';
import 'package:todo_app/widgets/completed_todos_widget.dart';
import 'package:todo_app/widgets/todo_list_widget.dart';
import 'package:todo_app/widgets/todo_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final tabs = [
      TodoListWidget(),
      CompletedTodos(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Todos"),
      ),
      body: tabs[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        elevation: 20,
        items: [
          BottomNavigationBarItem(
            label: "Todos",
            icon: Icon(
              Icons.fact_check_outlined,
            ),
          ),
          BottomNavigationBarItem(
            label: "completed",
            icon: Icon(Icons.done),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19),
            side: BorderSide(width: 2, color: Colors.purpleAccent)),
        child: Icon(
          Icons.add,
          size: 36,
        ),
        onPressed: () => showDialog(
          context: context,
          barrierDismissible: true,

          // ignore: deprecated_member_use
          child: AddTodoDialogWidget(),
        ),
      ),
    );
  }
}
