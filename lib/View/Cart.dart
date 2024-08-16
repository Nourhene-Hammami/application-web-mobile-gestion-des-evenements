import 'dart:convert';
import 'package:eventmobile/Models/Event.dart';
import 'package:eventmobile/Services/eventservice.dart';
import 'package:eventmobile/View/drawerclient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CartPage extends StatefulWidget {
  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
   // Define a list to store the cart items
 // List<Event> _eventList = [];
  
      List cartItemList = [];
 

late String? ticketType;
late SharedPreferences prefs;
  // Define a variable to store the total amount of the cart
  double grandTotal = 0.0;
double petitTotal=0.0;


void _setGrandTotal(double grandTotal) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setDouble('grandTotal', grandTotal);
  print(grandTotal);
}

  double _calculateGrandTotal() {
    double total = 0.0;
   cartItemList.forEach((event) {
    total +=  event['petitTotal']?.toDouble() ??0.0;
    });
     // Stockage du grandTotal dans les SharedPreferences
_setGrandTotal(grandTotal);

    return total;
  }

  // Define a function to update the total amount of a cart item
  Future<void> _updateEventTotal(Map<String, dynamic> eventData) async {
        Event event = Event.fromJson(eventData);

   setState(() {
    int eventIndex = cartItemList.indexWhere((item) => item['id'] == event.id);
    if (event.ticketType == 'student') {
      cartItemList[eventIndex]['petitTotal'] = event.qte * event.priceForStudent;
    } else if (event.ticketType == 'non-student') {
     cartItemList[eventIndex]['petitTotal'] = event.qte * event.priceForNoStudent;
    } grandTotal = _calculateGrandTotal();
    });

 print(cartItemList);
  }

  // Define a function to remove an item from the cart
 
  Future<void> _removeItem(Map<String, dynamic> eventData) async {
     Event event = Event.fromJson(eventData);
  setState(() {
  cartItemList.remove(event);
   
    if (grandTotal != null) {
      grandTotal = _calculateGrandTotal();
    }
  });
    SharedPreferences prefs = await SharedPreferences.getInstance();
  String? cartItemsFromStorage = prefs.getString('cartItems');
  if (cartItemsFromStorage != null) {
    List<dynamic> cartItemList = json.decode(cartItemsFromStorage);
    cartItemList.removeWhere((item) => item['id'] == event.id);
    await prefs.setString('cartItems', json.encode(cartItemList));
  }
   print("event suprrimer" );
}



void emptyCart() async {
  setState(() {
    cartItemList.clear();
    grandTotal = 0;
  });

  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('cartItems', json.encode(cartItemList));

  print("Cart emptied");
}

      @override
void initState() {
  super.initState();
       getCartItemsFromStorage();

}
 Future<void> getCartItemsFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartItemsFromStorage = prefs.getString('cartItems');
    if (cartItemsFromStorage != null) {
      setState(() {
   List<dynamic> items = json.decode(cartItemsFromStorage);
    setState(() {
      cartItemList = items;
      print("cart= $cartItemList");
    });

      });
    }
  }
int getQuantityById(int id) {
    Map<String, dynamic> item = cartItemList.firstWhere(
        (element) => element['id'] == id,
        orElse: () => {'qte': 0});
             print(item['qte']);

    return item['qte'];
  }
void updateTicketType(String newType) {
  setState(() {
  
    ticketType = newType;
     
  });}
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Cart "),
      backgroundColor: Color(0x777c2bff),
    ),
    drawer: DrawerClient(),
    body: cartItemList.length != 0
      ? Container(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItemList.length,
                  itemBuilder: (context, index) {
                    final event = cartItemList[index];
                       //   double petitTotal = eventTotals[index];

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                //Text(event.title),
                                Text(event['title']),

                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () => _removeItem(event),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text('Ticket Type: '),
                                Expanded(
                                  child: RadioListTile(
                                    title: Text('For Student'),
                                    value: 'student',
                                    groupValue: event['ticketType'],
                                    onChanged: (value) {
                                      setState(() {
                                        event['ticketType'] = value!;
                                  _updateEventTotal(event);
                                grandTotal = _calculateGrandTotal();
 int index = cartItemList.indexWhere((element) => element['id'] ==  event['id']);
          if (index != -1) {
            cartItemList[index]['ticketType'] = event['ticketType'];
            // Update shared preferences with new cartItemList
            SharedPreferences.getInstance().then((prefs) {
              prefs.setString('cartItems', json.encode(cartItemList)); });    }
                                     
                                   });   },
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile(
                                    title: Text('For No-Student'),
                                    value: 'non-student',
                                   groupValue: event['ticketType'],
                                     //   groupValue: cartItemList[index], 
                                    onChanged: (value) {
                                      setState(() {
                                      event['ticketType'] = value!;
                                     // 
                                         //  updateTicketType(value); 
                                         _updateEventTotal(event);
                                          int index = cartItemList.indexWhere((element) => element['id'] ==  event['id']);
          if (index != -1) {
            cartItemList[index]['ticketType'] = event['ticketType'];
            // Update shared preferences with new cartItemList
            SharedPreferences.getInstance().then((prefs) {
              prefs.setString('cartItems', json.encode(cartItemList)); });    }
                                         grandTotal = _calculateGrandTotal();
                                      });
                                    
                                    },
                                  ),
                                ),
                              ],
                            ),
                           SizedBox(height: 10),
Row(
  children: [
    Text('Price: '),
    Text(
      event['ticketType'] == 'student'
             ? '${event['priceForStudent']?? 0} TND'
          : event['ticketType'] == 'non-student'
              ? '${event['priceForNoStudent'] ?? 0} TND'
              : '0000 TND',
    ),
  ],
),

                           
                          SizedBox(height: 10),
  Row(
    children: [
      Text('Quantity: '),
      Expanded(
        child: TextFormField(
       //   controller: TextEditingController(text: event.qte.toString()),
         controller: TextEditingController(text: getQuantityById(event['id']).toString()),

          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              if (value.isEmpty) {
               event['qte'] = 0;
              } else {
                try {
                   event['qte'] = int.tryParse(value) ?? 0;
           // Update cartItemList with new quantity
          int index = cartItemList.indexWhere((element) => element['id'] ==  event['id']);
          if (index != -1) {
            cartItemList[index]['qte'] = event['qte'];
            // Update shared preferences with new cartItemList
            SharedPreferences.getInstance().then((prefs) {
              prefs.setString('cartItems', json.encode(cartItemList)); });    }
              
              
               } catch (e) {
                  print("Error parsing quantity value: $value");
                }
              }
      _updateEventTotal(event);

            });
          },
        ),
      ),
    ],
  ),

                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text('Total: '),
       
                               Text('${ event['petitTotal']?? 0} TND'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
             SizedBox(  height: 10,),
Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    Text(
      'Grand Total: ',
      style: TextStyle(
        color: Color(0xfffb2056),
        fontWeight: FontWeight.bold,
      ),
    ),
    Text('$grandTotal TND'),
    Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: emptyCart,
            child: Text(
              'Empty Cart',
              style: TextStyle(
                color: Color(0xff101111),
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Color(0xffff1f1f),
              ),
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/catag');
            },
            child: Text(
              'Shop more',
              style: TextStyle(
                color: Color(0xff101111),
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Color(0xff17c8ff),
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/payer');
            },
            child: Text(
              'Payment',
              style: TextStyle(
                color: Color(0xff101111),
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Color(0xff23d160),
            ),
          ),
        ],
      ),
    ),
  ],
),
            ],),):Center(child: Text('Cart is empty :')),

            );}
            }