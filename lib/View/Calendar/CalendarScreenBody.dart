import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../AppComponent/taskdialog.dart';
import '../../Model/todoModel.dart';
import '../../Providers/todoprovider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarScreenBody extends StatefulWidget {
  @override
  _CalendarScreenBodyState createState() => _CalendarScreenBodyState();
}

class _CalendarScreenBodyState extends State<CalendarScreenBody> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  TextEditingController _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime(2020),
            lastDay: DateTime(2030),
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: (day) {
              return _getTasksForDay(day);
            },
            calendarStyle: CalendarStyle(
              todayTextStyle: TextStyle(color: Colors.purple),
              todayDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.transparent,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.purple,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Colors.purple,
                shape: BoxShape.rectangle,
              ),
              markersMaxCount: 1,
              markersAlignment: Alignment.bottomCenter,
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: _buildTaskList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(),
        child: Icon(Icons.add),
      ),
    );
  }

  List<Todo> _getTasksForDay(DateTime day) {
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    return todoProvider.todos.where((todo) {
      final dueDate = todo.dueDateTime?.toDate();
      return dueDate != null && isSameDay(day, dueDate);
    }).toList();
  }

  Widget _buildTaskList() {
    return Consumer<TodoProvider>(
      builder: (context, todoProvider, child) {
        final dayTasks = _getTasksForDay(_selectedDay ?? DateTime.now());
        return ListView.builder(
          itemCount: dayTasks.length,
          itemBuilder: (context, index) {
            final todo = dayTasks[index];
            return ListTile(
              title: Text(
                todo.task,
                style: TextStyle(
                  decoration: todo.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.check_circle, color: todo.isDone ? Colors.purple : Colors.grey),
                    onPressed: () {
                      TaskDialogHelper.toggleTaskCompletion(context, todo);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      Provider.of<TodoProvider>(context, listen: false)
                          .deleteTodo(todo.id);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Task'),
        content: TextField(
          controller: _taskController,
          decoration: InputDecoration(hintText: 'Enter your task'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (_taskController.text.isNotEmpty && _selectedDay != null) {
                final newTodo = Todo(
                  id: '',
                  task: _taskController.text,
                  isDone: false,
                  createdOn: Timestamp.now(),
                  updatedOn: Timestamp.now(),
                  dueDateTime: Timestamp.fromDate(_selectedDay!),
                );

                Provider.of<TodoProvider>(context, listen: false)
                    .addTodo(newTodo);
                _taskController.clear();
                Navigator.pop(context);
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}
