import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:healery/Providers/auth.dart';
import 'package:healery/Widgets/comment_item.dart';
import 'package:healery/main.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class CommentsScreen extends StatefulWidget {
  final post;
  final commentCount;

  const CommentsScreen({Key key, this.post, this.commentCount})
      : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  Future comment(String postID, String content) async {
    var batch = DB.batch();

    String commentID =
        md5.convert(utf8.encode(DateTime.now().toIso8601String())).toString();

    batch.set(
        DB
            .collection("posts")
            .doc(postID)
            .collection("comments")
            .doc(commentID),
        {
          "commentID": commentID,
          "commentContent": content,
          "userID": auth.user.uid,
          "postID": postID,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        });

    batch.update(DB.collection("posts").doc(postID), {
      "comments": FieldValue.increment(1),
    });

    await batch.commit();
  }

  TextEditingController controller = TextEditingController();
  PaginateRefreshedChangeListener refreshChangeListener =
      PaginateRefreshedChangeListener();
  var count = 0;

  @override
  Widget build(BuildContext context) {
    setState(() {
      refreshChangeListener.refreshed = true;
    });

    Future<void> submit() async {
      FocusScope.of(context).unfocus();

      if (controller.value.text.length > 0 &&
          controller.value.text.length < 500) {
        comment(widget.post['ID'], controller.value.text.trim())
            .then((value) => {
                  setState(() {
                    ++count;
                    refreshChangeListener.refreshed = true;
                  })
                });
      }

      controller.clear();
    }

    return Container(
      padding: EdgeInsets.fromLTRB(
          0, 0, 0, MediaQuery.of(context).viewInsets.bottom),
      child: Scaffold(
        body: FutureBuilder(
            future: DB
                .collection('posts')
                .doc(widget.post['ID'])
                .collection('comments')
                .get()
                .then((value) => value.docs),
            builder: (context, snapshot) {
              var commentCount = 0;

              if (snapshot.hasData) {
                for (var doc in snapshot.data) {
                  commentCount++;
                }
                count = commentCount;

                return count < 1
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              child: Text(
                                'Post the first comment!',
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: count == 1
                                  ? Text(
                                      count.toString() + ' comment',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      count.toString() + ' comments',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                            ),
                            Expanded(
                              child: Container(
                                child: PaginateFirestore(
                                    query: DB
                                        .collection('posts')
                                        .doc(widget.post['ID'])
                                        .collection('comments')
                                        .orderBy('timestamp', descending: true),
                                    itemsPerPage: 7,
                                    isLive: true,
                                    shrinkWrap: true,
                                    listeners: [
                                      refreshChangeListener,
                                    ],
                                    itemBuilderType:
                                        PaginateBuilderType.listView,
                                    itemBuilder: (int index,
                                        BuildContext context,
                                        DocumentSnapshot documentSnapshot) {
                                      var comment = documentSnapshot.data();
                                      return CommentItem(
                                        comment: comment,
                                        post: widget.post,
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ),
                      );
              } else {
                return Center(
                  child: Transform.scale(
                    scale: 0.6,
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }),
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: TextField(
            controller: controller,
            onSubmitted: (value) async {
              await submit();
            },
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: Icon(Icons.send_rounded),
                  onPressed: () async {
                    if (auth.isSignedIn) {
                      await submit();
                    } else {}
                  }),
              errorMaxLines: 1,
              errorStyle: TextStyle(
                color: Theme.of(context).disabledColor,
              ),
              fillColor: Theme.of(context).backgroundColor,
              focusColor: Theme.of(context).backgroundColor,
              filled: true,
              hintText: 'Post a comment',
            ),
          ),
        ),
      ),
    );
  }
}
