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
                child: Image.network(
                  'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
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
                      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
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
            leading: const Icon(Icons.image_outlined),
            title: const Text('Quotes'),
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
