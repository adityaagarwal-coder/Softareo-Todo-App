import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  updateTask(Map<String, dynamic> taskMap, String documentId) {
    FirebaseFirestore.instance
        .collection("tasks")
        .doc(documentId)
        .set(taskMap, SetOptions(merge: true));
  }

  dynamic createTask(Map<String, dynamic> taskMap) {
    FirebaseFirestore.instance.collection("tasks").add(taskMap);
  }

  getTasks() async {
    return await FirebaseFirestore.instance.collection("tasks").snapshots();
  }

  deleteTask(String documentId) {
    FirebaseFirestore.instance
        .collection("tasks")
        .doc(documentId)
        .delete()
        .catchError((e) {
      print(e.toString());
    });
  }
}
