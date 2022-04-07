import 'package:flutter/material.dart';

class Predictor extends StatefulWidget {
  const Predictor({Key? key}) : super(key: key);

  @override
  State<Predictor> createState() => _PredictorState();
}

class _PredictorState extends State<Predictor> {
  @override
  Widget build(BuildContext context) {
    final PredictorButton = Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color: Colors.redAccent,
        child: MaterialButton(
          padding: EdgeInsets.fromLTRB(30, 15, 20, 20),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            // signUp(emailEditingController.text, passwordEditingController.text);
          },
          child: Text(
            'Predictor',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ));

    return Center(
      child: Column(children: [
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
