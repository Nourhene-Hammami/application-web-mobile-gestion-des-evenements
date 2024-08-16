import 'dart:convert';

import 'package:eventmobile/Models/Utilisateur.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

import '../Services/userservice.dart';
import 'mydrawer.dart';

class AddUserPage extends StatefulWidget {
  
  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
   final _mailController = TextEditingController();
  final _passwordController = TextEditingController();
 final _usernameController = TextEditingController();
 final _userroleController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late String name ="", mail="", password="",   role="";


  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
        String mail = _mailController.text;
String password = _passwordController.text;
String name = _usernameController.text; 
String role= _userroleController.text;
Utilisateur user = Utilisateur(mail: "$mail", password: "$password",role: "$role", name: "$name",id :null  );

 // get the id of the user we want to created
    final int? id = user.id;
    print(id);

    final List<dynamic> usersData = await getUsers();
final isEmailUnique = usersData.every((user) => user['mail'] != _mailController.text || user['id'] == id);

    if (isEmailUnique) {
      final response = await adduser(user);
      print(response.statusCode);
      final responseBody = await response.body;
      print(responseBody);
      if (response.statusCode == 200) {
        print("User added successfully");
            Navigator.pushNamed(context, '/listuser');
      } }else {
        print("Error adding user ");
        
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mail already exists')));
      }
    }
  }
 
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: Text("Add user"),
         backgroundColor: Color(0xfffb2056),
      
      ),
      drawer: MyDrawer(),
    //  ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Name:"),
                TextFormField(
                    controller: _usernameController,

validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Username is required.';
    }
    if (value.length < 4) {
      return 'Username is too short.';
    }
    if (!RegExp(r'^[a-zA-Z]').hasMatch(value)) {
      return 'Username should start with an alphabet.';
    }
    return null;
  },                ),
                SizedBox(height: 10),
                Text("Email:"),
                TextFormField(
               controller: _mailController,

validator: (value) {
                        //  if (value .isEmpty) {
                          if(value!.isEmpty){
                            return "Email is required.";
                          } else if (!value.contains("@")) {
                            return "Invalid email.";
                          }
                          return null;
                        },
                ),
              /*  SizedBox(height: 10),
                Text("Role:"),
                TextFormField(
                    controller: _userroleController,

 
                ),*/
   FormField<String>(
  builder: (FormFieldState<String> state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Role:'),
       

        DropdownButtonFormField<String>(
         //value:  _userroleController.text,
 items: [
    DropdownMenuItem(
      value: 'Admin',
      child: Text('Admin'),
    ),
    DropdownMenuItem(
      value: 'User',
      child: Text('User'),
    ),
  
  ],
         
          onChanged: (String? newValue) {
            _userroleController.text = newValue!;
            state.didChange(newValue);
          },
        //  value: _userroleController.text,
          decoration: InputDecoration(
            hintText: 'Select role',
            errorText: state.errorText,
          ),
        ),
      ],
    );
  },
  validator: (value) {
    if (value == null) {
      return 'Please select a role.';
    }
    return null;
  },
),

                
                SizedBox(height: 10),
                Text("Password:"),
                TextFormField(
                    controller: _passwordController,

validator: (value) {
                          if (value!.isEmpty) {
                            return "Password is required.";
                          } else if (value.length < 4 || value.length > 10) {
                            return "Password should be between 4 and 10 characters long.";
                          }
                          return null;
                        },
                ),
             
           

    SizedBox(height: 10),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    ElevatedButton(
      onPressed: () {
       _submitForm();
      },
      child: Text("Submit"),
      style: ElevatedButton.styleFrom(
        primary: Color(0xfffb2056),
      ),
    ),
    ElevatedButton(
      onPressed: () {
        // Navigator.pop(context);
        Navigator.pushNamed(context, '/listuser');
      },
      child: Text("Back"),
      style: ElevatedButton.styleFrom(
        primary: Color(0xfffb2056),
      ),
    ),
  ],
),


  ], 
            ),  
            ), 
            ),
            ),
            );
            
  }}