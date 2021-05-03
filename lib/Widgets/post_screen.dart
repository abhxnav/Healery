import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:healery/Providers/auth.dart';
import 'package:healery/main.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  String choice;
  bool isLoading = false;
  bool isAnon = false;
  List options = ["Yourself", "Anonymous"];
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 250,
                    child: TextField(
                      controller: title,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        hintText: 'Title text here..',
                        hintStyle: TextStyle(
                            color: Colors.grey.shade700,
                            fontFamily: 'Balsamiq'),
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
                  TextField(
                    maxLines: 5,
                    controller: content,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      hintText: 'What\'s on your mind today?',
                      hintStyle: TextStyle(
                          color: Colors.grey.shade700, fontFamily: 'Balsamiq'),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: 110,
                    padding: EdgeInsets.only(left: 12, right: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).backgroundColor, width: 1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: DropdownButton(
                      isExpanded: true,
                      underline: SizedBox(),
                      style: TextStyle(
                        fontFamily: 'Balsamiq',
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                      hint: Text("Post as",
                          style: TextStyle(color: Colors.grey.shade700)),
                      value: choice,
                      onChanged: (newValue) {
                        setState(() {
                          choice = newValue;
                        });
                      },
                      items: options.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 100),
                  Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Theme.of(context).accentColor,
                    ),
                    child: FlatButton(
                      child: Text(
                        'post',
                        style: TextStyle(
                          fontFamily: 'Balsamiq',
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        if (title.text.isEmpty || content.text.isEmpty) return;

                        setState(() {
                          isLoading = true;
                        });
                        String ID = md5
                            .convert(
                                utf8.encode(DateTime.now().toIso8601String()))
                            .toString();
                        await DB.collection('posts').doc(ID).set({
                          'ID': ID,
                          'userID': auth.userData["userID"],
                          'title': title.text,
                          'content': content.text,
                          'timestamp': DateTime.now().millisecondsSinceEpoch,
                          'isAnon': choice == 'Anonymous',
                          'likes': 0,
                          'comments': 0,
                          'liked': [],
                        });
                        setState(() {
                          isLoading = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
