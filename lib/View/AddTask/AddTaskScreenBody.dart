import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../AppComponent/taskdialog.dart';
import '../../Providers/todoprovider.dart';

class AddTaskScreenBody extends StatefulWidget {
  const AddTaskScreenBody({super.key});

  @override
  _AddTaskScreenBodyState createState() => _AddTaskScreenBodyState();
}

class _AddTaskScreenBodyState extends State<AddTaskScreenBody> {
  @override
  void initState() {
    super.initState();
    Provider.of<TodoProvider>(context, listen: false).fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          if (todoProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (todoProvider.todos.isEmpty) {
            return Center(
              child: Text(
                'No tasks found.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: todoProvider.todos.length,
              itemBuilder: (context, index) {
                final todo = todoProvider.todos[index];
                return Card(
                  child: ListTile(
                    leading: IconButton(
                      icon: Icon(
                        todo.isDone
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: todo.isDone ? Colors.purple : Colors.grey,
                      ),
                      onPressed: () =>
                          TaskDialogHelper.toggleTaskCompletion(context, todo),
                    ),
                    title: Text(
                      todo.task,
                      style: TextStyle(
                        decoration: todo.isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    subtitle: Text(
                      todo.dueDateTime != null
                          ? 'Due: ${DateFormat('yyyy-MM-dd').format(todo.dueDateTime!.toDate())}'
                          : 'No Due Date',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () =>
                              TaskDialogHelper.showEditTaskDialog(context, todo),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () =>
                              TaskDialogHelper.deleteTask(context, todo.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => TaskDialogHelper.showAddTaskDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
