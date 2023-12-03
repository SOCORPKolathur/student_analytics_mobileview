import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:student_analytics_mobileview/Authendication_Pages/Login_Page.dart';
import 'package:student_analytics_mobileview/HomePage.dart';
import 'firebase_options.dart';


Future<void>_firebasemesssaghandler(RemoteMessage message)async{
  await Firebase.initializeApp();
  print(message.messageId);
}


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebasemesssaghandler);
  runApp( MyApp());
}


class MyApp extends StatelessWidget {

  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
     home:
     FirebaseAuth.instance.currentUser==null? Login_Page(): HomePage()
    );
  }
}

