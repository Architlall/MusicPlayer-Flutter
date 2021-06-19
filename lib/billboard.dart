import 'package:flutter/material.dart';

Widget billboardCard(String img, String title, String name) {
  return Container(
    margin: EdgeInsets.all(20),
    padding: EdgeInsets.fromLTRB(10, 30, 30, 30),
    height: 200,
    width: 200,
    decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover)),
    child: Padding(
      padding: const EdgeInsets.only(top: 85, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
          ),
          Text(
            name,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    ),
  );
}
