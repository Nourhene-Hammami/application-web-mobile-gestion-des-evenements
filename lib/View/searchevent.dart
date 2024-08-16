import 'package:eventmobile/Services/eventservice.dart';
import 'package:eventmobile/View/mydrawer.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/Event.dart';


class SearchEvent extends StatefulWidget {
  @override
  SearchEventState createState() => SearchEventState();
}

class SearchEventState extends State<SearchEvent> {
  List<Event> _eventlist= [];
  List<Event> _originalList= [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchEventListFromRemote().then((value) {
      setState(() {
        _eventlist = value;
        _originalList = value;
      });
    });
  }
void myFunction(String query) {
  setState(() {
    _searchQuery = query.toLowerCase();
      if (_searchQuery.isEmpty) {
      _eventlist = List<Event>.from(_originalList);
      } else {
        // filter events based on search query
        _eventlist = _originalList.where((event) => event.name.toLowerCase().contains(_searchQuery)).toList();
      }
 });
}


@override
Widget build(BuildContext context) {
  return Scaffold(
     appBar: AppBar(
         backgroundColor: Color(0xfffb2056),
        title: Text("Search Event"),
      ),
      drawer: MyDrawer(),
    body: Column(
      children: [
        Container(
        
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                child: TextField(
                  //onChanged: (query) => myFunction(query),
                  onChanged:  myFunction,
                  decoration: InputDecoration(
                    hintText: 'Search for events names..',
                  ),
                ),
              ),
              Table(
                columnWidths: {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(3),
                 
                  2: FlexColumnWidth(2),
                  3: FlexColumnWidth(2),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Event Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                  
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Event Date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                     
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Event Price ForStudent',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                       Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Event Price For No Student',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Event City',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]
                  ),
                  for (var event in _eventlist)
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(event.name),
                        ),
                       
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(event.date.toString()),
                        ),
                      
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${event.priceForStudent}TND'),
                        ),
                         Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${event.priceForNoStudent}TND'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(event.city),
                        ),
                      ]
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}