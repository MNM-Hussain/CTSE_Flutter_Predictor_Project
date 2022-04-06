import 'package:flutter/material.dart';
import 'package:predictor_app/Database/regularProblemDB.dart';
import 'package:predictor_app/Screens/RegularProblems/EditRegularProblem.dart';
import 'package:predictor_app/Screens/RegularProblems/createRegularProblemForm.dart';

class ViewRegularProblem extends StatefulWidget {
  ViewRegularProblem({Key? key}) : super(key: key);

  @override
  State<ViewRegularProblem> createState() => _ViewRegularProblemState();
}

class _ViewRegularProblemState extends State<ViewRegularProblem> {
  late DatabaseRegularProblem dbr;
  List docs = [];

  regularProblemViewinitialize() {
    dbr = DatabaseRegularProblem();
    dbr.regularProblemIntialized();
    dbr.read().then((value) => {
          setState(() {
            docs = value;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    regularProblemViewinitialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: docs.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  contentPadding:
                      const EdgeInsets.only(right: 30, left: 36, top: 12),
                  title: Text(docs[index]['username']),
                  trailing: Text("Age: " + docs[index]['age']),
                  subtitle: Text(docs[index]['problem']),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Delete Confirmation'),
                                content: const Text(
                                    'Are you sure you Want to delete this data?'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        dbr.delete(docs[index]['id']);
                                        Navigator.pop(context, 'confirm');
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewRegularProblem()));
                                      },
                                      child: const Text('confirm')),
                                ],
                              ),
                            )),
                    const SizedBox(width: 8),
                    IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.pop(context, true);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UpdateRegularProblemForm(
                                        regularProblem: docs[index],
                                        dbr: dbr,
                                      ))).then((value) => {
                                if (value != null)
                                  {regularProblemViewinitialize()}
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
                  builder: (context) => CreateRegularProblemForm(dbr: dbr)));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
