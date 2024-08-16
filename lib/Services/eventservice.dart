


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


import '../Models/Event.dart';


List<Event> _eventlist = [];
  late Event _eventToUpdate;
 //late final int eventId ;



  Future<List<Event>> fetchEventListFromRemote() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:9000/geteventlist'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Event> events = [];

      data.forEach((event) {
        events.add(Event.fromJson(event));
      });

      return events;
    } else {
      throw Exception('Failed to fetch event list');
    }
  }


  Future <Event> fetchEventByIdFromRemote(int id) async {
    print('fetched id $id');
    // late int eventId = _eventToUpdate.id;
   
    final response = await http.get(Uri.parse('http://10.0.2.2:9000/geteventbyid/$id'));
    if (response.statusCode == 200) {
     // setState(() {
       // _eventToUpdate = Event.fromJson(jsonDecode(response.body));
         //  return final Event.fromJson(jsonDecode(response.body));
           final jsonResponse = json.decode(response.body);
    final event = Event.fromJson(jsonResponse);
    print("event $event");


    
    return event;

      }
     // );} 
    else {
      throw Exception('Failed to fetch event');
    }
  }

 Future<void> deleteEventByIdFromRemote(int id) async {

    final response = await http.delete(Uri.parse('http://10.0.2.2:9000/deleteventbyid/$id'));

    if (response.statusCode == 200) {
      // event deleted successfully
    } else {
      throw Exception('Failed to delete event');
    }
  }

/*Future<void> _selectImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  void _submitForm() async {
    if (_formKey.currentState.validate()) {
      final event = Event(
        name: _name,
        location: _location,
        city: _city,
        date: _date,
        stock: _stock,
        description: _description,
        price: _price,
        imageFile: _imageFile,
      );
      await addEventToRemote(event);
      Navigator.pop(context);
    }
  }

  Future<void> addEventToRemote(Event event) async {
    final url = Uri.parse('http://localhost:9000/addevent/');
    final request = http.MultipartRequest('POST', url);
    request.fields['name'] = event.name;
    request.fields['lieu'] = event.lieu;
    request.fields['city'] = event.city;
    request.fields['date'] = event.date.toIso8601String();
    request.fields['stock'] = event.stoke.toString();
    request.fields['description'] = event.desp;
    request.fields['price'] = event.price;
    if (event.filenameimg!= null) {
      request.files.add(await http.MultipartFile.fromPath('image', event.filenameimg));
    }
    final response = await request.send();
    if (response.statusCode == 200) {
      print('Event added successfully');
    } else {
      print('Error adding event: ${response.reasonPhrase}');
    }
  }
*/
  