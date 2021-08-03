import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyp/constants.dart';
import 'package:fyp/state_management/database.dart';
import 'package:fyp/state_management/history.dart';

class Result extends StatefulWidget {
  final File image;
  final String desc, email;
  const Result({Key key, this.image, this.desc, this.email}) : super(key: key);
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postHistory();
  }

  postHistory() async {
    var hist = History(
        date: "${DateTime.now().toString().split(' ')[0]}",
        email: widget.email,
        response: widget.desc);
    await Database().postHistory(history: hist);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pCol,
        title: Text('Result'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: FileImage(widget.image),
              )),
              height: 300,
              width: MediaQuery.of(context).size.width - 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Result',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${widget.desc}',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: pCol,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Back',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
