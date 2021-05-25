import 'package:first_app/Model/listModel.dart';
import 'package:first_app/audio_player_url.dart';
import 'package:first_app/farzi.dart';
import 'package:flutter/material.dart';
import './drawer.dart';
import './Trending.dart';
import './GenreCard.dart';
import './constants.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import './farzi.dart';

void main() {
  runApp(
    MaterialApp(
      routes: {
        '/': (context) => MyHomePage(),
        '/playing': (context) => AudioPlayerUrl()
      },
    ),
  );
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text('Welcome');

  ListModel listModel = ListModel();
  bool circular = true;

  void getData() async {
    http.Response response = await http.get(
        Uri.parse("https://deezerdevs-deezer.p.rapidapi.com/search?q=eminem"),
        headers: {
          "x-rapidapi-key":
              "21957ec02fmsh1a4397d220eb721p1c836cjsn1809d58d20f2",
          "x-rapidapi-host": "deezerdevs-deezer.p.rapidapi.com",
        });

    var data = json.decode(response.body);
    setState(() {
      listModel = ListModel.fromJson(data);
      circular = false;
    });
    print(listModel.data[0].title);
    print(listModel.data[0].preview);
    String url = listModel.data[0].preview;
  }

//   API Key: 65e3569778654a4bf5159ec1b5384870

// Shared Secret: 48402e02320940c68965e434307b834a
  // Future<String> getData() async {
  //   http.Response response = await http
  //       .get(Uri.parse("https://jsonplaceholder.typicode.com/posts"), headers: {
  //     "Accept": "application/json",
  //   });
  //   List data = jsonDecode(response.body);
  //   // print(data);
  //   print(data[0]["title"]);
  //   return (response.body);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime[50],
      appBar: AppBar(
          title: cusSearchBar,
          backgroundColor: Colors.grey[800],
          elevation: 30.0,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                setState(() {
                  if (this.cusIcon.icon == Icons.search) {
                    this.cusIcon = Icon(Icons.cancel);
                    this.cusSearchBar = TextField(
                      textInputAction: TextInputAction.go,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search for songs",
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    );
                  } else {
                    this.cusIcon = Icon(Icons.search);
                    this.cusSearchBar = Text('Welcome');
                  }
                });
              },
              icon: cusIcon,
            )
          ]),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ElevatedButton(
              onPressed: getData,
              child: Text("get data"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/playing');
              },
              child: Text("play"),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                'POPULAR',
                style: TextStyle(
                  letterSpacing: 3,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[800],
                ),
              ),
            ),
            ////Now we will create a Scroll views for different Genres
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  //Now we will call Genre card
                  genreCard(pop, "Pop"),
                  genreCard(hiphop, "HipHop"),
                  genreCard(
                    country,
                    "Country",
                  ),
                  genreCard(heavymetal, "Heavy Metal"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 20),
              child: Text(
                'TRENDING ALBUMS',
                style: TextStyle(
                    letterSpacing: 3,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[800]),
              ),
            ),
            //Container For Trending Songs
            Container(
              width: MediaQuery.of(context).size.width,
              height: 330,
              padding: EdgeInsets.fromLTRB(45, 30, 45, 25),
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(scard)),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: <Widget>[
                    songsCard(1, art1, "Blinding Lights", "The Weeknd"),
                    SizedBox(
                      height: 20,
                    ),
                    songsCard(2, art2, "The Box", "Roddy Rich"),
                    SizedBox(
                      height: 20,
                    ),
                    songsCard(3, art3, "Dont Start Now", "Dua Lipa"),
                    SizedBox(
                      height: 20,
                    ),
                    songsCard(4, art4, "Circles", "Post Malone"),
                    SizedBox(
                      height: 20,
                    ),
                    songsCard(5, art5, "Intentions", "Justin Bieber"),
                  ],
                ),
              ),
            ),

            //Navigation Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset(
                  home,
                  scale: 1.1,
                ),
                GestureDetector(
                  child: Image.asset(
                    list,
                    scale: 1.1,
                  ),
                  onTap: () {},
                ),
                Image.asset(
                  podcast,
                  scale: 1.1,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
