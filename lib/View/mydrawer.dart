import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xfffb2056),
            ),
            child: Text(
              'Admin Space ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
             
                Navigator.pushNamed(context, '/_ProfileAdmin');

              // Navigate to /admin/profil
            },
          ),
             ListTile(
            leading: Icon(Icons.list),
            title: Text('List User'),
            onTap: () {
                              Navigator.pushNamed(context, '/listuser');

            },
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Search User'),
            onTap: () {
                            Navigator.pushNamed(context, '/searchuser');

            },
          ),
       
          ListTile(
            leading: Icon(Icons.list),
            title: Text('List Event'),
            onTap: () {
              // Navigate to /admin/list
 Navigator.pushNamed(context, '/adminlist');

            },
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Search Event'),
            onTap: () {
             Navigator.pushNamed(context, '/searchevent');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
