import 'package:eventmobile/View/editevent.dart';
import 'package:flutter/material.dart';
import 'package:eventmobile/Services/eventservice.dart';
import 'mydrawer.dart';

import '../Models/Event.dart';


class EventListPage extends StatefulWidget {
   
  @override
  _EventListPageState createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  List<Event> _eventList = [];
   late final int eventId =0;
  @override
  void initState() {
   

   // super.initState();
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
         backgroundColor: Color(0xfffb2056),
        title: Text("Event List"),
      ),
      drawer: MyDrawer(),
      body: _eventList.length == 0 ? Center( child: Text("There are no events yet"),)
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(label: Text("Event Id")),
                  DataColumn(label: Text("Event Name")),
                  DataColumn(label: Text("Event Place")),
                  DataColumn(label: Text("Event Date")),
                  DataColumn(label: Text("Event Stock")),
                  DataColumn(label: Text("Event Description")),
                     DataColumn(label: Text("Event Organizer")),
                  DataColumn(label: Text("Event PriceForStudent") ) ,
                  DataColumn(label: Text("Event PriceForNoStudent") ) ,

                  DataColumn(label: Text("Event City")),
                  DataColumn(label: Text("Event Image")),
                  DataColumn(label: Text("Action")),
                ],
                rows: _eventList
                    .map(
                      (event) => DataRow(cells: [
                        DataCell(Text(event.id.toString())),
                        DataCell(Text(event.name)),
                        DataCell(Text(event.lieu)),
                        DataCell(Text(event.date.toString())),
                        DataCell(Text(event.stoke.toString())),
                        DataCell(Text(event.desp)),
                         DataCell(Text(event.organizateur)),
                        DataCell(Text(event.priceForStudent.toString()) ),
                       DataCell(Text(event.priceForNoStudent.toString())),

                        DataCell(Text(event.city)),
                        DataCell(Container(
                          height: 50,
                          width: 50,
                           child:  Image.network( 'http://10.0.2.2:9000/imageevents/${event.id}'  ),
                        )),


                        DataCell(Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit , color: Colors.grey[450]),
                                
                             onPressed: () async {
    await fetchEventByIdFromRemote(event.id);
  Navigator.pushNamed(context, '/editevent', arguments: event.id);

  
  }, ),              
                            IconButton(
                              icon: Icon(Icons.delete , color: Colors.red),
                              onPressed: () =>
                                  deleteEventByIdFromRemote(event.id),
                                  
                            ),
                          ],
                        )),
                      ]),
                    )
                    .toList(),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _gotoAddEvent,
        child: Icon(Icons.add),
         backgroundColor: Colors.green,
      ),
    );
  }

  void _gotoAddEvent() {
    // Navigate to add event page
    Navigator.pushNamed(context, '/addevent');
  }



  
  

  
}
