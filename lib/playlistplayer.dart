import 'package:audioplayers/audioplayers.dart';
import 'package:first_app/playlist.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './constants.dart';
import 'home.dart';

class PlaylistPlayer extends StatefulWidget {
  final String uid;
  var passedPreview;
  var passedCover;
  var passedName;
  var passedTitle;
  var passedPicture;
  PlaylistPlayer(
      {Key key,
      this.uid,
      this.passedPreview,
      this.passedCover,
      this.passedName,
      this.passedPicture,
      this.passedTitle})
      : super(key: key);

  @override
  _PlaylistPlayerState createState() => _PlaylistPlayerState();
}

class _PlaylistPlayerState extends State<PlaylistPlayer> {
  FirebaseAuth auth = FirebaseAuth.instance;

  // final User user = await auth.currentUser();
  //   final uid = user.uid;

  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayerState audioPlayerState = AudioPlayerState.PAUSED;

  int timeProgress = 0;
  int audioDuration = 0;
  bool isRepeat = false;

  Widget slider() {
    return Container(
      width: 300.0,
      child: Slider.adaptive(
          value: timeProgress.toDouble(),
          max: audioDuration.toDouble(),
          onChanged: (value) {
            seekToSec(value.toInt());
          }),
    );
  }

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  void passtoplaylist() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(auth.currentUser.uid);

    await collectionReference.add({
      'Name': widget.passedTitle,
      'Cover': widget.passedCover,
      'ArtistName': widget.passedName,
      'Preview': widget.passedPreview
    });
    final snackBar = SnackBar(content: Text('Song added to Playlist'));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();

    /// Compulsory
    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState state) {
      setState(() {
        audioPlayerState = state;
      });
    });

    /// Optional
    audioPlayer.setUrl(widget.passedPreview[0]);
    audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        audioDuration = duration.inSeconds;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((Duration position) async {
      setState(() {
        timeProgress = position.inSeconds;
      });
    });
  }

  /// Compulsory
  @override
  void dispose() {
    audioPlayer.release();
    audioPlayer.dispose();
    super.dispose();
  }

  /// Compulsory
  playMusic() async {
    // Add the parameter "isLocal: true" if you want to access a local file
    await audioPlayer.play(widget.passedPreview[0]);
  }

  /// Compulsory
  pauseMusic() async {
    await audioPlayer.pause();
  }

  /// Optional
  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    audioPlayer
        .seek(newPos); // Jumps to the given position within the audio file
  }

  String getTimeString(int seconds) {
    String minuteString =
        '${(seconds / 60).floor() < 10 ? 0 : ''}${(seconds / 60).floor()}';
    String secondString = '${seconds % 60 < 10 ? 0 : ''}${seconds % 60}';
    return '$minuteString:$secondString'; // Returns a string with the format mm:ss
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white70, Colors.blue]),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),

            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  child: cbutton(back),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Spacer(),
                Text(
                  'NOW PLAYING',
                  style: TextStyle(
                      color: cblue, fontSize: 17, fontWeight: FontWeight.w300),
                ),
                Spacer(),
                // cbutton(options),
                PopupMenuButton<int>(
                    color: Colors.blue[100],
                    onSelected: (item) => passtoplaylist(),
                    itemBuilder: (context) => [
                          PopupMenuItem<int>(
                              value: 0, child: Text('Add to playlist'))
                        ]),
                SizedBox(
                  width: 20,
                ),
              ],
            ),

            Container(
              padding: EdgeInsets.all(50),
              height: 350,
              width: 350,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(disk)),
              ),
              child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.passedCover[0]),
                  child: CircleAvatar(
                    backgroundColor: cwhite,
                    radius: 25,
                  )),
            ),
            SizedBox(
              height: 10,
            ),

            Text(
              widget.passedTitle[0],
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.passedName[0],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 20,
            ),

            SizedBox(
              height: 20,
            ),

            SizedBox(
              height: 10,
            ),

            IconButton(
                iconSize: 50,
                onPressed: () {
                  audioPlayerState == AudioPlayerState.PLAYING
                      ? pauseMusic()
                      : playMusic();
                },
                icon: Icon(audioPlayerState == AudioPlayerState.PLAYING
                    ? Icons.pause_rounded
                    : Icons.play_arrow_rounded)),

            SizedBox(
              width: 20,
            ),

            IconButton(
                iconSize: 30,
                onPressed: () {
                  if (isRepeat == false) {
                    audioPlayer.setReleaseMode(ReleaseMode.LOOP);
                    setState(() {
                      isRepeat = true;
                    });
                  }
                },
                icon: Icon(
                  Icons.loop,
                  color: Colors.black87,
                )),

            /// Optional
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(getTimeString(timeProgress)),
                SizedBox(width: 20),
                Container(width: 200, child: slider()),
                SizedBox(width: 20),
                Text(getTimeString(audioDuration))
              ],
            )
          ],
        ),
      ),
    );
  }
}
