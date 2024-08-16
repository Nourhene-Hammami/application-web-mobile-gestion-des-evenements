import 'dart:convert';

import 'package:eventmobile/Services/eventservice.dart';
import 'package:eventmobile/View/drawerclient.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/Event.dart';

class  DetailEventPage extends StatefulWidget {
  late int eventId  ;
 DetailEventPage({Key? key, required int  eventId}) : super(key: key){
    this.eventId = eventId;
  }


  @override
   DetailEventPageState createState() =>  DetailEventPageState();
}


class  DetailEventPageState extends State< DetailEventPage> {

 late List<Event> _eventList = [];
 late Future<Event> _event;

    @override
void initState() {
  super.initState();
    _event = fetchEventByIdFromRemote(widget.eventId); // Assuming there's a function named fetchEvent that returns a Future<Event> object.

}
List cartItemList = [];

Future<double> getTotalPrice() async {
  double grandTotal = 0;
  for (var event in cartItemList) {
    grandTotal += event['total']?.toDouble()??0.0;
  }
SharedPreferences prefs = await SharedPreferences.getInstance();
await prefs.setDouble('grandTotal', grandTotal);
print('grandTotal $grandTotal');
  return grandTotal;
}

Future<void> addToCart(Event event) async {

SharedPreferences prefs = await SharedPreferences.getInstance();
String? cartItemsFromStorage = prefs.getString('cartItems');

if (cartItemsFromStorage != null) {
  cartItemList = json.decode(cartItemsFromStorage);
}

  // Rechercher l'article dans le panier
  int itemIndex =
      cartItemList.indexWhere((item) => item['id'] == event.id);
  if (itemIndex != -1) {
    // Vérifier si la quantité est déjà 5
    if (cartItemList[itemIndex]['qte'] >= event.stoke) {
      print('Stock epuise ');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Stock sold out'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => 
                        Navigator.pushNamed(context, '/cart')

            ),
          ],
        ),
      );
      return;
    } else {
      // L'article existe déjà dans le panier, augmenter la quantité
      print(cartItemList[itemIndex]['qte']);
      cartItemList[itemIndex]['qte']++;
      print(cartItemList[itemIndex]['qte']);
if (event.ticketType == 'student') {
      
        cartItemList[itemIndex]['priceForStudent'] = event.priceForStudent;
        cartItemList[itemIndex]['total'] = cartItemList[itemIndex]['qte'] * cartItemList[itemIndex]['priceForStudent'] ;
      
      
      } else if (event.ticketType == 'non-student'){
        
        
        cartItemList[itemIndex]['priceForNoStudent'] = event.priceForNoStudent;
         cartItemList[itemIndex]['total'] = cartItemList[itemIndex]['qte'] * cartItemList[itemIndex]['priceForNoStudent'] ;
      }
 
 
    }
  }
  
  
   else {
    // Ajouter l'article au panier
    Map item = {
      'id': event.id,
      'title': event.name,
 'priceForStudent': event.priceForStudent,
'priceForNoStudent': event.priceForNoStudent,
      'qte': 1,
     'petitTotal': 0.0,

    };
    void _updateEventTotal(Event event) {
  setState(() {   
    double price = event.ticketType == 'student'
        ? event.priceForStudent
        : event.priceForNoStudent;
    item['petitTotal'] = item['qte'] * price;
  });
}
void _onQuantityChanged(int quantity) {
  setState(() {
    item['qte'] = quantity;
    _updateEventTotal(event);
  });
}  void _onRadioChanged(String value) {
  setState(() {
    item['ticketType'] = value;
    _updateEventTotal(event);
  });}
    cartItemList.add(item);
  }

 // Store the list of items in the cart in local storage
//SharedPreferences prefs = await SharedPreferences.getInstance();
prefs.setString('cartItems', jsonEncode(cartItemList));
print('cart  $cartItemList');
  _eventList.clear();
  for (var item in cartItemList) {
     Event event = Event(
      id:item['id'],
      name: item['title'],
      priceForStudent: item['price'],
      qte: item['qte'],
      total: item['total'],
      city: '',
      date: item['date'],
      desp: '',
      filenameimg: '',
      lieu: '',
      organizateur: '',
      priceForNoStudent: item['price'],
      stoke: 0,
     ticketType: item['ticketType'],
    );
    _eventList.add(event);
  }
  getTotalPrice();
  
 
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Event added to cart successfully'),
      actions: [
        TextButton(
          child: Text('OK'),
          onPressed: () =>             Navigator.pushNamed(context, '/cart')
,
        ),
      ],
    ),
  );

}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Color(0x777c2bff),
      title: Text('Detail Event.'),
    ),
    drawer: DrawerClient(),
    body: FutureBuilder(
      future: _event,
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
          final event = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 70),
                  child: Image.network('http://10.0.2.2:9000/imageevents/${event.id}'),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  color: Colors.grey[200],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.name,
                        style: TextStyle(
                          color: Color(0xfffb2056),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 20),
                          SizedBox(width: 8),
                          Text(event.date.toString()),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 20),
                          SizedBox(width: 8),
                          Text(event.lieu),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'ABOUT THIS EVENT :',
                        style: TextStyle(
                          color: Color(0xff7c2bff),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(event.desp),
                         SizedBox(height: 16),
                      Text(
                        'ABOUT THE ORGANIZER :',
                        style: TextStyle(
                          color: Color(0xff7c2bff),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(event.organizateur),
                      SizedBox(height: 16),
                      Text(
                        '***PriceForStudent: ${event.priceForStudent} TND***',
                        style: TextStyle(
                          color: Color(0xfffb2056),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                        SizedBox(height: 16),
                      Text(
                        '***PriceForNoStudent: ${event.priceForNoStudent} TND***',
                        style: TextStyle(
                          color: Color(0xfffb2056),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 16),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 100),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Book your place quickly:',
                                    style: TextStyle(
                                      color: Color(0xff7c2bff),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: () {
                              addToCart(event);
                            },
                            icon: Icon(Icons.calendar_today),
                            label: Text('Reserve'),
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xff7c2bff),
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
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
      },
    ),
  );
}
}