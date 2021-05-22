import 'package:flutter/material.dart';
import './drawer.dart';
import './Trending.dart';
import './GenreCard.dart';
import './constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppBar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text('Welcome');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
                fontWeight: FontWeight.w300,
                color: Colors.grey,
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
                  fontWeight: FontWeight.w300,
                  color: cblue),
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
              Image.asset(
                search,
                scale: 1.1,
              ),
            ],
          )
        ],
      ),
    );
  }
}
