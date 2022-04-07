import 'package:flutter/material.dart';
import 'package:predictor_app/Screens/Predictor/ViewPredictedProblems.dart';

class Predictor extends StatefulWidget {
  const Predictor({Key? key}) : super(key: key);

  @override
  State<Predictor> createState() => _PredictorState();
}

class _PredictorState extends State<Predictor> {
  void retreiveProblems() {
    Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => ViewPredictedProblems(),
          fullscreenDialog: true,
        )).then((value) => setState(() {}));
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
