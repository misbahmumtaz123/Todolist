import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Model/todoModel.dart';

class TodoProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Todo> _todos = [];
  bool _isLoading = true;

  List<Todo> get todos => _todos;
  bool get isLoading => _isLoading;

  int get completedTaskCount => _todos.where((todo) => todo.isDone).length;
  int get pendingTaskCount => _todos.where((todo) => !todo.isDone).length;

  // Fetches the todos from Firestore and updates the list
  Future<void> fetchTodos() async {
    _isLoading = true;
    notifyListeners();
    try {
      final snapshot = await _firestore.collection('Todos').get();
      _todos = snapshot.docs.map((doc) => Todo.fromFirestore(doc)).toList();
    } catch (e) {
      print("Error fetching todos: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Adds a new todo to Firestore and updates the local list
  Future<void> addTodo(Todo todo) async {
    try {
      await _firestore.collection('Todos').add(todo.toJson());
      await fetchTodos();
    } catch (e) {
      print("Error adding todo: $e");
    }
  }

  // Updates an existing todo in Firestore and refreshes the list
  Future<void> updateTodo(Todo todo) async {
    try {
      await _firestore.collection('Todos').doc(todo.id).update(todo.toJson());
      await fetchTodos();
    } catch (e) {
      print("Error updating todo: $e");
    }
  }

  // Deletes a todo from Firestore and refreshes the list
  Future<void> deleteTodo(String id) async {
    try {
      await _firestore.collection('Todos').doc(id).delete();
      await fetchTodos();
    } catch (e) {
      print("Error deleting todo: $e");
    }
  }

  // Toggles the completion status of a todo and updates it in Firestore
  Future<void> toggleTaskCompletion(Todo todo) async {
    final updatedTodo = todo.copyWith(
      isDone: !todo.isDone,
      updatedOn: Timestamp.now(),
    );
    await updateTodo(updatedTodo);
  }
}

