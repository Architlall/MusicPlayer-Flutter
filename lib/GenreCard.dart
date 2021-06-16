import 'package:flutter/material.dart';

Widget genreCard(String img, String title) {
  // return Container(
  //   padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
  //   decoration: BoxDecoration(
  //     image: DecorationImage(
  //       image: AssetImage('assets/images/gcard.png'),
  //     ),
  //   ),
  //   child: Column(
  //     children: <Widget>[
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

  //       SizedBox(
  //         height: 15,
  //       ),
  //       Text(
  //         title,
  //         style: TextStyle(
  //             fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
  //       ),
  //       SizedBox(
  //         height: 5,
  //       ),
  //     ],
  //   ),
  // );
}
