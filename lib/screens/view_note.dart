import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewNoteScreen extends StatefulWidget {
  final Map data;
  final String time;
  final DocumentReference ref;

  ViewNoteScreen(
    this.data,
    this.time,
    this.ref,
  );
  @override
  _ViewNoteScreenState createState() => _ViewNoteScreenState();
}

class _ViewNoteScreenState extends State<ViewNoteScreen> {
  // var title;
  // var description;

  void delete() async {
    await widget.ref.delete();

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff070706),
          actions: [
            TextButton(
              onPressed: delete,
              child: Text(
                'D  E  L  E  T  E   ',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red[300],
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.data['title']}',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.time,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.amber,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      '${widget.data['description']}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
