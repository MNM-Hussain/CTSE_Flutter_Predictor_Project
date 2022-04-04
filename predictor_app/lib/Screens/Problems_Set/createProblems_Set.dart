import 'package:predictor_app/Database/problems_SetDB.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:predictor_app/Screens/Problems_Set/viewProblem_Set.dart';

class CreateProblemsSet extends StatefulWidget {
  CreateProblemsSet({Key? key, required this.dbp}) : super(key: key);
  DatabaseProblemSet dbp;
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<CreateProblemsSet> {
  late DatabaseProblemSet dbp;

  TextEditingController problemsController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dbp = DatabaseProblemSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        // backgroundColor: Color.fromARGB(255, 231, 233, 231),
        title: const Text("List Problems"),
        // actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.delete))],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                decoration: inputDecoration("Problem Age"),
                controller: ageController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                decoration: inputDecoration("Problem Listing"),
                controller: problemsController,
                maxLines: 4,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: Colors.transparent,
        child: BottomAppBar(
          color: Colors.transparent,
          child: RaisedButton(
              color: Colors.black,
              onPressed: () {
                widget.dbp.create(problemsController.text, ageController.text);
                Navigator.pop(context, true);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewProblemSet(dbp: dbp)));
              },
              child: const Text(
                "Create",
                style: TextStyle(color: Colors.white),
              )),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String labelText) {
    return InputDecoration(
      focusColor: const Color.fromARGB(255, 0, 0, 0),
      labelStyle: const TextStyle(color: Colors.black),
      labelText: labelText,
      fillColor: const Color.fromARGB(255, 3, 3, 3),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(color: Colors.black),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(
          color: Colors.black,
          width: 2.0,
        ),
      ),
    );
  }
}
