import 'dart:convert';
import 'dart:io';
import 'package:eventmobile/Services/userservice.dart';
import 'package:eventmobile/Models/Utilisateur.dart';
import 'package:eventmobile/View/mydrawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class UpdateUserForm extends StatefulWidget {
  late int userId  ;
 UpdateUserForm({Key? key, required int  userId}) : super(key: key){
    this.userId = userId;
  }


  @override
  _UpdateUserFormState createState() => _UpdateUserFormState();
}



class _UpdateUserFormState extends State<UpdateUserForm> {

//late Utilisateur _userToUpdate = Utilisateur(mail: '', name: '',role:'',password: '',id: null);
late Future<Utilisateur> _userToUpdate= Future.value(Utilisateur(mail: '', name: '',role:'',password: '',id: null));

//late Future<Utilisateur> _userToUpdate = Utilisateur(mail: '', name: '',role:'',password: '',id: null) as Future<Utilisateur>;
 late  TextEditingController _mailController = TextEditingController();
  late  TextEditingController _passwordController = TextEditingController();
  late  TextEditingController _usernameController = TextEditingController();
  late  TextEditingController _userroleController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
   late String name ="", mail="", password="",   role="";




 Future<void> updateUserFromSubmit() async {
  if (_formKey.currentState!.validate()) {
    // validate the form
    _formKey.currentState!.save();
  

    // get the id of the user we want to update
    final int? id = widget.userId;
    print('user id= $id');

    final List<dynamic> usersData = await getUsers();
final isEmailUnique = usersData.every((user) => user['mail'] != _mailController.text || user['id'] == id);

    if (isEmailUnique) {
      dynamic  userUpdated = await getUser(widget.userId);
      // Create a new user object with the updated data
      userUpdated  = Utilisateur(
        mail: _mailController.text,
        name: _usernameController.text,
        role: _userroleController.text,
        password: _passwordController.text,
        id: widget.userId,
      );

  
     
      //  await updateUser(id,user.toJson() as Map<String, dynamic>);
      await updateUser(id!,userUpdated);

    

      setState(() {
        // update the user object with the new data
        //_userToUpdate =Utilisateur.fromJson(userUpdated.toJson())  ;
        _userToUpdate = Future.value(Utilisateur.fromJson(userUpdated.toJson()));

      });

      // update the form fields with the new user data
      //FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User updated successfully')),
      );

Navigator.pushNamed(context, '/listuser');
    } else {
      // if the email is not unique, show an alert
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Email already exists'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.pushNamed(context, '/edituser', arguments: widget.userId),
            ),
          ],
        ),
      );
    }
  }
 }

  @override
void initState() {
  super.initState();
 loadUser();
}

Future<void> loadUser() async {
  print(widget.userId);
  final  _userToUpdate = await  getUser(widget.userId)  ;
final _user = Utilisateur.fromJson(_userToUpdate as Map<String, dynamic>);

 setState(() {
 _usernameController = TextEditingController(text: _user.name);
  _passwordController = TextEditingController(text: _user.password);
    _mailController = TextEditingController(text: _user.mail);
    _userroleController = TextEditingController(text: _user.role);
 }); 
}


             @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
            backgroundColor: Color(0xfffb2056),
      title: Text('Update User'),
    ),
 drawer: MyDrawer(),
    body: FutureBuilder(
     future: _userToUpdate,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData) {
          return Center(
            child: Text('No data available'),
          );
        } else {
         var _userToUpdate = snapshot.data ;
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                   // initialValue: _eventToUpdate!.name,
                     //initialValue: name,
                      controller: _usernameController,
                      decoration: InputDecoration(
                            


                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                      setState(() {
                          print(value);

                         _userToUpdate!.name= value;
                        }); 
                      },
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
                    ),
                ),
                Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
            //  initialValue: _eventToUpdate!.lieu,
                    controller: _mailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
             /* onChanged: (value) {
                setState(() {
               
                         _userToUpdate.mail= value;
                });
              },*/
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
          ),
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
      value: 'admin',
      child: Text('admin'),
    ),
    DropdownMenuItem(
      value: 'user',
      child: Text('user'),
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

        
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
             // initialValue: _eventToUpdate!.desp,
                    controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
             /* onChanged: (value) {
                setState(() {
                  
                         _userToUpdate.password = value;
                });
              },*/
            validator: (value) {
                          if (value!.isEmpty) {
                            return "Password is required.";
                          } else if (value.length < 4 || value.length > 10) {
                            return "Password should be between 4 and 10 characters long.";
                          }
                          return null;},
            ),
          ),
      
         SizedBox(height: 10),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    ElevatedButton(
      onPressed: () {
       updateUserFromSubmit();
      },
      child: Text("Update"),
      style: ElevatedButton.styleFrom(
        primary: Color(0xfffb2056),
      ),
    ),
    ElevatedButton(
      onPressed: () {   Navigator.pushNamed(context, '/listuser');

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
          );
        }
      },
    ),
  );
}
}