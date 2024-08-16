import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:eventmobile/Models/Utilisateur.dart';

import 'package:eventmobile/Services/userservice.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

 


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _mailController = TextEditingController();
  final _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    
  
    return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xfffb2056),
      title: Text('EVENT .'),
          automaticallyImplyLeading: false, // remove the back arrow

    ),
      body: 
      Container(
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
                     "Sign in",
                        style: TextStyle(
                            color: Color(0xfffb2056),
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
                        TextButton(
  onPressed: () {
    Navigator.pushNamed(context, "/register");
  },
  child: Text(
    "Create Account.",
    style: TextStyle(color: Colors.black),
  ),
),

                         TextButton(
              onPressed: () {},
                       child: Text("Forgot your password?" ,
                             style: TextStyle(color: Colors.black),),
                       ),

                        ],
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Perform login action
                            String mail = _mailController.text;
                            String password = _passwordController.text;
                            print("Email: $mail");
                            print("Password: $password");
                            //Navigator.pushNamed(context, "/catalogue");
                        getUtilisateurData(mail, password).then((response) {
                  //  print(res);
                    if (response ==1){
            
                  
                      getUserByMail(mail).then((user) {
                        print(user);
                        if (user != null) {
                          getUserRole(mail).then((role) async {
                            print(role);
                            if (role == 'user') {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login successful')));
                              
                              // Get an instance of SharedPreferences
SharedPreferences prefs = await SharedPreferences.getInstance();

// Save the user data as a JSON-encoded string
String userJson = json.encode(user);
print(userJson);
prefs.setString('user', userJson);//save data
                   
    Navigator.pushNamed(context, "/catag");

                            } else if (role == 'admin') {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login successful')));

                              // Get an instance of SharedPreferences
SharedPreferences prefs = await SharedPreferences.getInstance();

// Save the user data as a JSON-encoded string
String userJson = json.encode(user);
print(userJson);
prefs.setString('user', userJson);//save data

                              Navigator.pushNamed(context, '/adminlist');
                            } 
                          });
                        } 
                       
                      });
                    }
                    else  {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid email or password')));
                    }
                  });
                }
              },
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                          
                        ),
                      
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xfffb2056),
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


