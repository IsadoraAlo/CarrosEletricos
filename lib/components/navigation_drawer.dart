import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 59, 119, 223),
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(
                top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
            child: Column(children: const [
              CircleAvatar(
                radius: 52,
                child: Icon(
                  Icons.person,
                  size: 50,
                ),
              ),
              Text('Anonymous',
                  style: TextStyle(fontSize: 26, color: Colors.blueAccent)),
              Text('anonymous.user@gmail.com',
                  style: TextStyle(fontSize: 16, color: Colors.blueAccent))
            ]),
          ),
          Column(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                title:
                    const Text('Home', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.info,
                  color: Colors.white,
                ),
                title: const Text(
                  'About the team',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/team-details');
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.white70,
                ),
                title: const Text('Logout',
                    style: TextStyle(color: Colors.white70)),
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
              )
            ],
          )
        ],
      )),
    );
  }
}
