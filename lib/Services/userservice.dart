import 'dart:io';

import 'package:eventmobile/Models/Utilisateur.dart';


import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';


Future<bool> registerUserFromRemote(Utilisateur user) async {
    if (user.mail == null || user.password == null || user.role == null || user.name == null) {
    throw Exception('Failed to register user: null fields in Utilisateur object');
  }
  final response = await http.post(
    Uri.parse('http://10.0.2.2:9000/registeruser'),
    body: jsonEncode(user),
   
    headers: {
      'Content-Type': 'application/json',
    },
  );
   print(response.body);
  print(response.statusCode);
if (response.statusCode == 500) {
  // internal server error

  return false;
} else {
  // registration succeeded
  return true;
}
}
 Future<int> getUtilisateurData(String mail, String password) async {    
    print('$mail $password');
    var response = await http.get(Uri.parse('http://10.0.2.2:9000/utilisateur/$mail/$password'));
     print(response.body);
    if (response.statusCode == 200 && response.body == "1") {
      return 1;
    } else {
      return 0;
    }
   
  }
   final String baseUrl = 'http://10.0.2.2:9000';

  Future<List<dynamic>> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/getusers/'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<dynamic> getUser(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/getuser/$id'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<Utilisateur> updateUser(int id,  user) async {
    final response = await http.put(Uri.parse('http://10.0.2.2:9000/updateuser/$id'),
        body: jsonEncode(user),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
    final updatedUser = Utilisateur.fromJson(jsonDecode(response.body));
    return updatedUser;


      //return jsonDecode(response.body);
      
    } else {
      throw Exception('Failed to update user');
    }
  }
  Future<String> getUserRole(String mail) async {
    var response = await http.get(Uri.parse('http://10.0.2.2:9000/utilisateur/role/$mail'));
    return response.body;
  }
  
  Future<Utilisateur> getUserByMail(String mail) async {
    var response = await http.get(Uri.parse('http://10.0.2.2:9000/utilisateur/$mail'));
    return Utilisateur.fromJson(json.decode(response.body));
  }


   Future<void> deleteUserById(int id) async {

    final response = await http.delete(Uri.parse('http://10.0.2.2:9000/deleteuser/$id'));

    if (response.statusCode == 200) {
      // event deleted successfully
    } else {
      throw Exception('Failed to delete event');
    }
  }

  
   Future<http.Response> adduser(Utilisateur user) async {

    final response = await http.post(Uri.parse('http://10.0.2.2:9000/adduser'), 
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson())
  );

    if (response.statusCode == 200) {
      print("user add ");
        return response;

      
    } else {
      throw Exception('Failed to add user');
    }
  }
