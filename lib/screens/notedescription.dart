import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoteDescription extends StatefulWidget {
  String bookId;
  String title;
  String detail;
  String publishedDate;
  String publishedTime;
  NoteDescription({
    Key? key,
    required this.bookId,
    required this.title,
    required this.detail,
    required this.publishedDate,
    required this.publishedTime,
  }) : super(key: key);

  @override
  State<NoteDescription> createState() => _NoteDescriptionState();
}

class _NoteDescriptionState extends State<NoteDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(widget.title,
            style: TextStyle(color: Colors.black, fontSize: 25.0)),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 25.0, 30.0, 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.detail,
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            Divider(color: Colors.black, height: 3.0),
            SizedBox(height: 10.0),
            Text("${widget.publishedTime} | ${widget.publishedTime}"),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
