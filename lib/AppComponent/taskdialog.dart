import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../Model/todoModel.dart';
import '../Providers/todoprovider.dart';

class TaskDialogHelper {
  static void showAddTaskDialog(BuildContext context) {
    final TextEditingController taskController = TextEditingController();
    DateTime? selectedDueDate;
    TimeOfDay? selectedDueTime;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: taskController,
                decoration: InputDecoration(labelText: 'Task'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      selectedDueDate = date;
                      selectedDueTime = time;
                    }
                  }
                },
                child: Text('Select Due Date'),
              ),
              if (selectedDueDate != null && selectedDueTime != null)
                Text('Due: ${DateFormat('yyyy-MM-dd').format(selectedDueDate!)} '
                    '${selectedDueTime!.format(context)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final task = taskController.text;
                if (task.isNotEmpty) {
                  final newTodo = Todo(
                    id: '',
                    task: task,
                    isDone: false,
                    createdOn: Timestamp.now(),
                    updatedOn: Timestamp.now(),
                    dueDateTime: selectedDueDate != null
                        ? Timestamp.fromDate(
                      DateTime(
                        selectedDueDate!.year,
                        selectedDueDate!.month,
                        selectedDueDate!.day,
                        selectedDueTime!.hour,
                        selectedDueTime!.minute,
                      ),
                    )
                        : null,
                  );
                  Provider.of<TodoProvider>(context, listen: false).addTodo(newTodo);
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
              child: Text('Add Task'),
            ),
          ],
        );
      },
    );
  }

  static void showEditTaskDialog(BuildContext context, Todo todo) {
    final TextEditingController taskController = TextEditingController(text: todo.task);
    DateTime? selectedDueDate = todo.dueDateTime?.toDate();
    TimeOfDay? selectedDueTime = selectedDueDate != null
        ? TimeOfDay(hour: selectedDueDate.hour, minute: selectedDueDate.minute)
        : null;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: taskController,
                decoration: InputDecoration(labelText: 'Task'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: selectedDueDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: selectedDueTime ?? TimeOfDay.now(),
                    );
                    if (time != null) {
                      selectedDueDate = date;
                      selectedDueTime = time;
                    }
                  }
                },
                child: Text('Select Due Date'),
              ),
              if (selectedDueDate != null && selectedDueTime != null)
                Text('Due: ${DateFormat('yyyy-MM-dd').format(selectedDueDate!)} '
                    '${selectedDueTime!.format(context)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final task = taskController.text;
                if (task.isNotEmpty) {
                  final updatedTodo = todo.copyWith(
                    task: task,
                    updatedOn: Timestamp.now(),
                    dueDateTime: selectedDueDate != null
                        ? Timestamp.fromDate(
                      DateTime(
                        selectedDueDate!.year,
                        selectedDueDate!.month,
                        selectedDueDate!.day,
                        selectedDueTime!.hour,
                        selectedDueTime!.minute,
                      ),
                    )
                        : null,
                  );
                  Provider.of<TodoProvider>(context, listen: false)
                      .updateTodo(updatedTodo);
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
              child: Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }


  static void deleteTask(BuildContext context, String id) {
    Provider.of<TodoProvider>(context, listen: false).deleteTodo(id);
  }

  static void toggleTaskCompletion(BuildContext context, Todo todo) {
    final updatedTodo = todo.copyWith(
      isDone: !todo.isDone,
      updatedOn: Timestamp.now(),
    );
    Provider.of<TodoProvider>(context, listen: false).updateTodo(updatedTodo);
  }
}