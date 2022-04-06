import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Hussain Nazimudeen'),
            accountEmail: const Text('hussain@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'profile.jpg',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1541450805268-4822a3a774ca?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80.jpg')),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Predictor'),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(Icons.sync_problem_outlined),
            title: const Text('Regular Problems'),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(Icons.psychology_outlined),
            title: const Text('Motivation'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.feedback_outlined),
            title: Text('Feedback'),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(Icons.person_outlined),
            title: const Text('Profile'),
            onTap: () => null,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text('Logout'),
            onTap: () => null,
          ),
        ],
      ),
    );
  }
}
