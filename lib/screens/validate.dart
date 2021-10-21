import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learning_ui/screens/login.dart';
import 'package:learning_ui/screens/tabs.dart';

class ValidateScreen extends StatefulWidget {
  @override
  _ValidateScreenState createState() => _ValidateScreenState();
}

class _ValidateScreenState extends State<ValidateScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isUserLoggedIn = false;

  validate() {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        setState(() {
          _isUserLoggedIn = true;
        });
      } else {
        setState(() {
          _isUserLoggedIn = false;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    validate();
  }

  @override
  Widget build(BuildContext context) {
    return _isUserLoggedIn ? TabsScreen() : LoginScreen();
  }
}
