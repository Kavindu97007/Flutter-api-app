// menu_drawer.dart
import 'package:flutter/material.dart';
import '../features/core/addEmployee.dart';
// Add more imports as necessary for different pages

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Employee Registration'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddEmployee()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Customer Registration'),
            onTap: () {
              // Add navigation to Customer Registration page
            },
          ),
          // Add more list tiles for different options
        ],
      ),
    );
  }
}
