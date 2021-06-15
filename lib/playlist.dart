import 'package:first_app/playlistplayer.dart';
import 'package:flutter_html/style.dart';
import 'package:http/http.dart';
import 'constants.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'testplayer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Playlist extends StatefulWidget {
  final String passedName;
  final String passedPreview;
  final String passedCover;
  final String passedTitle;
  final String documentId;
  const Playlist(
      {Key key,
      this.passedName,
      this.passedPreview,
      this.passedCover,
      this.passedTitle,
      this.documentId})
      : super(key: key);
  @override
  _PlaylistState createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(auth.currentUser.uid);

    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('My playlist'),
      ),
      body: Container(
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //       begin: Alignment.topLeft,
        //       end: Alignment.bottomRight,
        //       colors: [Colors.white70, Colors.blue]),
        // ),
        child: Column(children: [
          Container(
            padding: EdgeInsets.all(50),
            height: 350,
            width: 350,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(disk)),
            ),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://cdn.imgbin.com/2/5/12/imgbin-deezer-music-logo-playlist-deezer-zFGyeLgfh83Aga6AxUpkZfXaj.jpg'),
            ),
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
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      var Doc = snapshot.data.docs[index];
                      var DOCtoplayer = snapshot.data.docs;

                      return Card(
                        color: Colors.teal[900],
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
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              Doc['Name'],
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(Doc['Cover']),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.white),
                            onPressed: () {
                              snapshot.data.docs[index].reference.delete();
                            },
                          ),
                        ),
                      );
                      Divider(color: Colors.black);
                      SizedBox(
                        height: 10,
                      );
                    });
              }
            },
          ))
        ]),
      ),
    );
  }
}
