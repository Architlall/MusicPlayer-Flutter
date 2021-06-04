import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/testplayer.dart';
import 'package:flutter/material.dart';

import 'main.dart';
import './myhomepage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: 'Email'),
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(hintText: 'Password'),
              onChanged: (value) {
                setState(() {
                  _password = value.trim();
                });
              },
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            ElevatedButton(
                child: Text('Signin'),
                onPressed: () {
                  auth
                      .signInWithEmailAndPassword(
                          email: _email, password: _password)
                      .then((_) {
                    final uid = auth.currentUser.uid;

                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  });
                }),
            ElevatedButton(
              child: Text('Signup'),
              onPressed: () {
                auth
                    .createUserWithEmailAndPassword(
                        email: _email, password: _password)
                    .then((_) {
                  final uid = auth.currentUser.uid;
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => MyHomePage()));
                });
              },
            )
          ])
        ],
      ),
    );
  }
}
