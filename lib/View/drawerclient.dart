import 'package:flutter/material.dart';

class DrawerClient extends StatelessWidget {
  const DrawerClient({Key? key}) : super(key: key);
  @override
Widget build(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Color(0x777c2bff),
          ),
          child: Text(
            'User Space ',
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
            Navigator.pushNamed(context, '/_ProfileUser');
          },
        ),
        ListTile(
          leading: Icon(Icons.list),
          title: Text('Event List'),
          onTap: () {
           Navigator.pushNamed(context, "/catag");

          },
        ),
        ListTile(
          leading: Icon(Icons.search),
          title: Text('Search Event'),
          onTap: () {
            Navigator.pushNamed(context, '/searcheventclient');
          },
        ),
     
        ListTile(
          leading: Icon(Icons.contacts),
          title: Text('Contact'),
          onTap: () {
           Navigator.pushNamed(context, '/chatbot');
          },
        ),
        ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text('Cart'),
          onTap: () {
            Navigator.pushNamed(context, '/cart');
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