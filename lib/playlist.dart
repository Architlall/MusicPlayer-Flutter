import 'package:first_app/playlistplayer.dart';

import 'constants.dart';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Playlist extends StatefulWidget {
  final String passedName;
  final String passedPreview;
  final String passedCover;
  final String passedTitle;
  final String documentId;
  final String passedCoverBig;
  const Playlist(
      {Key key,
      this.passedName,
      this.passedPreview,
      this.passedCover,
      this.passedTitle,
      this.documentId,
      this.passedCoverBig})
      : super(key: key);
  @override
  _PlaylistState createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  int count;
  int index = 0;
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(auth.currentUser.uid);

    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('           My playlist'),
      ),
      body: Container(
        child: Column(children: [
          Container(
            padding: EdgeInsets.all(50),
            height: 350,
            width: 350,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(disk)),
            ),
            child: CircleAvatar(backgroundImage: AssetImage(leave)),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(color: Colors.black),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: StreamBuilder(
                  // stream: collectionReference.snapshots(),
                  stream: collectionReference.snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            var Doc = snapshot.data.docs[index];

                            return Card(
                              color: Colors.grey[900],
                              child: ListTile(
                                title: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => Playlistplay(
                                          passedPreview: Doc['Preview'],
                                          passedCover: Doc['Cover'],
                                          passedName: Doc['ArtistName'],
                                          passedTitle: Doc['Name'],
                                          passedCoverBig: Doc['Cover_big'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    Doc['Name'] + "   -   " + Doc['ArtistName'],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(Doc['Cover']),
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.white),
                                  onPressed: () {
                                    snapshot.data.docs[index].reference
                                        .delete();
                                  },
                                ),
                              ),
                            );
                          });
                    }
                  }))
        ]),
      ),
    );
  }
}
