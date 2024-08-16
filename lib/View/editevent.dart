import 'dart:convert';
import 'dart:io';

import 'package:eventmobile/Models/Event.dart';
import 'package:eventmobile/View/mydrawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import '../Services/eventservice.dart';
//import 'package:dio/dio.dart' ;
//import 'package:dio/dio.dart' as dio;
import 'package:eventmobile/Models/Event.dart';


class UpdateEventForm extends StatefulWidget {
  late int eventId  ;
 UpdateEventForm({Key? key, required int  eventId}) : super(key: key){
    this.eventId = eventId;
  }


  @override
  _UpdateEventFormState createState() => _UpdateEventFormState();
}

class _UpdateEventFormState extends State<UpdateEventForm> {

DateTime _selectedDate = DateTime.now();
late Future<Event> _eventToUpdate;

  late List<Event> _eventList;
  File? _userFile;

//DateTime _selectedDate = DateTime.now();


late TextEditingController _eventLieuController;
late TextEditingController _eventCityController;
late TextEditingController _eventStockController;
late TextEditingController _eventDescriptionController;
late TextEditingController _eventOrganizerController;
late TextEditingController _eventPriceForStudentController;
late TextEditingController _eventPriceForNoStudentController;

//late final TextEditingController _eventNameController =  TextEditingController(text: _eventToUpdate.name);
late TextEditingController _eventNameController;




 late  File _image = File('');
bool showSpinner=false;

  final _formKey = GlobalKey<FormState>();
  late String name , lieu="", city="",   desp="",organizer="";
 late int stoke,priceForNoStudent,priceForStudent;
  late int? id=0;
  late DateTime date;
  late String _imgURL ="";




  _selectImage() async {

  final pickedImage = await ImagePicker().getImage(source: ImageSource.gallery,imageQuality:80);
    setState(() {
      _image = File(pickedImage!.path);
      _imgURL = pickedImage.path;
      print(_imgURL);
    });
}

  Future<void> updateEventFromSubmit() async {
  final _eventToUpdate = await fetchEventByIdFromRemote(widget.eventId);
  final request = http.MultipartRequest(
    'POST',
    Uri.parse('http://10.0.2.2:9000/addevent'),
  );
  request.headers.addAll({'Content-Type': 'multipart/form-data'});

// Create a DateTime object representing the date you want to format
DateTime date = DateTime.now();
// Create a DateFormat object with the desired format
DateFormat formatter = DateFormat('yyyy-MM-dd');
    request.fields['event'] = jsonEncode({
      'id' :widget.eventId.toString(),
    'name': _eventNameController.text,
    'lieu': _eventLieuController.text,
    'city': _eventCityController.text,
  'date':formatter.format(date),
    'stoke': _eventStockController.text,
    'desp':_eventDescriptionController.text ,
     'Organizer':_eventOrganizerController.text ,
    'priceForStudent': _eventPriceForStudentController.text,
     'priceForNoStudent': _eventPriceForNoStudentController.text,
    'filenameimg': _imgURL
});
   request.files.add(http.MultipartFile.fromBytes(
        'file', 
        _image.readAsBytesSync(),
         filename: _image.path.split('/').last)         );
 
  final response = await request.send();
  if (response.statusCode == 200) {
    Navigator.of(context).pushNamed('/adminlist');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Event updated successfully')),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to update event')),
    );
  }
}

 


 /*  @override
  Future<void> initState(){
     
    super.initState();
   
    print(widget.eventId);
     _eventToUpdate = fetchEventByIdFromRemote(widget.eventId) ;
    

    
  

  }*/
  @override
void initState() {
  super.initState();
  loadEvent();
}

