import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notes_app/screens/add_note.dart';
import 'package:firebase_notes_app/screens/auth_screen.dart';
import 'package:firebase_notes_app/screens/view_note.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

List<Color?> myColor = [
  Colors.pink[200],
  Colors.red[200],
  Colors.green[200],
  Colors.deepPurple[200],
];

class _HomeScreenState extends State<HomeScreen> {
  final Query ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('R  E  M  A  R  Q  U  E  S'),
        backgroundColor: Color(0xff070706),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              final FirebaseAuth auth = FirebaseAuth.instance;
              await auth.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => AuthScreen(),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => AddNoteScreen(),
            ),
          )
              .then((value) {
            setState(() {});
          });
        },
        backgroundColor: Colors.amber[700],
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: FutureBuilder<QuerySnapshot>(
          future: ref.get(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (ctx, i) {
                  Random random = Random();
                  Color? bg = myColor[random.nextInt(4)];
                  Map data = snapshot.data.docs[i].data();
                  DateTime myDt = data['created'].toDate();
                  String formatedTime =
                      DateFormat.yMMMEd().add_jm().format(myDt);
                  return InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                          builder: (context) => ViewNoteScreen(
                            data,
                            formatedTime,
                            snapshot.data.docs[i].reference,
                          ),
                        ),
                      )
                          .then((value) {
                        setState(() {});
                      });
                    },
                    child: Card(
                      color: bg,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${data['title']}',
                              style: TextStyle(
                                fontSize: 32,
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                formatedTime,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text(
                  '+ Add Notes',
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
