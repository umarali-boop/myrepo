import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/constants.dart';
import 'package:fyp/history_page.dart';
import 'package:fyp/register_login.dart';
import 'package:fyp/result.dart';
import 'package:fyp/state_management/user.dart';
import 'package:fyp/state_management/userLogInCubit.dart';
import 'package:fyp/state_management/userState.dart';
import 'package:fyp/state_management/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  bool isLoading = true;
  SharedPreferences prefs;

  Future getImage() async {
    var dio = Dio();
    PickedFile img =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    loader(context);
    File image = File(img.path);
    String type = image.path.split('.').last;
    String name = image.path.split('/').last;
    print("TYPE $type");
    FormData formData = new FormData.fromMap({
      "type": type,
      "file": await MultipartFile.fromFile(image.path, filename: name)
    });
    var response =
        await dio.post('https://7143bf627eb5.ngrok.io//predict', data: formData);
    // var response = await http.post(
    //     Uri.parse('https://f57842ba8cf5.ngrok.io/predict'),
    //     headers: {"enctype": 'multipart/form-data'},
    //     body: {'file': base64Image, 'type': type});
    print("@RESPONSE ${response.statusCode} ");
    print("@RESPONSE ${response.data} ");
    var msg = response.data;
    var email = MyUser.fromJson(json.decode(prefs.getString('user'))).email;
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => Result(
                  email: email,
                  image: image,
                  desc: msg['message'],
                )));
  }

  void setUser(context) async {
    prefs = await SharedPreferences.getInstance();
    MyUser user = MyUser.fromJson(json.decode(prefs.getString('user')));
    await BlocProvider.of<UserCubit>(context).update(user);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => setUser(context));
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: bCol,
            drawer: Drawer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0, left: 15),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage('assets/blogo.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0, left: 10),
                        child: Text(
                          'CANCERIFY',
                          style: TextStyle(
                              color: pCol,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Divider(
                    color: pCol,
                    height: 2,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    title: Text(
                      'About',
                      style: TextStyle(
                          color: pCol,
                          fontWeight: FontWeight.w500,
                          fontSize: 22),
                    ),
                    leading: Icon(
                      Icons.info_outline,
                      color: pCol,
                    ),
                  ),
                  BlocBuilder<UserCubit, UserState>(builder: (context, state) {
                    if (state is UserLoadedState)
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => HistoryPage(
                                        email: state.user.email,
                                      )));
                        },
                        child: ListTile(
                          title: Text(
                            'Previous Checkups',
                            style: TextStyle(
                                color: pCol,
                                fontWeight: FontWeight.w500,
                                fontSize: 22),
                          ),
                          leading: Icon(
                            Icons.history,
                            color: pCol,
                          ),
                        ),
                      );
                    else
                      return Container();
                  }),
                  InkWell(
                    onTap: () async {
                      loader(context);
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setBool('loggedIn', false);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => RegisterLoginScreen()),
                          (r) => false);
                    },
                    child: ListTile(
                      title: Text(
                        'SignOut',
                        style: TextStyle(
                            color: pCol,
                            fontWeight: FontWeight.w500,
                            fontSize: 22),
                      ),
                      leading: Icon(
                        Icons.arrow_back,
                        color: pCol,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              title:
                  BlocBuilder<UserCubit, UserState>(builder: (context, state) {
                if (state is UserLoadedState)
                  return Text(state.user.email);
                else
                  return Text('CANCERIFY');
              }),
              backgroundColor: pCol,
            ),
            body: Column(
              children: [
                Image(
                  image: AssetImage('assets/index.png'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Tap the button below to get started'),
                ),
                SizedBox(
                  height: 150,
                ),
                Center(
                  child: Container(
                    height: 50,
                    width: 150,
                    child: RaisedButton(
                      color: pCol,
                      onPressed: getImage,
                      child: Center(
                        child: Row(
                          children: [
                            Icon(Icons.file_upload),
                            Text(
                              'Upload Image',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {
            //     print(DateTime.now());
            //   },
            // ),
          );
  }
}
