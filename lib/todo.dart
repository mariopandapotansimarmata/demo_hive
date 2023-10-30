import 'package:demo_hive/add_todo.dart';
import 'package:demo_hive/model/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'main.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  late Box<Todo> _myBox;

  @override
  void initState() {
    super.initState();
    _myBox = Hive.box(boxName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
      ),
      body: ValueListenableBuilder(
        valueListenable: _myBox.listenable(),
        builder: (context, Box<Todo> box, _) {
          if (_myBox.values.isEmpty) {
            return Center(
              child: Text('Todo listing is Empty'),
            );
          }

          return ListView.builder(
            itemCount: _myBox.values.length,
            itemBuilder: (context, index) {
              Todo? res = box.getAt(index);
              return Dismissible(
                background: Container(
                  color: Colors.red,
                ),
                key: UniqueKey(),
                onDismissed: (direction) {
                  _myBox.deleteAt(index);
                },
                child: ListTile(
                  title: Text(res!.title),
                  subtitle: Text(res!.description),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddTodo()));
          }),
    );
  }
}
