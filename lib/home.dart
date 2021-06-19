import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

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
          backgroundColor: Colors.black,
          title: Text('Login to Archify xD'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "https://i.pinimg.com/564x/57/df/d8/57dfd894d87565e71813c75397f4d55b.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 262,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 8, 8, 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.blue)),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      hintText: 'Enter your Email',
                      hintStyle: TextStyle(color: Colors.white)),
                  onChanged: (value) {
                    setState(() {
                      _email = value.trim();
                    });
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 8, 8, 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.blue)),
                child: TextField(
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      hintText: 'Enter your Password',
                      hintStyle: TextStyle(color: Colors.white)),
                  onChanged: (value) {
                    setState(() {
                      _password = value.trim();
                    });
                  },
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    child: Text('Log In'),
                    onPressed: () async {
                      try {
                        await auth
                            .signInWithEmailAndPassword(
                                email: _email, password: _password)
                            .then((_) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()));
                        });
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          final snackBar = SnackBar(
                              content: Text('User not found, please sign up!'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    }),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    child: Text('Sign Up'),
                    onPressed: () async {
                      try {
                        await auth
                            .createUserWithEmailAndPassword(
                                email: _email, password: _password)
                            .then((_) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()));
                        });
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'email-already-in-use') {
                          final snackBar = SnackBar(
                              content: Text(
                                  'This user account already exists,please sign in!'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      } catch (e) {
                        print(e);
                      }
                    }),
              ])
            ],
          ),
        ));
  }
}
