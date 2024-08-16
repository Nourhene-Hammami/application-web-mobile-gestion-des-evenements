  import 'dart:convert';

import 'package:eventmobile/Services/eventservice.dart';
import 'package:eventmobile/View/mydrawer.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'drawerclient.dart';
import 'package:eventmobile/Models/Event.dart';
class CatalogPage extends StatefulWidget {
  @override
  CatalogPageState createState() => CatalogPageState();
}

class CatalogPageState extends State<CatalogPage> {
  late List<Event> _eventList = [];
  late final int eventId = 0;

  @override
  void initState() {
    super.initState();
    fetchEventListFromRemote().then((events) {
      setState(() {
        _eventList = events;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
        backgroundColor: Color(0x777c2bff),
      ),
      drawer: DrawerClient(),
      body: ListView.builder(
        itemCount: _eventList.length,
        itemBuilder: (BuildContext context, int index) {
          Event event = _eventList[index];
          return Card(
            child: InkWell(
                onTap: () async {
    await fetchEventByIdFromRemote(event.id);
  Navigator.pushNamed(context, '/eventdetail', arguments: event.id);

  
  },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Banner image and text
                  
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            NetworkImage('http://10.0.2.2:9000/imageevents/${event.id}'),
                        fit: BoxFit.cover,
                      ),
                    ),
          
                  ),
                  // Event name and place
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: Text(
                      event.name,

                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: Text(
                      event.lieu,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                      ),
                    ),
                  ),
                  // Event date and city
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: Text(
                      event.date.toString(),
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
