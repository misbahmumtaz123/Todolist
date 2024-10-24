import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Model/todoModel.dart';

class TodoProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Todo> _todos = [];
  bool _isLoading = true;

  List<Todo> get todos => _todos;
  bool get isLoading => _isLoading;

  Future<void> fetchTodos() async {
    _isLoading = true;
    notifyListeners(); // Notify listeners about loading state
    try {
      final snapshot = await _firestore.collection('Todos').get();  // Use correct collection name
      _todos = snapshot.docs.map((doc) => Todo.fromFirestore(doc)).toList();
    } catch (e) {
      print("Error fetching todos: $e");
    } finally {
      _isLoading = false;
      notifyListeners();  // Ensure listeners are notified
    }
  }

  Future<void> addTodo(Todo todo) async {
    try {
      await _firestore.collection('Todos').add(todo.toJson());
      await fetchTodos();  // Refetch todos after adding a new one
    } catch (e) {
      print("Error adding todo: $e");
    }
  }

  Future<void> updateTodo(Todo todo) async {
    try {
      await _firestore.collection('Todos').doc(todo.id).update(todo.toJson());
      await fetchTodos();  // Refetch todos after updating
    } catch (e) {
      print("Error updating todo: $e");
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      await _firestore.collection('Todos').doc(id).delete();
      await fetchTodos();  // Refetch todos after deleting
    } catch (e) {
      print("Error deleting todo: $e");
    }
  }
}

