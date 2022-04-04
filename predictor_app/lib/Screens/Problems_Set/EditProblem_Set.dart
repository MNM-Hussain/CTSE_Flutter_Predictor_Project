import 'package:predictor_app/Database/problems_SetDB.dart';
import 'package:predictor_app/Screens/Problems_Set/viewProblem_Set.dart';
import 'package:predictor_app/Screens/RegularProblems/viewRegularProblem.dart';
import '../../Database/regularProblemDB.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class UpdateProblemSet extends StatefulWidget {
  UpdateProblemSet({Key? key, required this.problemSet, required this.dbp})
      : super(key: key);
  DatabaseProblemSet dbp;
  Map problemSet;
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<UpdateProblemSet> {
  late DatabaseProblemSet dbp;

  TextEditingController ageController = TextEditingController();
  TextEditingController problemsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dbp = DatabaseProblemSet();
    ageController.text = widget.problemSet['age'];
    problemsController.text = widget.problemSet['problems'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        // backgroundColor: Color.fromARGB(255, 231, 233, 231),
        title: const Text("Problems Set"),
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
                decoration: inputDecoration("Age"),
                controller: ageController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                decoration: inputDecoration("ProblemsSet"),
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
                widget.dbp.update(widget.problemSet['id'], ageController.text,
                    problemsController.text);

                Navigator.pop(context, true);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewProblemSet(dbp: dbp)));
              },
              child: const Text(
                "Update",
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
