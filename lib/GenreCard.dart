import 'package:flutter/material.dart';

Widget genreCard(String img, String title) {
  return Container(
    margin: EdgeInsets.all(20),
    padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
    height: 200,
    width: 200,
    decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover)),
    child: Padding(
      padding: const EdgeInsets.only(top: 105),
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
      ),
    ),
  );
}
