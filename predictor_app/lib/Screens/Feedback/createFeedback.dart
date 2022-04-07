import 'package:fluttertoast/fluttertoast.dart';
import 'package:predictor_app/Database/feedbackDB.dart';
import 'package:predictor_app/Screens/BottomNavigation/BottomNavigation.dart';
import 'package:flutter/material.dart';

class CreateFeedback extends StatefulWidget {
  CreateFeedback({Key? key, required this.dbf}) : super(key: key);
  DatabaseFeedBack dbf;
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<CreateFeedback> {
  late DatabaseFeedBack dbf;

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dbf = DatabaseFeedBack();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Feedback"),
        // actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.delete))],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                decoration: inputDecoration("User Name"),
                controller: userNameController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                decoration: inputDecoration("User Email"),
                controller: emailController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                decoration: inputDecoration("User Age"),
                controller: ageController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                decoration: inputDecoration("Leave a Comment"),
                controller: commentController,
                maxLines: 5,
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
          child: MaterialButton(
              color: Colors.redAccent,
              elevation: 5,
              splashColor: Colors.blueGrey,
              onPressed: () {
                widget.dbf.create(
                    userNameController.text,
                    // int.parse(ageController.text),
                    emailController.text,
                    ageController.text,
                    commentController.text);
                Navigator.pop(context, true);
                Fluttertoast.showToast(
                    msg: 'Successfuly Created !',
                    backgroundColor: Colors.green);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BottomNavigation()));
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
        borderSide: const BorderSide(color: Colors.blueGrey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(
          color: Colors.blueGrey,
          width: 2.0,
        ),
      ),
    );
  }
}
