import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

import 'mydrawer.dart';
//import'package:model_progress_hud_nsn/model_progress_hud_nsn.dart';
class AddEventPage extends StatefulWidget {
  
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
DateTime _selectedDate = DateTime.now();

//late File? _image;
 late  File _image = File('');
bool showSpinner=false;

  final _formKey = GlobalKey<FormState>();
  late String name ="", lieu="", city="",   desp="",organizateur="";
 late int stoke,priceForNoStudent,priceForStudent;
 // late int? id=0;
 late DateTime date;
  late String _imgURL ="";

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final response = await addEventToRemote();
      print(response.statusCode);
      final responseBody = await response.stream.bytesToString();
      print(responseBody);




      if (response.statusCode == 200) {
        print("Event added successfully");
      //  Navigator.pop(context);
            Navigator.pushNamed(context, '/adminlist');
      } else {
        print("Error adding event ");
      }
    }
  }

_selectImage() async {

  final pickedImage = await ImagePicker().getImage(source: ImageSource.gallery,imageQuality:80);
    setState(() {
      _image = File(pickedImage!.path);
      _imgURL = pickedImage.path;
      print(_imgURL);
    });
}
/*void _uploadImage() async {
  // Check if an image has been selected
  if (_image == null) {
    return;
  }

  // Create a multipart request for uploading the image
  final url = Uri.parse("http://10.0.2.2:9000/addevent/");
  var request = http.MultipartRequest("POST", url);

  // Add the image to the request
  request.files.add(await http.MultipartFile.fromPath("image", _image.path));

  // Send the request and wait for the response
  var response = await request.send();

  // Check the response status code
  if (response.statusCode == 200) {
    // The image has been uploaded successfully
    print("Image uploaded");
  } else {
    // There was an error uploading the image
    print("Error uploading image: ${response.statusCode}");
  }
}*/

  Future<http.StreamedResponse> addEventToRemote() async {
    final uri = Uri.parse("http://10.0.2.2:9000/addevent");
    final request = http.MultipartRequest("POST", uri);
 
 //   request.fields['id'] = id.toString();
   /* request.fields['name'] = name;
    request.fields['lieu'] = lieu;
    request.fields['city'] = city;
    request.fields['date'] = date.toString();
    request.fields['stoke'] = stoke.toString();
    request.fields['desp'] = desp;
    request.fields['price'] = price.toString();
    print(_image.path);*/
    // create a DateFormat object to format the date as a string
//final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
//final DateFormat formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSX");

//final DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSX");
//SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSXXX");
// Create a DateTime object representing the date you want to format
DateTime date = DateTime.now();

// Create a DateFormat object with the desired format
DateFormat formatter = DateFormat('yyyy-MM-dd');


    request.fields['event'] = jsonEncode({
    'name': name,
    'lieu': lieu,
    'city': city,
    //'date': date.toString(),
      'date': formatter.format(date), // format the date using the formatter
//'date':"2023-04-25T00:00:00.000Z",
    'stoke': stoke.toString(),
    'desp': desp,
         'Organizer':organizateur,

    'priceForStudent': priceForStudent.toString(),
    'priceForNoStudent': priceForNoStudent.toString(),
    'filenameimg': _imgURL
});

   //request.fields['filenameimg'] =_imgURL;

    request.files.add(http.MultipartFile.fromBytes(
        'file', 
        _image.readAsBytesSync(),
         filename: _image.path.split('/').last)         );
     
    final response = await request.send(); 
    print(response);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add event"),
         backgroundColor: Color(0xfffb2056),
      
      ),
      drawer: MyDrawer(),
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
                  onSaved: (value) => name = value!,
                  validator: (value) => value!.isEmpty ? "Name cannot be empty" : null,
                ),
                SizedBox(height: 10),
                Text("Place:"),
                TextFormField(
                  onSaved: (value) => lieu = value!,
                ),
                SizedBox(height: 10),
                Text("City:"),
                TextFormField(
                  onSaved: (value) => city = value!,
                ),
                /*SizedBox(height: 10),
                Text("Date:"),
                TextFormField(
                 // onSaved: (value) => date = DateTime.parse(value!),
                   onSaved: (value) => date = DateFormat("dd/MM/yyyy").parse(value!),

                ), */
                TextFormField(
  decoration:
   InputDecoration(labelText: 'Date'),
  readOnly: true, // make the field read-only
  onTap: () async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
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

                SizedBox(height: 10),
                Text("Stock:"),
                TextFormField(
                  onSaved: (value) => stoke = int.parse(value!),
                ),
                SizedBox(height: 10),
                Text("Description:"),
                TextFormField(
                  onSaved: (value) => desp = value!,
                ),
                  SizedBox(height: 10),
                Text("Organizer:"),
                TextFormField(
                  onSaved: (value) => organizateur = value!,
                ),
                SizedBox(height: 10),
                Text("Price For Student:"),
                TextFormField(
                  onSaved: (value) => priceForStudent =int.parse( value!),
                ),
                 SizedBox(height: 10),
                Text("Price For No Student:"),
                TextFormField(
                  onSaved: (value) => priceForNoStudent =int.parse( value!),
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
  /*  ElevatedButton(
onPressed: _uploadImage,
 //  onPressed:  _submitForm,
  child: Text("Upload"),
), */
  /* SizedBox(height: 10),
    ElevatedButton(
      onPressed: () {
       _submitForm();
      },
      child: Text("Submit"),
    ),
    SizedBox(height: 10),
    ElevatedButton(
      onPressed: () {
       // Navigator.pop(context);
        Navigator.pushNamed(context, '/adminlist');
      },
      child: Text("Back"),
    ),   */
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
        Navigator.pushNamed(context, '/adminlist');
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