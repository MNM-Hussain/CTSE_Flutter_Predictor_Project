import 'package:flutter/material.dart';
import 'package:predictor_app/Screens/ImagePages/RetrieveImages.dart';
import 'package:predictor_app/Screens/Profile/Profile.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  final screens = [
    const Center(child: Text("Prediction", style: TextStyle(fontSize: 60))),
    const Center(child: Text("Problems", style: TextStyle(fontSize: 60))),
    const RetreiveImages(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(.6),
          selectedFontSize: 14,
          onTap: (value) {
            // Respond to item press.
            setState(() => _currentIndex = value);
          },
          items: const [
            BottomNavigationBarItem(
              label: 'Prediction',
              icon: Icon(Icons.home),
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              label: 'Problems',
              icon: Icon(Icons.report_problem),
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              label: 'Motivation',
              icon: Icon(Icons.psychology),
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(Icons.assignment_ind),
              backgroundColor: Colors.black,
            ),
          ],
        ));
  }
}
