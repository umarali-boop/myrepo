import 'package:flutter/material.dart';
import 'package:fyp/result.dart';
import 'package:fyp/state_management/auth.dart';
import 'package:fyp/state_management/utils.dart';
import 'package:fyp/upload.dart';

import 'constants.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController email, pass;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = TextEditingController();
    pass = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 125,
                ),
                TextFormField(
                  controller: email,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: 'Enter your email',
                    labelText: 'Email',
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  controller: pass,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.security),
                    hintText: 'Enter your password',
                    labelText: 'Password',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    height: 50,
                    width: 150,
                    child: RaisedButton(
                      onPressed: () async {
                        loader(context);
                        var user = await Auth().signIn(email.text, pass.text);
                        Navigator.pop(context);
                        if (user != null)
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => UploadScreen()),
                              (r) => false);
                      },
                      color: pCol,
                      child: Text(
                        'SignIn',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
