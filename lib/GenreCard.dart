import 'package:flutter/material.dart';

Widget genreCard(String img, String title) {
  return Container(
    padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage('assets/images/gcard.png')),
    ),
    child: Column(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: AssetImage(img),
          radius: 50,
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    ),
  );
}
