import 'dart:convert';
import 'package:eventmobile/Models/Utilisateur.dart';
import 'package:eventmobile/View/drawerclient.dart';
import 'package:eventmobile/View/mydrawer.dart';
import 'package:flutter/material.dart';
import 'package:eventmobile/models/utilisateur.dart' as Utilisateur1;
import 'package:eventmobile/Services/userservice.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:localstorage/localstorage.dart';

class ProfileUser extends StatefulWidget {
 ProfileUser({Key? key}) : super(key: key);

  @override
  ProfileUserState createState() => ProfileUserState();
}

class ProfileUserState extends State<ProfileUser> {
  Utilisateur1.Utilisateur user = Utilisateur1.Utilisateur(mail: '', name: '',role:'',password: '',id: 2);
  final formKey = GlobalKey<FormState>();
  bool formIsValid = false;
 // final LocalStorage storage = LocalStorage('user');
 // late String name="" , password="", mail="";
  late TextEditingController nameController ;
    late TextEditingController passwordController;
    late TextEditingController mailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    mailController = TextEditingController();
    getUserStokage();
    
  }
   Future<void>  getUserStokage() async {
// Get an instance of SharedPreferences
SharedPreferences prefs = await SharedPreferences.getInstance();

// Get the stored user data as a JSON-encoded string
String? userJson = prefs.getString('user');

if (userJson != null) {
  // Decode the JSON-encoded user data into a Utilisateur object
  Utilisateur userS = Utilisateur.fromJson(json.decode(userJson));


// Initialize the user object with the user data
    user = Utilisateur1.Utilisateur(
      mail: userS.mail,
      name: userS.name,
      role: userS.role,
      password: userS.password,
      id: userS.id,
    );
      setState(() { 
        nameController.text = userS.name;
      passwordController.text = userS.password;
      mailController.text = userS.mail;
    });
  print('User password: ${userS.password}');
  print('User mail: ${userS.mail}');
  print('User id: ${userS.id}');
  print('User name: ${userS.name}');

}

   }
Future<void> _updateUserFromSubmit() async {
  if (formKey.currentState!.validate()) {
    // validate the form
    formKey.currentState!.save();
    formIsValid = true;

    // get the id of the user we want to update
    final int? id = user.id;
    print(id);

    final List<dynamic> usersData = await getUsers();
final isEmailUnique = usersData.every((user) => user['mail'] != mailController.text || user['id'] == id);

    if (isEmailUnique) {
      dynamic  userUpdated = await getUser(id!);
      // Create a new user object with the updated data
      userUpdated  = Utilisateur1.Utilisateur(
        mail: mailController.text,
        name: nameController.text,
        role: user.role,
        password: passwordController.text,
        id: user.id,
      );

  
     
      //  await updateUser(id,user.toJson() as Map<String, dynamic>);
      await updateUser(id,userUpdated);

      // Save the user data to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userJson = json.encode(userUpdated);
      print('nouveau user $userJson');
      prefs.setString('user', userJson);

      setState(() {
        // update the user object with the new data
        user = Utilisateur1.Utilisateur.fromJson(userUpdated.toJson());
      });

      // update the form fields with the new user data
      //FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User updated successfully')),
      );
            Navigator.pushNamed(context, '/_ProfileUser');

    } else {
      // if the email is not unique, show an alert
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Email already exists'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.pushNamed(context, '/_ProfileUser'),
            ),
          ],
        ),
      );
    }
  }
}



@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor:              Color(0x777c2bff),

      title: Text('Edit Profile'),
    ),
    drawer: DrawerClient(),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            'assets/profil.jpg',
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Text('Name: ${user.name}'),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: mailController,
                    decoration: InputDecoration(labelText: 'Email'),

                    // keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required.';
                      }
                      if (!value.contains('@') || !value.contains('.')) {
                        return 'Email is invalid.';
                      }
                      return null;
                    },
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username is required.';
                      }
                      if (value.length < 3) {
                        return 'Username is too short.';
                      }
                      // if (!RegExp
                    },
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        //user.name= value;
                      });
                    },
                  ),
                ),

                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password:'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required.';
                    }
                    if (value.length < 4) {
                      return 'Password is too short.';
                    }
                  },
                  //onSaved: (value) => user.password = value!,
                ),

                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _updateUserFromSubmit();
                      },
                      child: Text("Update"),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0x777c2bff),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        
                       Navigator.pushNamed(context, '/catag');
                      },
                      child: Text("Back"),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0x777c2bff),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

            
            
            
            }