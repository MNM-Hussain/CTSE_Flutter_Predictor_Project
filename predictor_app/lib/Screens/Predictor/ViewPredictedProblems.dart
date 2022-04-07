import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:predictor_app/models/ProblemSetModel.dart';
import 'package:predictor_app/models/UserModel.dart';

class ViewPredictedProblems extends StatefulWidget {
  ViewPredictedProblems({Key? key}) : super(key: key);

  @override
  State<ViewPredictedProblems> createState() => _ViewPredictedProblemsState();
}

class _ViewPredictedProblemsState extends State<ViewPredictedProblems> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? loggedInUser = UserModel();
  ProblemSetModel? problemsModel = ProblemSetModel();
  FirebaseFirestore firebaseFirestoreinstance = FirebaseFirestore.instance;
  var problems = [];
  late Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('RegularProblemForm')
      .where('age', isEqualTo: '29')
      .snapshots();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      retrieveProblems();
    });
  }

  void retrieveProblems() async {
    String? age = loggedInUser!.age;
    age = (int.parse(age!) + 5).toString();

    _usersStream = await FirebaseFirestore.instance
        .collection("RegularProblemForm")
        .where('age', isEqualTo: age)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text("Predictions"),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.delete))],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }
                return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;

                    return Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.star),
                            title: Text(data['problem']),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
