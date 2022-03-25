import '../database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class View extends StatefulWidget {
  View({required this.country, required this.db});
  Map country;
  Database db;
  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    print(widget.country);
    nameController.text = widget.country['name'];
    codeController.text = widget.country['code'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(56, 75, 49, 1.0),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(56, 75, 49, 1.0),
        title: const Text("Country View"),
        actions: [
          IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                widget.db.delete(widget.country["id"]);
                Navigator.pop(context, true);
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: inputDecoration("Country Name"),
                controller: nameController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: inputDecoration("Country Code"),
                controller: codeController,
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
                widget.db.update(widget.country['id'], nameController.text,
                    codeController.text);
                Navigator.pop(context, true);
              },
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.white),
              )),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String labelText) {
    return InputDecoration(
      focusColor: Colors.white,
      labelStyle: const TextStyle(color: Colors.white),
      labelText: labelText,
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(color: Colors.white),
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
