import 'package:flutter/material.dart';
import 'package:healery/Providers/auth.dart';
import 'package:healery/main.dart';
import 'package:intl/intl.dart';

class CommentItem extends StatefulWidget {
  final comment;
  final post;

  const CommentItem({Key key, this.comment, this.post}) : super(key: key);
  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  var commentator;
  bool isLoaded = false;
  bool isUser = false;

  load() async {
    commentator = await DB
        .collection('/users')
        .doc(widget.comment['userID'])
        .get()
        .then((value) => value.data());

    isLoaded = true;
  }

  @override
  void initState() {
    if (auth.isSignedIn) {
      isUser = widget.comment['userID'] == auth.user.uid;
    }
    load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? ListTile(
            key: Key(widget.comment['commentID']),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        commentator['name'],
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                ),
                if (isUser) Spacer(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    DateFormat.yMMMd()
                        .format(DateTime.fromMillisecondsSinceEpoch(
                            widget.comment['timestamp'] +
                                DateTime.now().timeZoneOffset.inMilliseconds))
                        .toString(),
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
            subtitle: Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.comment['commentContent'],
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            ),
            leading: GestureDetector(
              onTap: () async {
                if (!auth.isSignedIn ||
                    commentator['userID'] != auth.user.uid) {
                } else {}
              },
              child: Container(
                width: 35,
                height: 35,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    image: DecorationImage(
                      image: NetworkImage(
                        commentator['profilePic'],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          )
        : Container();
  }
}
