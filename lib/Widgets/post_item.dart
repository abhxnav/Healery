import 'package:flutter/material.dart';
import 'package:healery/Screens/comment_screen.dart';
import 'package:healery/main.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PostItem extends StatelessWidget {
  final data;

  const PostItem({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: FutureBuilder(
          future: DB.collection('users').doc(data.data()['userID']).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10),
                      CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage(
                          snapshot.data['profilePic'],
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        snapshot.data['name'],
                        style: TextStyle(
                            fontFamily: 'Balsamiq',
                            fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      Text(
                          DateFormat.yMMMd()
                              .format(DateTime.fromMillisecondsSinceEpoch(data
                                      .data()['timestamp'] +
                                  DateTime.now().timeZoneOffset.inMilliseconds))
                              .toString(),
                          style: TextStyle(color: Colors.grey)),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      data.data()['title'],
                      style: TextStyle(
                          fontFamily: 'Balsamiq',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      data.data()['content'],
                      style: TextStyle(
                          fontFamily: 'Balsamiq',
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Icon(Icons.favorite_rounded, color: Colors.red),
                      SizedBox(width: 5),
                      Text(
                        data.data()['likes'].toString(),
                        style: TextStyle(
                            fontFamily: 'Balsamiq',
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 30),
                      IconButton(
                        icon: Icon(Icons.message_rounded),
                        onPressed: () async {
                          showBarModalBottomSheet(
                            context: context,
                            elevation: 10,
                            builder: (context) => CommentsScreen(
                              post: data.data(),
                              commentCount: data.data()["comments"],
                            ),
                            isDismissible: true,
                            expand: true,
                            enableDrag: true,
                            bounce: true,
                            animationCurve: Curves.easeOut,
                            duration: Duration(milliseconds: 300),
                          );
                        },
                      ),
                      SizedBox(width: 5),
                      Text(
                        data.data()['comments'].toString(),
                        style: TextStyle(
                            fontFamily: 'Balsamiq',
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(),
                ],
              );
            } else {
              return Container(
                height: 20,
                color: Theme.of(context).backgroundColor,
              );
            }
          }),
    );
  }
}
