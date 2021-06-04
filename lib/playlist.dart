import 'main.dart';
import 'package:flutter/material.dart';
import 'testplayer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Playlist extends StatefulWidget {
  final String passedTitle;

  const Playlist({Key key, this.passedTitle}) : super(key: key);
  @override
  _PlaylistState createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('playlist');

    return Scaffold(
      appBar: AppBar(
        title: Text('My playlist'),
      ),
      body: Column(children: [
        Expanded(
            child: StreamBuilder(
          // stream: collectionReference.snapshots(),
          stream: FirebaseFirestore.instance
              .collection(auth.currentUser.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data.docs
                    .map((e) => Column(
                          children: [
                            ListTile(
                              title: Text(e['Name']),
                            ),
                            Divider(
                              color: Colors.black.withOpacity(0.6),
                              thickness: 2,
                            )
                          ],
                        ))
                    .toList(),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ))
      ]),
    );
  }
}
