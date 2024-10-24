// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class Todo {
//   String id;
//   String task;
//   bool isDone;
//   Timestamp createdOn;
//   Timestamp updatedOn;
//   Timestamp? dueDateTime; // This will store both date and time
//
//   Todo({
//     required this.id,
//     required this.task,
//     required this.isDone,
//     required this.createdOn,
//     required this.updatedOn,
//     this.dueDateTime,
//   });
//
//   // Converts JSON to Todo
//   factory Todo.fromJson(Map<String, dynamic> json, String id) {
//     return Todo(
//       id: id,
//       task: json['task'] as String,
//       isDone: json['isDone'] as bool,
//       createdOn: json['createdOn'] as Timestamp,
//       updatedOn: json['updatedOn'] as Timestamp,
//       dueDateTime: json['dueDateTime'] as Timestamp?,
//     );
//   }
//
//   // Converts Todo to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'task': task,
//       'isDone': isDone,
//       'createdOn': createdOn,
//       'updatedOn': updatedOn,
//       'dueDateTime': dueDateTime,
//     };
//   }
//
//   // Converts Firestore DocumentSnapshot to Todo
//   factory Todo.fromFirestore(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//     return Todo(
//       id: doc.id,
//       task: data['task'] ?? '',
//       isDone: data['isDone'] ?? false,
//       createdOn: data['createdOn'] ?? Timestamp.now(), // Default to now if null
//       updatedOn: data['updatedOn'] ?? Timestamp.now(), // Default to now if null
//       dueDateTime: data['dueDateTime'] as Timestamp?,
//     );
//   }
//
//   // Creates a copy of Todo with optional fields
//   Todo copyWith({
//     String? id,
//     String? task,
//     bool? isDone,
//     Timestamp? createdOn,
//     Timestamp? updatedOn,
//     Timestamp? dueDateTime,
//   }) {
//     return Todo(
//       id: id ?? this.id,
//       task: task ?? this.task,
//       isDone: isDone ?? this.isDone,
//       createdOn: createdOn ?? this.createdOn,
//       updatedOn: updatedOn ?? this.updatedOn,
//       dueDateTime: dueDateTime ?? this.dueDateTime,
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String id;
  String task;
  bool isDone;
  Timestamp createdOn;
  Timestamp updatedOn;
  Timestamp? dueDateTime;

  Todo({
    required this.id,
    required this.task,
    required this.isDone,
    required this.createdOn,
    required this.updatedOn,
    this.dueDateTime,
  });

  // Converts JSON to Todo
  factory Todo.fromJson(Map<String, dynamic> json, String id) {
    return Todo(
      id: id,
      task: json['task'] as String,
      isDone: json['isDone'] as bool,
      createdOn: json['createdOn'] as Timestamp,
      updatedOn: json['updatedOn'] as Timestamp,
      dueDateTime: json['dueDateTime'] as Timestamp?,
    );
  }

  // Converts Todo to JSON
  Map<String, dynamic> toJson() {
    return {
      'task': task,
      'isDone': isDone,
      'createdOn': createdOn,
      'updatedOn': updatedOn,
      'dueDateTime': dueDateTime,
    };
  }

  // Converts Firestore DocumentSnapshot to Todo
  factory Todo.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Todo(
      id: doc.id,
      task: data['task'] ?? '',
      isDone: data['isDone'] ?? false,
      createdOn: data['createdOn'] ?? Timestamp.now(), // Default to now if null
      updatedOn: data['updatedOn'] ?? Timestamp.now(), // Default to now if null
      dueDateTime: data['dueDateTime'] as Timestamp?,
    );
  }

  // Creates a copy of Todo with optional fields
  Todo copyWith({
    String? id,
    String? task,
    bool? isDone,
    Timestamp? createdOn,
    Timestamp? updatedOn,
    Timestamp? dueDateTime,
  }) {
    return Todo(
      id: id ?? this.id,
      task: task ?? this.task,
      isDone: isDone ?? this.isDone,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn,
      dueDateTime: dueDateTime ?? this.dueDateTime,
    );
  }
}

