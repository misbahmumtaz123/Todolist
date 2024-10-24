//
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../Model/todoModel.dart';
//
// const String TODO_COLLECTION_REF = "Todos";
//
// class DatabaseService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   late final CollectionReference<Todo> _todosRef;
//
//   DatabaseService() {
//     _todosRef = _firestore.collection(TODO_COLLECTION_REF).withConverter<Todo>(
//       fromFirestore: (snapshots, _) {
//         final data = snapshots.data();
//         if (data != null) {
//           return Todo.fromJson(data as Map<String, dynamic>, snapshots.id);
//         } else {
//           throw Exception('Data is null');
//         }
//       },
//       toFirestore: (todo, _) => todo.toJson(),
//     );
//   }
//
//   Stream<QuerySnapshot<Todo>> getTodo() {
//     return _todosRef.snapshots();
//   }
//
//   Future<void> addTodo(Todo todo) async {
//     await _todosRef.add(todo);
//   }
//
//   Future<void> updateTodo(Todo todo) async {
//     try {
//       await _todosRef.doc(todo.id).set(todo, SetOptions(merge: true));
//     } catch (e) {
//       print("Error updating Todo: $e");
//       throw e;
//     }
//   }
//
//   Future<void> deleteTodo(String id) async {
//     try {
//       await _todosRef.doc(id).delete();
//     } catch (e) {
//       print("Error deleting Todo: $e");
//       throw e;
//     }
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/todoModel.dart';

const String TODO_COLLECTION_REF = "Todos";

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference<Todo> _todosRef;

  DatabaseService() {
    _todosRef = _firestore.collection(TODO_COLLECTION_REF).withConverter<Todo>(
      fromFirestore: (snapshots, _) {
        final data = snapshots.data();
        if (data != null) {
          return Todo.fromJson(data as Map<String, dynamic>, snapshots.id);
        } else {
          throw Exception('Data is null');
        }
      },
      toFirestore: (todo, _) => todo.toJson(),
    );
  }

  Stream<QuerySnapshot<Todo>> getTodo() {
    return _todosRef.snapshots();
  }

  Future<void> addTodo(Todo todo) async {
    await _todosRef.add(todo);
  }

  Future<void> updateTodo(Todo todo) async {
    try {
      await _todosRef.doc(todo.id).set(todo, SetOptions(merge: true));
    } catch (e) {
      print("Error updating Todo: $e");
      throw e;
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      await _todosRef.doc(id).delete();
    } catch (e) {
      print("Error deleting Todo: $e");
      throw e;
    }
  }
}

