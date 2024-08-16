import 'dart:convert';

import 'package:eventmobile/Models/Lpanier.dart';
import 'package:eventmobile/Models/Panier.dart';
import 'package:eventmobile/View/drawerclient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eventmobile/Services/panierservice.dart';

class  PayementPage extends StatefulWidget {
 PayementPage({Key? key}) : super(key: key);

  @override
  PayementPageState createState() =>  PayementPageState();
}

class  PayementPageState extends State< PayementPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _adresseController = TextEditingController();
  final _villeController = TextEditingController();
  final _telController = TextEditingController();
  final codepController = TextEditingController();
   bool formIsValid = false;
    List _eventlist = [];
     double grandTotal=0.0;
PanierService panierService = PanierService();
  @override
  void dispose() {
    _nomController.dispose();
    _adresseController.dispose();
    _villeController.dispose();
    _telController.dispose();
    codepController.dispose();
    super.dispose();
  }
  Future<double> _getGrandTotal() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getDouble('grandTotal') ?? 0.0;
}

void valider() async {
  if (_formKey.currentState!.validate()) {
    formIsValid = true;
   int? panierId;
    int? userId;

    final info = Panier(
      nom: _nomController.text,
      adresse: _adresseController.text,
      ville: _villeController.text,
   tel: int.parse(_telController.text),
 codep:codepController.text,
      id: 0,
    );

  //  await _dataService.setNom(_nomController.text);
    //await _dataService.setAdress(_adresseController.text);
 //   await _dataService.setVille(_villeController.text);
  //  await _dataService.setTel(_telController.text);
 //   await _dataService.setCodep(_codepController.text);

    try {
      panierId = await panierService.saveOrUpdate(info);
      print( "Panier id $panierId");

SharedPreferences prefs = await SharedPreferences.getInstance();
await prefs.setInt('panier', panierId!);
 
panierId = prefs.getInt('panier');
print( " get Panier id  $panierId");
 print('Event added to panier database successfully');
    for (final currentEvent in _eventlist) {

  SharedPreferences prefs = await SharedPreferences.getInstance();
int? panierId = prefs.getInt('panier');





      //  final libelle = currentEvent.name;
       // final qte = currentEvent.qte;

        final eventToAdd = Lpanier(
          libelle: currentEvent['title'],
          price: currentEvent['ticketType'] == 'student'
              ? currentEvent['priceForStudent']
              : currentEvent['priceForNoStudent'],
          qte: currentEvent['qte'],
          total: currentEvent['petitTotal'],
          ticketType: currentEvent['ticketType'],
          panierId: panierId!,
          id: 0,
        );

      //  await _dataService.setNameEvent(libelle);
       // await _dataService.setQteEvent(qte);

        print(panierId);
     /*   String? userJson = prefs.getString('user');
if (userJson != null) {
  Map<String, dynamic> userData = json.decode(userJson);
   // Get the user ID
  int userId = userData['id'];
  
print( " get User id  $userId");
  
}
        print("userID= $userId");*/
        String? userJson = prefs.getString('user');
int? userId;

if (userJson != null) {
  Map<String, dynamic> userData = json.decode(userJson);
  // Get the user ID
  userId = userData['id'];
  print("get User id $userId");
}

print("userID= $userId");


        await panierService.addToLpanier(eventToAdd, panierId, userId!).then(
          (value) => print('Event added to lpanier to database successfully'),
          onError: (error) =>
              print('Error adding event to lpanier database: $error'),
        );
      }
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Success'),
          content: Text('Payment made successfully. Can now consult your attestation .'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } catch (error) {
      print('Error adding event to database: $error');
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred while processing your payment.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
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
       getCartItemsFromStorage();
       _getGrandTotal().then((value) {
      setState(() {
        grandTotal = value;
      });
    });

}
 Future<void> getCartItemsFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartItemsFromStorage = prefs.getString('cartItems');
    if (cartItemsFromStorage != null) {
      setState(() {
   List<dynamic> items = json.decode(cartItemsFromStorage);
    setState(() {
      _eventlist = items;
      print("cart=  $_eventlist");
    });

      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payement Page'),
         backgroundColor: Color(0x777c2bff),
      ),
      drawer: DrawerClient(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nomController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Full Name is required.';
                    }
                    if (value.length < 3) {
                      return 'Full Name is too short.';
                    }
                    if (!RegExp(r'^[a-zA-Z]+').hasMatch(value)) {
                      return 'Full Name should start with Alphabet.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _adresseController,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Address is required.';
                    }
                    if (value.length < 5) {
                      return 'Address is too short.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _villeController,
                        decoration: InputDecoration(
                          labelText: 'City',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'City is required.';
                          }
                          if (value.length < 3) {
                            return 'City is too short.';
                          }
                          if (!RegExp(r'^[a-zA-Z]+').hasMatch(value)) {
                            return 'City should start with Alphabet.';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        controller: _telController,
                        decoration: InputDecoration(
                          labelText: 'Phone',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Phone is required.';
                          }
                          if (value.length < 8) {
                            return 'Phone is too short.';
                          }
                          if (!RegExp(r'^[0-9]+').hasMatch(value)) {
                            return 'Phone should be with Number.';
                          }
                        })),
                  ]),
                         SizedBox(width: 20),
                    TextFormField(
                        controller: codepController,
                        decoration: InputDecoration(
                          labelText: 'Postal Code',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'postal code  is required.';
                          }
                          if (value.length != 4) {
                            return 'Postal Code must be egal 4 characters long.';
                          }
                        
                        }),

                        FormField<String>(
  builder: (FormFieldState<String> state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text("Payment method:"),
       

        DropdownButtonFormField<String>(
items: [
          DropdownMenuItem(
            value: "Bank Card",
            child: Text("Bank Card"),
          ),
          DropdownMenuItem(
            value: "checks",
            child: Text("Checks"),
          ),
          DropdownMenuItem(
            value: "Credit Card",
            child: Text("Credit Card"),
          ),
          DropdownMenuItem(
            value: "Debit Card",
            child: Text("Debit Card"),
          ),],
         
          onChanged: (String? newValue) {
            // paiement = value;
          },
        //  value: _userroleController.text,
          decoration: InputDecoration(
            hintText: 'Select a payement method',
            errorText: state.errorText,
          ),
        ),
      ],
    );
  },
  /*validator: (value) {
    if (value == null) {
      return 'Please  select a payement method.';
    }
    return null;
  },*/
),

