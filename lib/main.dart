
import 'package:eventmobile/View/Cart.dart';
import 'package:eventmobile/View/adduser.dart';
import 'package:eventmobile/View/catg.dart';
import 'package:eventmobile/View/chatbot.dart';
import 'package:eventmobile/View/payement.dart';
import 'package:eventmobile/View/profil.dart';
import 'package:eventmobile/View/profiluser.dart';
import 'package:eventmobile/View/searchEventClient.dart';
import 'package:eventmobile/View/searchevent.dart';
import 'package:eventmobile/View/searchuser.dart';
import 'package:eventmobile/View/userList.dart';
import 'package:eventmobile/View/login.dart';
import 'package:flutter/material.dart';
import 'package:eventmobile/View/register.dart';
import 'package:eventmobile/View/eventList.dart';
import 'package:eventmobile/View/addevent.dart';
import 'package:eventmobile/View/editevent.dart';

import 'View/DetailEvent.dart';
import 'View/edituser.dart';



void main() {
   
 
   
  
  
  runApp( MaterialApp(
   
    debugShowCheckedModeBanner: false,
    initialRoute: '/login',
    routes: { 
            '/_ProfileUser':(context)  =>  ProfileUser(),
 
      '/_ProfileAdmin':(context)  =>  ProfileAdmin(),
    '/editevent':(context)  =>  UpdateEventForm(eventId: ModalRoute.of(context)!.settings.arguments as int),//this
      '/searchevent':(context)  =>  SearchEvent(),
   '/login':(context)  =>  LoginPage(),
  '/register' :(context)  =>  RegisterPage(),
  '/adminlist':(context)  =>  EventListPage(),
  '/addevent':(context)  =>  AddEventPage(),
    '/edituser':(context)  =>  UpdateUserForm(userId: ModalRoute.of(context)!.settings.arguments as int),//this
  '/adduser':(context)  =>  AddUserPage(),
      '/searchuser':(context)  =>  SearchUser(),
  '/listuser':(context)  =>  UserListPage(),
 '/catag':(context)  =>  CatalogPage(),
     '/eventdetail':(context)  =>  DetailEventPage(eventId: ModalRoute.of(context)!.settings.arguments as int),//this
  
'/cart':(context)  =>  CartPage(),
'/payer':(context)  =>  PayementPage(),
'/chatbot':(context)  =>  ChatbotPage(),
'/searcheventclient' :(context)  =>  SearchEventClient(),
    },
  ));
}





