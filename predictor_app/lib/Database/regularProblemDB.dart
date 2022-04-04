import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseRegularProblem {
  late FirebaseFirestore firestore;
  regularProblemIntialized() {
    firestore = FirebaseFirestore.instance;
  }

  Future<void> create(String username, String age, String problem) async {
    try {
      await firestore.collection("RegularProblemForm").add({
        'username': username,
        'age': age,
        'problem': problem,
        'timestamp':
            FieldValue.serverTimestamp() //this is to get the server timeStamp
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      await firestore.collection("RegularProblemForm").doc(id).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<List> read() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot = await firestore
          .collection('RegularProblemForm')
          .orderBy('timestamp')
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map a = {
            "id": doc.id,
            "username": doc['username'],
            "age": doc['age'],
            "problem": doc['problem']
          };
          docs.add(a);
        }
        return docs;
      }
    } catch (e) {
      // print(e);
    }
    return [];
  }

  Future<void> update(
      String id, String username, String age, String problem) async {
    try {
      await firestore
          .collection("RegularProblemForm")
          .doc(id)
          .update({'username': username, 'age': age, 'problem': problem});
    } catch (e) {
      print(e);
    }
  }
}
