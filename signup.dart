import 'package:flutter/material.dart';
import 'package:fyp/constants.dart';
import 'package:fyp/result.dart';
import 'package:fyp/state_management/auth.dart';
import 'package:fyp/state_management/utils.dart';
import 'package:fyp/upload.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

enum SingingCharacter { Male, Female }

class _SignUpState extends State<SignUp> {
  SingingCharacter _character = SingingCharacter.Male;
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 75,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      activeColor: pCol,
                      value: SingingCharacter.Male,
                      groupValue: _character,
                      onChanged: (SingingCharacter value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                    Text('Male'),
                    Radio(
                      value: SingingCharacter.Female,
                      groupValue: _character,
                      onChanged: (SingingCharacter value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                    Text('Female'),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 50,
                    width: 150,
                    child: RaisedButton(
                      onPressed: () async {
                        loader(context);
                        var user = await Auth().register(
                            email: email.text,
                            password: pass.text,
                            gender: _character.index == 0 ? "male" : "female");
                        Navigator.pop(context);
                        if (user != null)
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => UploadScreen()),
                              (r) => false);
                      },
                      color: pCol,
                      child: Text(
                        'SignUp',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
