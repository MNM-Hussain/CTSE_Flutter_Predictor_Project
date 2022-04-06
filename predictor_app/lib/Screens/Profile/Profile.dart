import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:predictor_app/Screens/Drawer/drawerMenu.dart';
import 'package:predictor_app/Screens/LoginAndRegistration/Login.dart';
import 'package:predictor_app/models/UserModel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? loggedInUser = UserModel();
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

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Fluttertoast.showToast(
        msg: "Successfully Logout !", backgroundColor: Colors.redAccent);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  Future<void> deleteAccount(BuildContext context) async {
    try {
      await firebaseFirestoreinstance
          .collection("users")
          .doc(loggedInUser!.uid)
          .delete()
          .then((value) async {
        await FirebaseAuth.instance.currentUser!.delete();
        Fluttertoast.showToast(
            msg: "Account Deleted Successfully !",
            backgroundColor: Colors.redAccent);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        Fluttertoast.showToast(
            msg:
                'The user must reauthenticate before this operation can be executed.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final AlertDialog dialog = AlertDialog(
      title: Text('Cofirm Deletion?'),
      content: Text(
          "This will delete your account permanently. you won't be having access to the application."),
      actions: [
        Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(30),
            color: Colors.grey[200],
            child: MaterialButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            )),
        Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(30),
            color: Colors.redAccent,
            child: MaterialButton(
              onPressed: () => deleteAccount(context),
              child: const Text(
                'Delete',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            )),
      ],
    );

    return Scaffold(
      drawer: NavBar(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('profile'),
        actions: [
          GestureDetector(
            onTap: () {
              print("on tap works");
            },
            child: PopupMenuButton(
              icon: Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                PopupMenuItem(
                    onTap: () {
                      logout(context);
                    },
                    child: Text('Logout'))
              ],
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Center(
              //Image displaying

              child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('profile.jpg'),
                radius: 60.0,
              ),
            ),
            Divider(height: 60.0, color: Colors.grey[600]),
            const Text(
              'NAME',
              style: TextStyle(color: Colors.grey, letterSpacing: 2.0),
            ),
            //putting a space between widgets

            const SizedBox(
              height: 10.0,
            ),
            Text(
              "${loggedInUser!.firstname} ${loggedInUser!.lastname}",
              style: TextStyle(
                  color: Colors.amberAccent[200],
                  letterSpacing: 2.0,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30.0,
            ),
            const Text(
              'AGE',
              style: TextStyle(color: Colors.grey, letterSpacing: 2.0),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              //displaying a value from variable
              "${loggedInUser!.age}",
              style: TextStyle(
                  color: Colors.amberAccent[200],
                  letterSpacing: 2.0,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30.0,
            ),
            const Text(
              'JOB STATUS',
              style: TextStyle(color: Colors.grey, letterSpacing: 2.0),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              //displaying a value from variable
              "${loggedInUser!.jobStatus}",
              style: TextStyle(
                  color: Colors.amberAccent[200],
                  letterSpacing: 2.0,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30.0,
            ),
            const Text(
              'CIVIL STATUS',
              style: TextStyle(color: Colors.grey, letterSpacing: 2.0),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              //displaying a value from variable
              "${loggedInUser!.civilStatus}",
              style: TextStyle(
                  color: Colors.amberAccent[200],
                  letterSpacing: 2.0,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                Icon(Icons.email, color: Colors.grey[400]),
                const SizedBox(width: 10.0),
                Text("${loggedInUser!.email}",
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 18.0,
                        letterSpacing: 1.0))
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(30),
                color: Colors.redAccent,
                child: MaterialButton(
                  padding: EdgeInsets.fromLTRB(30, 15, 20, 20),
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () {
                    showDialog<void>(
                        context: context, builder: (context) => dialog);
                  },
                  child: const Text(
                    'Deactivate Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                )),
            const SizedBox(
              height: 20.0,
            )
          ]),
        ),
      ),
    );
  }
}
