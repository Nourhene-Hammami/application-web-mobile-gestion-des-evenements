
import 'package:eventmobile/Services/userservice.dart';
import 'package:flutter/material.dart';
//import 'package:eventmobile/Controller/eventservice.dart';
import 'mydrawer.dart';
import '../Models/Utilisateur.dart';

class UserListPage extends StatefulWidget {
   
  @override
  UserListPageState createState() => UserListPageState();
}

class UserListPageState extends State<UserListPage> {
  List<Utilisateur> userList = [];
   late final int userId =0;
  @override
  void initState() {
   

   // super.initState();
    getUsers().then((users) {
      setState(() {
        
              userList = List<Utilisateur>.from(users.map((user) => Utilisateur.fromJson(user)));

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Color(0xfffb2056),
        title: Text("Users List"),
      ),
      drawer: MyDrawer(),
      body: userList.length == 0
          ? Center(
              child: Text("There are no users yet"),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(label: Text("User Id")),
                  DataColumn(label: Text("User Name")),
                  DataColumn(label: Text("User Email")),
                   DataColumn(label: Text("User Role")),
                  DataColumn(label: Text("User Password")),
                  DataColumn(label: Text("Action")),
                ],
                rows: userList
                    .map(
                      (user) => DataRow(cells: [
                        DataCell(Text(user.id.toString())),
                        DataCell(Text(user.name)),
                        DataCell(Text(user.mail)),
                         DataCell(Text(user.role)),
                        DataCell(Text(user.password)),
                        DataCell(Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit , color: Colors.grey[450]),
                                
                              //=>fetchEventByIdFromRemote(event.id),
                              onPressed: () async {
    await getUser(user.id as int);
  Navigator.pushNamed(context, '/edituser', arguments: user.id);

  
  }, ),              
                            IconButton(
                              icon: Icon(Icons.delete , color: Colors.red),
                              onPressed: () =>
                                  deleteUserById(user.id as int),
                                  
                            ),
                          ],
                        )),
                      ]),
                    )
                    .toList(),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _gotoAddUser,
        child: Icon(Icons.add),
         backgroundColor: Colors.green,
      ),
    );
  }

  void _gotoAddUser() {
    // Navigate to add event page
    Navigator.pushNamed(context, '/adduser');
  }



  
  

  
}
