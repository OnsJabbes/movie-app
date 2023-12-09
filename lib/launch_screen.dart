import 'package:events/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_screen.dart';
import 'package:events/shared/authentication.dart';

class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 40, // Changer la valeur selon vos besoins
          height: 40, // Changer la valeur selon vos besoins
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Authentication auth = Authentication();
    auth.getUser().then((user) {
      MaterialPageRoute route;
      if (user != null) {
        route = MaterialPageRoute(builder: (context) => HomePage());
      } else {
        route = MaterialPageRoute(builder: (context) => LoginScreen());
      }
      Navigator.pushReplacement(context, route);
    }).catchError((err) => print(err));
  }
}
