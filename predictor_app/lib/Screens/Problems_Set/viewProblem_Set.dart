import 'package:flutter/material.dart';
import 'package:predictor_app/Database/problems_SetDB.dart';
import 'package:predictor_app/Screens/Problems_Set/EditProblem_Set.dart';
import 'package:predictor_app/Screens/Problems_Set/createProblems_Set.dart';
import 'package:predictor_app/Screens/RegularProblems/EditRegularProblem.dart';
import 'package:predictor_app/Screens/RegularProblems/createRegularProblemForm.dart';

class ViewProblemSet extends StatefulWidget {
  ViewProblemSet({Key? key, required this.dbp}) : super(key: key);
  DatabaseProblemSet dbp;

  @override
  State<ViewProblemSet> createState() => _ViewProblemSetState();
}

class _ViewProblemSetState extends State<ViewProblemSet> {
  late DatabaseProblemSet dbp;
  List docs = [];

  problemSetViewinitialize() {
    dbp = DatabaseProblemSet();
    dbp.problemSetIntialized();
    dbp.read().then((value) => {
          setState(() {
            docs = value;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    problemSetViewinitialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        // backgroundColor: Color.fromARGB(255, 231, 233, 231),
        title: const Text("List of Problems Set"),
        // actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.delete))],
      ),
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
                  // title: Text(docs[index]['username']),
                  title: Text("Age: " + docs[index]['age']),
                  subtitle: Text(docs[index]['problems']),
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
                                        widget.dbp.delete(docs[index]['id']);
                                        Navigator.pop(context, 'confirm');
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewProblemSet(dbp: dbp)));
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
                                  builder: (context) => UpdateProblemSet(
                                        problemSet: docs[index],
                                        dbp: dbp,
                                      ))).then((value) => {
                                if (value != null) {problemSetViewinitialize()}
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
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateProblemsSet(dbp: dbp)));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
