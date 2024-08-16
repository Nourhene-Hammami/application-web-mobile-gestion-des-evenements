import 'package:eventmobile/Services/eventservice.dart';
import 'package:eventmobile/Models/Utilisateur.dart';
import 'package:eventmobile/View/mydrawer.dart';
import 'package:eventmobile/Services/userservice.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;




class SearchUser extends StatefulWidget {
  @override
  SearchUserState createState() => SearchUserState();
}

class SearchUserState extends State<SearchUser> {
  List<Utilisateur> userlist= [];
   List<Utilisateur> _originalList= [];
  String _searchQuery = '';
  @override
  void initState() {
   

   // super.initState();
    getUsers().then((users) {
      setState(() {  
        userlist = List<Utilisateur>.from(users.map((user) => Utilisateur.fromJson(user)));
   _originalList = List<Utilisateur>.from(users.map((user) => Utilisateur.fromJson(user)));
   }); });
  }
void myFunction(String query) {
  setState(() {
    _searchQuery = query.toLowerCase();
      if (_searchQuery.isEmpty) {
      userlist = List<Utilisateur>.from(_originalList);
      } else {
        // filter events based on search query
        userlist = _originalList.where((user) => user.name.toLowerCase().contains(_searchQuery)).toList();
      }
 });
}


@override
Widget build(BuildContext context) {
  return Scaffold(
     appBar: AppBar(
         backgroundColor: Color(0xfffb2056),
        title: Text("Search User"),
      ),
      drawer: MyDrawer(),
    body: Column(
      children: [
        Container(
        
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                child: TextField(
                  //onChanged: (query) => myFunction(query),
                  onChanged:  myFunction,
                  decoration: InputDecoration(
                    hintText: 'Search for Users names..',
                  ),
                ),
              ),
              Table(
                columnWidths: {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(3),
                 
                  3: FlexColumnWidth(2),
              
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'User Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'User Email',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'User Role',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                     
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'User Password',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    
                    ]
                  ),
                  for (var user in userlist)
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(user.name),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(user.mail),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(user.role),
                        ),
                      
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(user.password),
                        ),
                      
                      ]
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}