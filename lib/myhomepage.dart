import 'package:first_app/Model/listModel.dart';
import 'package:first_app/country.dart';
import 'package:first_app/heavymetal.dart';
import 'package:first_app/hiphop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/testplayer.dart';
import 'package:flutter/material.dart';
import './drawer.dart';
import './Trending.dart';
import './GenreCard.dart';
import './constants.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'searchlist.dart';
import 'poplist.dart';
import './testplayer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'playlist.dart';
import 'home.dart';

class MyHomePage extends StatefulWidget {
  final String uid;
  MyHomePage({
    Key key,
    this.uid,
  }) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  void playSong() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AudioPlayerUrl(
            passedPreview: listModel.data[0].preview,
            passedCover: listModel.data[0].album.cover,
            passedName: listModel.data[0].artist.name,
            passedPicture: listModel.data[0].artist.picture,
            passedTitle: listModel.data[0].title,
            passedCoverBig: listModel.data[0].album.cover_big),
      ),
    );
  }

  void listBuilder() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SearchList(
          passedLength: listModel.data.length,
          passedName: listModel.data,
          passedTitle: listModel.data,
        ),
      ),
    );
  }

  var songname;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final songnamecon = new TextEditingController();

  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text('Welcome');

  ListModel listModel = ListModel();
  bool circular = true;

  Future getData() async {
    http.Response response = await http.get(
        Uri.parse(
            "https://deezerdevs-deezer.p.rapidapi.com/search?q=$songname"),
        headers: {
          "x-rapidapi-key": dotenv.env['x-rapidapi-key'],
          "x-rapidapi-host": dotenv.env['x-rapidapi-host']
        });
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        listModel = ListModel.fromJson(data);
        circular = false;
      });
    } else {
      throw Exception("Failed to load songs!");
    }
    print(listModel.data.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
          backgroundColor: Colors.black87,
          elevation: 30.0,
          actions: <Widget>[
            // IconButton(
            //   onPressed: () {
            //     setState(() {
            //       if (this.cusIcon.icon == Icons.search) {
            //         this.cusIcon = Icon(Icons.cancel);
            //         this.cusSearchBar = TextField(
            //           textInputAction: TextInputAction.go,
            //           decoration: InputDecoration(
            //             border: InputBorder.none,
            //             hintText: "Search for songs",
            //           ),
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 16.0,
            //           ),
            //         );
            //       } else {
            //         this.cusIcon = Icon(Icons.search);
            //         this.cusSearchBar = Text('Welcome');
            //       }
            //     });
            //   },
            //   icon: cusIcon,
            // )

            SizedBox(
              height: 30,
              width: 150,
              child: TextField(
                controller: songnamecon,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: 'Enter song or artist',
                    hintStyle: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(
              width: 20,
            ),

            IconButton(
                icon: Icon(Icons.search),
                onPressed: () async {
                  songname = songnamecon.text;
                  await getData();
                  listBuilder();
                }),

            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://www.clipartmax.com/png/middle/171-1717870_stockvader-predicted-cron-for-may-user-profile-icon-png.png'),
            )
          ]),
      drawer: MainDrawer(),
      body: (SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                'DISCOVER',
                style: TextStyle(
                  letterSpacing: 3,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Poplist(),
                            ));
                      },
                      child: genreCard(pop, "Pop")),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Hiphoplist(),
                          ));
                    },
                    child: genreCard(hiphop, "HipHop"),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Countrylist(),
                          ));
                    },
                    child: genreCard(
                      country,
                      "Country",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Metallist(),
                          ));
                    },
                    child: genreCard(heavymetal, "Heavy Metal"),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 60),
              child: Text(
                'BILLBOARD TRENDING',
                style: TextStyle(
                    letterSpacing: 3,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: 30,
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                      onTap: () async {
                        songname = "Butter";
                        await getData();
                        playSong();
                      },
                      child: genreCard(butter, "Butter")),
                  GestureDetector(
                    onTap: () async {
                      songname = "Good 4 U";
                      await getData();
                      playSong();
                    },
                    child: genreCard(good, "Good 4 U"),
                  ),
                  GestureDetector(
                    onTap: () async {
                      songname = "Levitating";
                      await getData();
                      playSong();
                    },
                    child: genreCard(
                      levitating,
                      "Levitating",
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      songname = "Peaches";
                      await getData();
                      playSong();
                    },
                    child: genreCard(peaches, "Peaches"),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 30, top: 60),
              child: Text(
                'TRENDING SONGS',
                style: TextStyle(
                    letterSpacing: 3,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            //Container For Trending Songs
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                      onTap: () async {
                        songname = "blinding lights";
                        await getData();
                        playSong();
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                            color: Colors.grey[900],
                            width: 370,
                            height: 120,
                            margin: EdgeInsets.only(left: 10),
                            padding: EdgeInsets.fromLTRB(35, 20, 45, 20),
                            child: songsCard(
                                1, art1, "Blinding Lights", "The Weeknd")),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      songname = "the box";
                      await getData();
                      playSong();
                    },
                    child: Container(
                        color: Colors.grey[900],
                        width: 370,
                        margin: EdgeInsets.only(left: 10),
                        height: 120,
                        padding: EdgeInsets.fromLTRB(30, 20, 45, 20),
                        child: songsCard(2, art2, "The Box", "Roddy Rich")),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      songname = "dont start now";
                      await getData();
                      playSong();
                    },
                    child: Container(
                        color: Colors.grey[900],
                        width: 370,
                        height: 120,
                        margin: EdgeInsets.only(left: 10),
                        padding: EdgeInsets.fromLTRB(30, 20, 45, 20),
                        child:
                            songsCard(3, art3, "Dont Start Now", "Dua Lipa")),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      songname = "circles";
                      await getData();
                      playSong();
                    },
                    child: Container(
                        color: Colors.grey[900],
                        width: 370,
                        height: 120,
                        margin: EdgeInsets.only(left: 10),
                        padding: EdgeInsets.fromLTRB(30, 20, 45, 20),
                        child: songsCard(4, art4, "Circles", "Post Malone")),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      songname = "Intentions";
                      await getData();
                      playSong();
                    },
                    child: Container(
                        color: Colors.grey[900],
                        width: 370,
                        height: 120,
                        margin: EdgeInsets.only(left: 10),
                        padding: EdgeInsets.fromLTRB(30, 20, 45, 20),
                        child:
                            songsCard(5, art5, "Intentions", "Justin Bieber")),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
      // bottomNavigationBar: (Padding(
      //   padding: EdgeInsets.all(8.0),
      //   child: Container(
      //     color: Colors.grey[900],
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       children: <Widget>[
      //         IconButton(
      //             icon: (Icon(
      //               Icons.home,
      //               color: Colors.white,
      //               size: 30,
      //             )),
      //             onPressed: null,
      //             splashColor: Colors.blue),
      //         IconButton(
      //           icon: (Icon(
      //             Icons.featured_play_list,
      //             color: Colors.white,
      //           )),
      //           onPressed: () {
      //             Navigator.of(context).push(
      //                 MaterialPageRoute(builder: (context) => Playlist()));
      //           },
      //           splashColor: Colors.blue,
      //         ),
      //         IconButton(
      //           icon: (Icon(
      //             Icons.logout,
      //             color: Colors.white,
      //           )),
      //           onPressed: () {
      //             auth.signOut();
      //             Navigator.of(context).pushReplacement(
      //                 MaterialPageRoute(builder: (context) => LoginScreen()));
      //           },
      //           splashColor: Colors.blue,
      //         ),
      // ],
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   children: <Widget>[
      //     Image.asset(
      //       home,
      //       scale: 1.1,
      //     ),
      //     GestureDetector(
      //       child: Image.asset(
      //         list,
      //         scale: 1.1,
      //       ),
      //       onTap: () {
      //         Navigator.of(context)
      //             .push(MaterialPageRoute(builder: (context) => Playlist()));
      //       },
      //     ),
      //     Image.asset(
      //       podcast,
      //       scale: 1.1,
      //     ),
      //   ],
      //       // ),
      //     ),
      //   ),
      // )),
    );
  }
}
