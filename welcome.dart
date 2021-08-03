import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/constants.dart';
import 'package:fyp/register_login.dart';
import 'package:fyp/state_management/user.dart';
import 'package:fyp/state_management/userLogInCubit.dart';
import 'package:fyp/upload.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  void moveToNextPage(context) async {
    Timer t = Timer(Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool loggedIn = prefs.getBool('loggedIn');

      if (loggedIn == null || loggedIn == false)
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => RegisterLoginScreen()),
            (r) => false);
      else {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => UploadScreen()), (r) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    moveToNextPage(context);
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage('assets/blogo.png'),
          ),
        ),
      ),
    );
  }
}
