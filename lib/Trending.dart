import 'package:flutter/material.dart';

Widget songsCard(int sr, String img, String title, String artist) {
  return Column(
    children: <Widget>[
      SizedBox(
        height: 10,
      ),
      Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "$sr",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 20,
            ),
            CircleAvatar(
              backgroundImage: AssetImage(img),
              radius: 30,
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  artist,
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 13,
                      color: Colors.white),
                ),
                SizedBox(width: 100)
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
