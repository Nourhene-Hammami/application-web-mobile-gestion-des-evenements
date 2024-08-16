import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:eventmobile/Models/Utilisateur.dart';
import 'package:eventmobile/Services/userservice.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:shared_preferences/shared_preferences.dart';




class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _mailController = TextEditingController();
  final _passwordController = TextEditingController();
 final _usernameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    
  
    return Scaffold(
              appBar: AppBar(
            backgroundColor: Color(0x777c2bff),
      title: Text('EVENT .'),
          automaticallyImplyLeading: false, // remove the back arrow

    ),

      body: Container(
        decoration: const BoxDecoration(
       image:DecorationImage(image: AssetImage('assets/log1.jpg'),
       fit: BoxFit.fill) 
       ), 
        margin: EdgeInsets.only(top: 0.005 * MediaQuery.of(context).size.height),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                   
                      Text(
                     "Sign up",
                        style: TextStyle(
                            color: Color(0x777c2bff),
                            

                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                         Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    IconButton(
      icon: Icon(Icons.facebook),
      onPressed: () {
        String url = "https://www.facebook.com/";
          launch(url);
      
      
      },
    ),
    IconButton(
      //icon: Icon(Icons.Google),
       icon: Icon(FlutterIcons.google_ant),
      onPressed: () {
        String url = "https://www.google.com/";
          launch(url);
      },
    ),
    IconButton(
      icon: Icon(FlutterIcons.linkedin_ent),
      onPressed: () {
      String url = "https://www.linkedin.com/";
          launch(url);
      },
    ),    
  ],
),

   SizedBox(height: 20),
TextFormField(
  decoration: InputDecoration(
    labelText: 'Username',
    hintText: 'Enter your username',
     border: OutlineInputBorder(),
  ),

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
  },
  /*onChanged: (value) {
    user.name = value;
  },*/
),

                      SizedBox(height: 30),
                      TextFormField(
                        controller: _mailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "Enter your email",
                          border: OutlineInputBorder(),
                        ),
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
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          hintText: "Enter your password",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password is required.";
                          } else if (value.length < 4 || value.length > 10) {
                            return "Password should be between 4 and 10 characters long.";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
    Expanded(
      flex: 1,
      child: TextButton(
  onPressed: () {
    Navigator.pushNamed(context, "/login");
  },
  child: Text(
    "Already a member?",
    style: TextStyle(color: Colors.black),
  ),
),


                         )   ],
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {

    if (_formKey.currentState!.validate()) { 
       String mail = _mailController.text;
String password = _passwordController.text;
String name = _usernameController.text; 
Utilisateur user = Utilisateur(mail: "$mail", 
password: "$password",
 role: "user", 
 name: "$name",
 id :null  );
String jsonUser = jsonEncode(user.toJson());

      bool isRegistered = await registerUserFromRemote(user);
      if(isRegistered){

  // registration successful
  print("Your registration is successful");
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Your registration is successful')));
  Navigator.pushNamed(context, '/login'); // navigate to login page
} else {
  // registration failed
  print("pas d'inscription mail already exists");
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email already exist'))); 
}

  
  }

                     
                },
              

                        child: Text(
                          "Register",
                          style: TextStyle(color: Colors.white),
                        ),
                      
                        style: ElevatedButton.styleFrom(
                          primary: Color(0x777c2bff),
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
     /*       Expanded(
              child: Container(
                color: Colors.grey[200],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Hello, my friend!",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("Please enter your email and password to log in our platform."),
                  ],
                  
                ),
              ),
            ),   */
          ],
        ),
      ),
    );
  }
  

}


