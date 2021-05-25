import 'package:flutter/material.dart';
import 'Model/listModel.dart';
import './main.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Farzi extends StatefulWidget {
  @override
  _FarziState createState() => _FarziState();
}

class _FarziState extends State<Farzi> {
  ListModel listModel = ListModel();

  void playsong() async {
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
    });

    String url = listModel.data[0].preview;
    print(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 40, top: 20),
              child: ElevatedButton(
                onPressed: playsong,
                child: Text("play"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