SizedBox(height: 20),
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          valider();
        }
      },
      child: Row(
        children: [
          Icon(Icons.check),
          SizedBox(width: 5),
          Text("Validation"),
        ],
      ),
    ),
    SizedBox(width: 10),
    ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/cart');
      },
      child: Row(
        children: [
          Icon(Icons.arrow_back),
          SizedBox(width: 5),
          Text("Back"),
        ],
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        onPrimary: Colors.black,
      ),
    ),
  ],
),
/*SizedBox(height: 10),
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    ElevatedButton(
      onPressed: formIsValid
          ? () {
              Navigator.of(context).pushNamed("/attestation");
            }
          : null,
      child: Row(
        children: [
          Icon(Icons.verified),
          SizedBox(width: 5),
          Text("Attestation"),
        ],
      ),
      style: ElevatedButton.styleFrom(
        primary: formIsValid==true ? Colors.pink : Colors.grey,
      ),
    ),
  ],
),
    */             
Column(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    Container(
      margin: EdgeInsets.only(top: 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Your cart",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Text(
                          "Event",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          "Ticket Type",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Price",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Qte",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Total",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _eventlist.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_eventlist[index]['title']?? ''),
                                Image.network( 'http://10.0.2.2:9000/imageevents/${ _eventlist[index]['id']}' ,
                                  height: 70,
                                  width: 120,
                                ),
                          ],
                            ),
                          ),
                          Expanded(
                            flex: 6,
                             child: Text(_eventlist[index]['ticketType']?? '')
                             ,
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              _eventlist[index]['ticketType'] == 'student'
                                  ? _eventlist[index]['priceForStudent'].toString()?? '' +  " TND"
                                  : _eventlist[index]['priceForNoStudent']
                                          .toString() ?? '' +" TND",
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(_eventlist[index]['qte'].toString()?? ''),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(_eventlist[index]['petitTotal'].toString()?? ''),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Total to pay: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        grandTotal.toString() + 
                       " TND" ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.pink),
                      ),
                    ],
                  ),
                ),
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              ],
            ),
          ),
        ],
      ),
    ),
    ])])))));}}    