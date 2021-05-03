import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healery/Providers/auth.dart';
import 'package:healery/Screens/comment_screen.dart';
import 'package:healery/main.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PostItem extends StatefulWidget {
  final data;

  const PostItem({Key key, this.data}) : super(key: key);

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  bool isLiked;
  String likes;

  @override
  Widget build(BuildContext context) {
    Future load() async {
      isLiked = await DB
          .collection('posts')
          .doc(widget.data.data()['ID'])
          .get()
          .then((value) {
        likes = value["likes"].toString();
        return value["liked"].contains(auth.user.uid);
      });
      return await DB
          .collection('users')
          .doc(widget.data.data()['userID'])
          .get();
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: FutureBuilder(
          future: load(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10),
                      widget.data.data()['isAnon']
                          ? Icon(Icons.help)
                          : CircleAvatar(
                              radius: 22,
                              backgroundImage: NetworkImage(
                                snapshot.data['profilePic'],
                              ),
                            ),
                      SizedBox(width: 10),
                      Text(
                        widget.data.data()['isAnon']
                            ? 'Anonymous'
                            : snapshot.data['name'],
                        style: TextStyle(
                            fontFamily: 'Balsamiq',
                            fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      Text(
                          DateFormat.yMMMd()
                              .format(DateTime.fromMillisecondsSinceEpoch(widget
                                      .data
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
                      widget.data.data()['title'],
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
                      widget.data.data()['content'],
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
                      IconButton(
                        icon: Icon(Icons.favorite_rounded,
                            color: isLiked ? Colors.red : Colors.grey),
                        onPressed: () async {
                          DB
                              .collection('posts')
                              .doc(widget.data.data()['ID'])
                              .update({
                            'liked': !isLiked
                                ? FieldValue.arrayUnion([auth.user.uid])
                                : FieldValue.arrayRemove([auth.user.uid]),
                            'likes': !isLiked
                                ? FieldValue.increment(1)
                                : FieldValue.increment(-1),
                          });

                          setState(() {
                            isLiked = !isLiked;
                          });
                        },
                      ),
                      SizedBox(width: 5),
                      Text(
                        likes,
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
                              post: widget.data.data(),
                              commentCount: widget.data.data()["comments"],
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
                        widget.data.data()['comments'].toString(),
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
                height: 200,
                color: Theme.of(context).backgroundColor,
              );
            }
          }),
    );
  }
}
