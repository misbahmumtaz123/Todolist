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

  Future<void> addTodo(Todo todo) async {
    try {
      await _firestore.collection('Todos').add(todo.toJson());
      await fetchTodos();
    } catch (e) {
      print("Error adding todo: $e");
    }
  }

  Future<void> updateTodo(Todo todo) async {
    try {
      await _firestore.collection('Todos').doc(todo.id).update(todo.toJson());
      await fetchTodos();
    } catch (e) {
      print("Error updating todo: $e");
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      await _firestore.collection('Todos').doc(id).delete();
      await fetchTodos();
    } catch (e) {
      print("Error deleting todo: $e");
    }
  }

  void toggleTaskCompletion(Todo todo) async {
    final updatedTodo = todo.copyWith(isDone: !todo.isDone, updatedOn: Timestamp.now());
    await updateTodo(updatedTodo);
  }
}
