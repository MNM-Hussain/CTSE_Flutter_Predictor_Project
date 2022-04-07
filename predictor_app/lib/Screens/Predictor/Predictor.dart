import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:predictor_app/Screens/Problems_Set/viewProblem_Set.dart';
import 'package:predictor_app/models/ProblemSetModel.dart';
import 'package:predictor_app/models/UserModel.dart';

class Predictor extends StatefulWidget {
  const Predictor({Key? key}) : super(key: key);

  @override
  State<Predictor> createState() => _PredictorState();
}

class _PredictorState extends State<Predictor> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? loggedInUser = UserModel();
  ProblemSetModel? problems = ProblemSetModel();
  FirebaseFirestore firebaseFirestoreinstance = FirebaseFirestore.instance;

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
      setState(() {});
    });
  }

  void retreiveProblems() {
    String? age = loggedInUser!.age;
    age = (int.parse(age!) + 5).toString();

    FirebaseFirestore.instance
        .collection("RegularProblemForm")
        .where('age', isEqualTo: age)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final PredictorButton = Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color: Colors.redAccent,
        child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 15, 20),
          onPressed: () {
            retreiveProblems();
          },
          child: Text(
            'Predict Your Future',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ));

    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: 200,
                child: Image.asset(
                  "logo1.png",
                  fit: BoxFit.contain,
                )),
            PredictorButton
          ]),
    );
  }
}
