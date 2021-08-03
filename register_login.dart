import 'package:flutter/material.dart';
import 'package:fyp/constants.dart';
import 'package:fyp/signin.dart';
import 'package:fyp/signup.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class RegisterLoginScreen extends StatefulWidget {
  @override
  _RegisterLoginScreenState createState() => _RegisterLoginScreenState();
}

class _RegisterLoginScreenState extends State<RegisterLoginScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    SignUp(),
    SignIn(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup or SignIn'),
        backgroundColor: pCol,
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                gap: 10,
                activeColor: Colors.white,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: Colors.grey[800],
                tabs: [
                  GButton(
                    backgroundColor: pCol,
                    icon: Icons.exit_to_app,
                    text: 'SignUp',
                  ),
                  GButton(
                    backgroundColor: pCol,
                    icon: Icons.label_important,
                    text: 'SignIn',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
    );
  }
}
