import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:predictor_app/Database/feedbackDB.dart';
import 'package:predictor_app/Screens/Drawer/drawerMenu.dart';
import 'package:predictor_app/Screens/Feedback/createFeedback.dart';
import 'package:predictor_app/Screens/Feedback/editFeedback.dart';

import '../BottomNavigation/BottomNavigation.dart';

class ViewFeedback extends StatefulWidget {
  ViewFeedback({Key? key}) : super(key: key);

  @override
  State<ViewFeedback> createState() => _ViewFeedbackState();
}

class _ViewFeedbackState extends State<ViewFeedback> {
  User? user = FirebaseAuth.instance.currentUser;
  late DatabaseFeedBack dbf;
  List docs = [];

  feedBackViewinitialize() {
    dbf = DatabaseFeedBack();
    dbf.feedBackIntialized();
    dbf.read().then((value) => {
          setState(() {
            docs = value;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    feedBackViewinitialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text("FeedBack"),
      ),
      body: ListView.builder(
        itemCount: docs.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 5,
            margin: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  contentPadding:
                      const EdgeInsets.only(right: 30, left: 36, top: 12),
                  title: Text(docs[index]['username']),
                  // title: Text(docs[index]['email']),
                  trailing: Text("Age: " + docs[index]['age']),
                  subtitle: Text(docs[index]['comment']),
                ),
                // (Text(docs[index]['username'])),
                // (Text(docs[index]['email'])),

                // (Text("Age: " + docs[index]['age'])),
                // (Text(docs[index]['comment'])),

                if (docs[index]['userUid'] == user!.uid)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Delete Confirmation'),
                                  content: const Text(
                                      'Are you sure you Want to delete this feedback?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          dbf.delete(docs[index]['id']);
                                          Navigator.pop(context, 'confirm');
                                          Fluttertoast.showToast(
                                              msg: 'Successfuly Deleted !',
                                              backgroundColor: Colors.green);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BottomNavigation()));
                                        },
                                        child: const Text('confirm')),
                                  ],
                                ),
                              )),
                      const SizedBox(width: 8),
                      IconButton(
                          icon: const Icon(Icons.edit),
                          color: Colors.blueGrey,
                          onPressed: () {
                            Navigator.pop(context, true);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateFeedback(
                                          feedBack: docs[index],
                                          dbf: dbf,
                                        ))).then((value) => {
                                  if (value != null) {feedBackViewinitialize()}
                                });
                          }),
                      const SizedBox(width: 8),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateFeedback(dbf: dbf)));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
