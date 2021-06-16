import 'package:first_app/Model/listModel.dart';
import 'package:first_app/country.dart';
import 'package:first_app/heavymetal.dart';
import 'package:first_app/hiphop.dart';
import 'package:first_app/myhomepage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/listview.dart';
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
import 'package:firebase_core/firebase_core.dart';
import 'home.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  runApp(App()
      // MaterialApp(

      //   routes: {
      //     '/': (context) => LoginScreen(),
      //     '/myhomepage': (context) => MyHomePage(),
      //     '/playing': (context) => AudioPlayerUrl(),
      //     '/listview': (context) => SongsWidget(),
      //     '/searchlist': (context) => SearchList(),
      //     '/poplist': (context) => Poplist(),
      //     '/hiphop': (context) => Hiphoplist(),
      //     '/country': (context) => Countrylist(),
      //     '/metal': (context) => Metallist()
      //   },
      // ),
      );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(accentColor: Colors.orange, primarySwatch: Colors.blue),
      home: LoginScreen(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   @override
//   MyHomePageState createState() => MyHomePageState();
// }

// class MyHomePageState extends State<MyHomePage> {
//   void playSong() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => AudioPlayerUrl(
//           passedPreview: listModel.data[0].preview,
//           passedCover: listModel.data[0].album.cover,
//           passedName: listModel.data[0].artist.name,
//           passedPicture: listModel.data[0].artist.picture,
//           passedTitle: listModel.data[0].title,
//         ),
//       ),
//     );
//   }

//   void listBuilder() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => SearchList(
//           passedLength: listModel.data.length,
//           passedName: listModel.data,
//           passedTitle: listModel.data,
//         ),
//       ),
//     );
//   }

//   var songname;

//   final songnamecon = new TextEditingController();

//   Icon cusIcon = Icon(Icons.search);
//   Widget cusSearchBar = Text('Welcome');

//   ListModel listModel = ListModel();
//   bool circular = true;

//   Future getData() async {
//     http.Response response = await http.get(
//         Uri.parse(
//             "https://deezerdevs-deezer.p.rapidapi.com/search?q=$songname"),
//         headers: {
//           "x-rapidapi-key":
//               "21957ec02fmsh1a4397d220eb721p1c836cjsn1809d58d20f2",
//           "x-rapidapi-host": "deezerdevs-deezer.p.rapidapi.com",
//         });
//     if (response.statusCode == 200) {
//       var data = json.decode(response.body);
//       setState(() {
//         listModel = ListModel.fromJson(data);
//         circular = false;
//       });
//     } else {
//       throw Exception("Failed to load songs!");
//     }
//     print(listModel.data.length);
//   }

//   // Future<List<Movie>> _fetchAllMovies() async {
//   //   final response = await http.get("http://www.omdbapi.com/?s=Batman&page=2&apikey=564727fa");

//   //   if(response.statusCode == 200) {
//   //     final result = jsonDecode(response.body);
//   //     Iterable list = result["Search"];
//   //     return list.map((movie) => Movie.fromJson(movie)).toList();
//   //   } else {
//   //     throw Exception("Failed to load movies!");
//   //   }

//   // }

// //   API Key: 65e3569778654a4bf5159ec1b5384870

// // Shared Secret: 48402e02320940c68965e434307b834a
//   // Future<String> getData() async {
//   //   http.Response response = await http
//   //       .get(Uri.parse("https://jsonplaceholder.typicode.com/posts"), headers: {
//   //     "Accept": "application/json",
//   //   });
//   //   List data = jsonDecode(response.body);
//   //   // print(data);
//   //   print(data[0]["title"]);
//   //   return (response.body);
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.lime[50],
//       appBar: AppBar(
//           title: cusSearchBar,
//           backgroundColor: Colors.grey[800],
//           elevation: 30.0,
//           actions: <Widget>[
//             // IconButton(
//             //   onPressed: () {
//             //     setState(() {
//             //       if (this.cusIcon.icon == Icons.search) {
//             //         this.cusIcon = Icon(Icons.cancel);
//             //         this.cusSearchBar = TextField(
//             //           textInputAction: TextInputAction.go,
//             //           decoration: InputDecoration(
//             //             border: InputBorder.none,
//             //             hintText: "Search for songs",
//             //           ),
//             //           style: TextStyle(
//             //             color: Colors.white,
//             //             fontSize: 16.0,
//             //           ),
//             //         );
//             //       } else {
//             //         this.cusIcon = Icon(Icons.search);
//             //         this.cusSearchBar = Text('Welcome');
//             //       }
//             //     });
//             //   },
//             //   icon: cusIcon,
//             // )

//             SizedBox(
//               height: 30,
//               width: 150,
//               child: TextField(
//                 controller: songnamecon,
//                 decoration: InputDecoration(hintText: 'Enter song or artist'),
//               ),
//             ),
//             SizedBox(
//               width: 20,
//             ),

//             IconButton(
//                 icon: Icon(Icons.search),
//                 onPressed: () async {
//                   songname = songnamecon.text;
//                   await getData();
//                   listBuilder();
//                 }),
//           ]),
//       drawer: MainDrawer(),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             SizedBox(
//               height: 40,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 20, bottom: 30),
//               child: Text(
//                 'POPULAR',
//                 style: TextStyle(
//                   letterSpacing: 3,
//                   fontSize: 20,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.grey[800],
//                 ),
//               ),
//             ),
//             ////Now we will create a Scroll views for different Genres
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: <Widget>[
//                   //Now we will call Genre card
//                   GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => Poplist(),
//                             ));
//                       },
//                       child: genreCard(pop, "Pop")),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => Hiphoplist(),
//                           ));
//                     },
//                     child: genreCard(hiphop, "HipHop"),
//                   ),

//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => Countrylist(),
//                           ));
//                     },
//                     child: genreCard(
//                       country,
//                       "Country",
//                     ),
//                   ),

//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => Metallist(),
//                           ));
//                     },
//                     child: genreCard(heavymetal, "Heavy Metal"),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 20, top: 60, bottom: 30),
//               child: Text(
//                 'TRENDING ALBUMS',
//                 style: TextStyle(
//                     letterSpacing: 3,
//                     fontSize: 20,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.grey[800]),
//               ),
//             ),
//             //Container For Trending Songs
//             // Container(
//             //   width: MediaQuery.of(context).size.width,
//             //   height: 330,
//             //   padding: EdgeInsets.fromLTRB(45, 30, 45, 25),
//             //   decoration: BoxDecoration(
//             //     image: DecorationImage(image: AssetImage(scard)),
//             //   ),
//             SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               child: Column(
//                 children: <Widget>[
//                   GestureDetector(
//                       onTap: () async {
//                         songname = "blinding lights";
//                         await getData();
//                         playSong();
//                       },
//                       child: Container(
//                           color: Colors.blue[50],
//                           width: 370,
//                           height: 130,
//                           margin: EdgeInsets.only(left: 10),
//                           padding: EdgeInsets.fromLTRB(35, 25, 45, 25),
//                           child: songsCard(
//                               1, art1, "Blinding Lights", "The Weeknd"))),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   GestureDetector(
//                     onTap: () async {
//                       songname = "the box";
//                       await getData();
//                       playSong();
//                     },
//                     child: Container(
//                         color: Colors.blue[50],
//                         width: 370,
//                         margin: EdgeInsets.only(left: 10),
//                         height: 130,
//                         padding: EdgeInsets.fromLTRB(30, 25, 45, 25),
//                         child: songsCard(2, art2, "The Box", "Roddy Rich")),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   GestureDetector(
//                     onTap: () async {
//                       songname = "dont start now";
//                       await getData();
//                       playSong();
//                     },
//                     child: Container(
//                         color: Colors.blue[50],
//                         width: 370,
//                         height: 130,
//                         margin: EdgeInsets.only(left: 10),
//                         padding: EdgeInsets.fromLTRB(30, 25, 45, 25),
//                         child:
//                             songsCard(3, art3, "Dont Start Now", "Dua Lipa")),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   GestureDetector(
//                     onTap: () async {
//                       songname = "circles";
//                       await getData();
//                       playSong();
//                     },
//                     child: Container(
//                         color: Colors.blue[50],
//                         width: 370,
//                         height: 130,
//                         margin: EdgeInsets.only(left: 10),
//                         padding: EdgeInsets.fromLTRB(30, 25, 45, 25),
//                         child: songsCard(4, art4, "Circles", "Post Malone")),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   GestureDetector(
//                     onTap: () async {
//                       songname = "Intentions";
//                       await getData();
//                       playSong();
//                     },
//                     child: Container(
//                         color: Colors.blue[50],
//                         width: 370,
//                         height: 130,
//                         margin: EdgeInsets.only(left: 10),
//                         padding: EdgeInsets.fromLTRB(30, 25, 45, 25),
//                         child:
//                             songsCard(5, art5, "Intentions", "Justin Bieber")),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                 ],
//               ),
//             ),

//             //Navigation Buttons
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 Image.asset(
//                   home,
//                   scale: 1.1,
//                 ),
//                 GestureDetector(
//                   child: Image.asset(
//                     list,
//                     scale: 1.1,
//                   ),
//                   onTap: () {},
//                 ),
//                 Image.asset(
//                   podcast,
//                   scale: 1.1,
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
