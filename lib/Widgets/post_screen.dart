import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  String choice;
  List options = ["Yourself", "Anonymous"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        leading: IconButton(
          icon:
              Icon(Icons.close_outlined, color: Theme.of(context).accentColor),
          onPressed: () {},
        ),
        actions: [
          RaisedButton(
            //TODO change colour to accent colour
            color: Theme.of(context).accentColor,
            child: Text(
              'post',
              style: TextStyle(
                fontFamily: 'Balsamiq',
                color: Colors.white,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            onPressed: null,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            //TODO shift this container to extreme left
            //TODO change input to paragraph form
            width: 250,
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                hintText: 'Title text here..',
                hintStyle: TextStyle(
                    color: Colors.grey.shade700, fontFamily: 'Balsamiq'),
              ),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              hintText: 'What\'s on your mind today?',
              hintStyle: TextStyle(
                  color: Colors.grey.shade700, fontFamily: 'Balsamiq'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              width: 110,
              padding: EdgeInsets.only(left: 12, right: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).backgroundColor, width: 1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: DropdownButton(
                //TODO shift this to extreme left
                isExpanded: true,
                underline: SizedBox(),
                style: TextStyle(
                  fontFamily: 'Balsamiq',
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
                hint: Text("Post as", style: TextStyle(color: Colors.grey.shade700)),
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
          ),
        ],
      ),
    );
  }
}
