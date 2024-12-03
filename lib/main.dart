import 'package:flutter/material.dart';

void main() => runApp(const TodoApp());

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        title: 'Todo List',
        home:  const TodoList()
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  createState() =>  TodoListState();
}

class TodoListState extends State<TodoList> {
  final List<String> _todoItems = [];

  void _addTodoItem(String task) {
    if(task.isNotEmpty) {
      setState(() => _todoItems.add(task));
    }
  }

  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return  AlertDialog(
              title:  Text('"${_todoItems[index]}"'),
              actions: <Widget>[
                FloatingActionButton(
                    child: const Text('Cancelar'),
                    onPressed: () => Navigator.of(context).pop()
                ),
                 FloatingActionButton(
                    child: const Text('Concluir'),
                    onPressed: () {
                      _removeTodoItem(index);
                      Navigator.of(context).pop();
                    }
                )
              ]
          );
        }
    );
  }

  // Build the whole list of todo items
  Widget _buildTodoList() {
    return  ListView.builder(
      itemBuilder: (context, index) {
        if(index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }
        return null;
      },
    );
  }

  // Build a single todo item
  Widget _buildTodoItem(String todoText, int index) {
    return  ListTile(
        title: Text(todoText),
        onTap: () => _promptRemoveTodoItem(index)
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
          title: const Text('Lista Atividade')
      ),
      body: _buildTodoList(),
      floatingActionButton:  FloatingActionButton(
          onPressed: _pushAddTodoScreen,
          tooltip: 'nova atividade',
          child: const Icon(Icons.add)
      ),
    );
  }

  void _pushAddTodoScreen() {
    // Push this page onto the stack
    Navigator.of(context).push(
      // MaterialPageRoute will automatically animate the screen entry, as well as adding
      // a back button to close it
         MaterialPageRoute(
            builder: (context) {
              return  Scaffold(
                  appBar:  AppBar(
                      title: const Text('Nova Atividade')
                  ),
                  body:  TextField(
                    autofocus: true,
                    onSubmitted: (val) {
                      _addTodoItem(val);
                      Navigator.pop(context);
                    },
                    decoration: const InputDecoration(
                        hintText: 'Nome Da Atividade',
                        contentPadding:  EdgeInsets.all(16.0)
                    ),

                  )
              );
            }
        )
    );
  }
}