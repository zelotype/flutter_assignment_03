import 'package:cloud_firestore/cloud_firestore.dart';

class Firebase {
  static void addTask(String title) {
    Firestore.instance
        .collection('todo')
        .document()
        .setData({'title': title, 'done': false});
  }

  static void updateTask(String id, bool doneValue) {
    final DocumentReference postRef = Firestore.instance.document('todo/' + id);

    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot postSnapshot = await transaction.get(postRef);
      if (postSnapshot.exists) {
        await transaction.update(postRef, <String, dynamic>{'done': doneValue});
      }
    });
  }

  static void deleteAllTask() async {
    QuerySnapshot query = await Firestore.instance
        .collection('todo')
        .where('done', isEqualTo: true)
        .getDocuments();

    query.documents.forEach((e) => Firebase.deleteTask(e.documentID));
  }

  static void deleteTask(String documentId) {
    final DocumentReference postRef =
        Firestore.instance.document('todo/' + documentId);

    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot postSnapshot = await transaction.get(postRef);
      if (postSnapshot.exists) {
        await transaction.delete(postRef);
      }
    });
  }
}