Future<void> loadEvent() async {
  print(widget.eventId);
  _eventToUpdate = fetchEventByIdFromRemote(widget.eventId) ;
  Event event = await _eventToUpdate;
  _eventNameController = TextEditingController(text: event.name);
   _eventLieuController = TextEditingController(text: event.lieu);
    _eventDescriptionController = TextEditingController(text: event.desp);
     _eventCityController = TextEditingController(text: event.city);
      _eventPriceForStudentController = TextEditingController(text: event.priceForStudent.toString());
            _eventPriceForNoStudentController = TextEditingController(text: event.priceForNoStudent.toString());
_eventOrganizerController = TextEditingController(text: event.organizateur);
       _eventStockController = TextEditingController(text: event.stoke.toString());
}


             @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
            backgroundColor: Color(0xfffb2056),
      title: Text('Update Event'),
    ),
 drawer: MyDrawer(),
    body: FutureBuilder(
     future: _eventToUpdate,
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
         var _eventToUpdate = snapshot.data ;
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
                      controller: _eventNameController,
                      decoration: InputDecoration(
                            

         //  controller: _eventNameController..text = _eventToUpdate.name,

                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                      setState(() {
                          print(value);
                               //   _eventToUpdate = _eventToUpdate!.copyWith(name: value);

                         _eventToUpdate!.name = value;
                        // name=value;
                        }); 
                       //  _eventToUpdate!.name = value; // mettre à jour event.name ici si nécessaire
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name is required';
                        }
                        return null;
                      },
                    ),
                ),
                Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
            //  initialValue: _eventToUpdate!.lieu,
                    controller: _eventLieuController,
              decoration: InputDecoration(
                labelText: 'Place',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
               
                         _eventToUpdate!.lieu= value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lieu is required';
                }
                return null;
              },
            ),
          ),
          TextFormField(
  decoration:
   InputDecoration(labelText: 'Date'),
  readOnly: true, // make the field read-only
  onTap: () async {
    final DateTime? date = await showDatePicker(
      context: context,
      
        firstDate:  _eventToUpdate!.date,
         initialDate: _eventToUpdate.date,
      lastDate: DateTime(2100),
    );
    if (date != null) {
      // update the value of the date variable
      setState(() {
        _selectedDate = date;
      });
    }
  },
  controller: TextEditingController(
    text: _selectedDate != null
        ? DateFormat('dd/MM/yyyy').format(_selectedDate)
        : '',
  ),
  onSaved: (value) {
    // save the value of the date variable
    if (value != null && value.isNotEmpty) {
      date = DateFormat('dd/MM/yyyy').parse(value);
    } else {
     //date = null;
     print("pas de date");
    }
  },
),

          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
             // initialValue:_eventToUpdate!.stoke.toString(),
                    controller: _eventStockController,
              decoration: InputDecoration(
                labelText: 'Stock',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
               
                         _eventToUpdate!.stoke = value as int;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Stoke is required';
                }
                return null;
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
             // initialValue: _eventToUpdate!.desp,
                    controller: _eventDescriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  
                         _eventToUpdate!.desp = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Description is required';
                }
                return null;
              },
            ),
          ),

            Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
             // initialValue: _eventToUpdate!.desp,
                    controller: _eventOrganizerController,
              decoration: InputDecoration(
                labelText: 'Organizer',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  
                         _eventToUpdate!.organizateur= value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Organizer is required';
                }
                return null;
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
                    controller: _eventPriceForStudentController,
              decoration: InputDecoration(
                labelText: 'Price For Student',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                    
                         _eventToUpdate!.priceForStudent = value as double ;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Price is required';
                }
                return null;
              },
            ),
          ),

               Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
                    controller: _eventPriceForNoStudentController,
              decoration: InputDecoration(
                labelText: 'Price For No Student',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                    
                         _eventToUpdate!.priceForNoStudent = value as double ;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Price is required';
                }
                return null;
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
            //  initialValue: _eventToUpdate!.city,
                    controller: _eventCityController,
              decoration: InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
            
                         _eventToUpdate!.city = value;
                });
              },  validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'City is required';
                }
                return null;
              },
            ),
          ),
               SizedBox(height: 10),
                Text("Image:"),
                GestureDetector(
                 onTap: _selectImage,
                //onPressed :_selectImage,
      child: Container(
        height: 200,
        width: 200,
        child: _image != null ? Image.file(_image, fit: BoxFit.cover): Icon(Icons.add_a_photo),
       
         ),
    ),
               

       
         SizedBox(height: 10),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    ElevatedButton(
      onPressed: () {
       updateEventFromSubmit();
      },
      child: Text("Update"),
      style: ElevatedButton.styleFrom(
        primary: Color(0xfffb2056),
      ),
    ),
    ElevatedButton(
      onPressed: () {                              Navigator.pushNamed(context, '/adminlist');

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