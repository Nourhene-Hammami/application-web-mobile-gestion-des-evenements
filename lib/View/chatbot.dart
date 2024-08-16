


import 'dart:async';
import 'dart:math';
//import 'dart:html';
import 'package:eventmobile/Models/chatmodel.dart';
import 'package:eventmobile/View/drawerclient.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html ;

//import 'package:flutter/src/widgets/text.dart' ;
class ChatbotPage extends StatefulWidget {
  @override
  ChatbotPageState createState() => ChatbotPageState();
}

class ChatbotPageState extends State<ChatbotPage> {
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 // final List<String> randomStuff = ["Hello Nice to here you", "How can I help you"];
 final List<String> randomStuff = ["Hello Nice to here you", "How can I help you", "What brings you here?","Hello Nice to here you"];
  final ChatModal chatModal = ChatModal("hello");
  bool sendButton = true;
  String botText = "";
final ScrollController _controller = ScrollController();

  final html.DivElement divSub = html.DivElement();
 //final html.DivElement botMain= html.DivElement();

List<Widget> divMsgs = [];

   void _showChat(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            height: 500.0,
            width: 400.0,
            child: Column(
              children: <Widget>[
                Container(
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/icon.png') ,
                        radius: 25.0,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        'Event ChatBot',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: ListView(
                      children: <Widget>[
                        Text(
                          botText,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 70.0,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  setState(() {
                                    sendButton = false;
                                  });
                                } else {
                                  setState(() {
                                    sendButton = true;
                                  });
                                }
                              },
                              onSaved: (value) {
                                chatModal.inputQuery = value!;
                              },
                              decoration: InputDecoration(
                                labelText: 'Enter Message here',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5.0),
                        FloatingActionButton(
                          onPressed: sendButton
                              ? () {
                                  _sendChat();
                                }
                              : null,
                          child: Icon(Icons.send),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

_sendChat() {
    _formKey.currentState!.save();

    this.sendButton = false;
    final text = Text(this.chatModal.inputQuery);

    if (text.data == "") {
        return false;
    } else {
        print(this.chatModal.inputQuery); 
        final divMain = Container(
            child: Container(
                child: Text(
                    this.chatModal.inputQuery,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Color.fromARGB(255, 134, 190, 216),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            ),
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(bottom: 20.0),
        );
        
        print(divMsgs);

        try {
            if (divMsgs.isEmpty) {
                divMsgs.add(divMain);
            } else {
                // divMsgs.children[0].children.add(this.divMain);
                divMsgs.add(divMain);
            }
        } catch (e) {
            print('Error: $e');
        }

      //  divMsgs.add(divMain); // Bot Msgs

        print(divMain);
        print(divMsgs);

        final random = Random().nextInt(5);
        final botMain = Container(
            child: Container(
               child: Text(
this.chatModal.inputQuery.toLowerCase() == "how can i reserve an event?"
? "To reserve an event, you can simply click on the Reserve button on the desired event page. You can then specify the quantity of seats you wish to reserve in the booking form."
: this.chatModal.inputQuery.toLowerCase() == "how can i pay for my reservation?"
? "To pay for your reservation, you can click on the Validation button after filling out the reservation form."
: this.chatModal.inputQuery.toLowerCase().contains("thank you") 
? "Welcome"
: this.chatModal.inputQuery.toLowerCase().contains("hello ") 
? "Hello Nice to here you"
: "How can I help you",
),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Color.fromARGB(255, 229, 229, 229),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            ),
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(bottom: 20.0),
        );

        divMsgs.add(botMain); // Bot Msgs

      _controller.animateTo(_controller.position.maxScrollExtent,
        duration: Duration(milliseconds: 300), 
       curve: Curves.easeOut);

        this.chatModal.inputQuery = "";

        Timer(Duration(milliseconds: 500), () {
            setState(() {
                this.sendButton = true;
            });
        });
    }
}

/*_sendChat() {

_formKey.currentState!.save();

this.sendButton = false;
final text = Text(this.chatModal.inputQuery);

if (text.data == "") {
return false;
} else {
print(this.chatModal.inputQuery); 
final divMain = Container(
child: Container(
child: Text(
this.chatModal.inputQuery,
),
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(5.0),
color: Color.fromARGB(255, 4, 54, 77),
),
padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
),
alignment: Alignment.centerRight,
margin: EdgeInsets.only(bottom: 20.0),
);
  print(divMsgs);
  try{
if (divMsgs.isEmpty) {

divMsgs.add(divMain );
//html.document.body!.append(divMsgs as html.Node);

} else {
   // divMsgs.children[0].children.add(this.divMain);
  divMsgs.add(divMain  );
}}catch (e) {
    print('Error: $e');
  }
  divMsgs.add(divMain  ); // Bot Msgs

print(divMain);
print(divMsgs);



final random = Random().nextInt(5);
 final botMain = Container(
child: Container(
child: Text(
this.chatModal.inputQuery.toLowerCase() == "how can i reserve an event?"
? "To reserve an event, you can simply click on the Reserve button on the desired event page. You can then specify the quantity of seats you wish to reserve in the booking form."
: this.chatModal.inputQuery.toLowerCase() == "how can i pay for my reservation?"
? "To pay for your reservation, you can click on the Validation button after filling out the reservation form."
: this.chatModal.inputQuery.toLowerCase().contains("thank you") 
? "Welcome"
: this.randomStuff[random],
),
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(5.0),
color: Color.fromARGB(255, 211, 9, 9),
),
padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
),
alignment: Alignment.centerLeft,
margin: EdgeInsets.only(bottom: 20.0),
);
divMsgs.add(botMain );





if (divMsgs.length > 0) {
 // divMsgs = botMain as List<Widget> ;
  divMsgs.add(botMain);

} 

final out = html.document.getElementById('chatlogs');
if (out != null) {
final isScrolledToBottom = out.scrollHeight - out.clientHeight <= out.scrollTop + 1;
print(isScrolledToBottom);
if (!isScrolledToBottom) out.scrollTop = out.scrollHeight - out.clientHeight;
this.chatModal.inputQuery = "";
}
}
return true;
}


*/

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Chatbot "),
        backgroundColor: Color(0x777c2bff),
      ),
      drawer: DrawerClient(),
      
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _controller, // assign the controller here
              itemCount: divMsgs.length,
              itemBuilder: (BuildContext context, int index) {
                return divMsgs[index];
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                      ),
                      onChanged: (value) {
                        this.chatModal.inputQuery = value;
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: this.sendButton ? () => _sendChat() : null,
                    icon: Icon(Icons.send),
                    color: this.sendButton
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }}

 /* @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Chatbot "),
        backgroundColor: Color(0x777c2bff),
      ),
      drawer: DrawerClient(),
      
      body: Center(
        
        child: ElevatedButton(
          child: Text('Open Chat'),
          onPressed: () {
            _showChat(context);
          },
        ),
      ),
    );
}}*/