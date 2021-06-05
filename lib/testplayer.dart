import 'package:audioplayers/audioplayers.dart';
import 'package:first_app/playlist.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './constants.dart';
import 'home.dart';

class AudioPlayerUrl extends StatefulWidget {
  final String uid;
  final String passedPreview;
  final String passedCover;
  final String passedName;
  final String passedTitle;
  final String passedPicture;
  AudioPlayerUrl(
      {Key key,
      this.uid,
      this.passedPreview,
      this.passedCover,
      this.passedName,
      this.passedPicture,
      this.passedTitle})
      : super(key: key);

  @override
  _AudioPlayerUrlState createState() => _AudioPlayerUrlState();
}

class _AudioPlayerUrlState extends State<AudioPlayerUrl> {
  FirebaseAuth auth = FirebaseAuth.instance;

  // final User user = await auth.currentUser();
  //   final uid = user.uid;

  /// For clarity, I added the terms compulsory and optional to certain sections
  /// to maintain clarity as to what is really needed for a functioning audio player
  /// and what is added for further interaction.
  ///
  /// 'Compulsory': A functioning audio player with:
  ///             - Play/Pause button
  ///
  /// 'Optional': A functioning audio player with:
  ///             - Play/Pause button
  ///             - time stamps for progress and duration
  ///             - slider to jump within the audio file
  ///

  /// Compulsory
  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayerState audioPlayerState = AudioPlayerState.PAUSED;

  /// Optional
  int timeProgress = 0;
  int audioDuration = 0;

  /// Optional
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
    audioPlayer.setUrl(widget
        .passedPreview); // Triggers the onDurationChanged listener and sets the max duration string
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
    await audioPlayer.play(widget.passedPreview);
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

  /// Optional
  String getTimeString(int seconds) {
    String minuteString =
        '${(seconds / 60).floor() < 10 ? 0 : ''}${(seconds / 60).floor()}';
    String secondString = '${seconds % 60 < 10 ? 0 : ''}${seconds % 60}';
    return '$minuteString:$secondString'; // Returns a string with the format mm:ss
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[150],
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),

            //Now we will create Navigation Buttons
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

            //Now we will create Album Art Disk
            Container(
              padding: EdgeInsets.all(50),
              height: 350,
              width: 350,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(disk)),
              ),
              child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.passedCover),
                  child: CircleAvatar(
                    backgroundColor: cwhite,
                    radius: 25,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            // Now we will create Song Title and Artist name Texts
            Text(
              widget.passedTitle,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.passedName,
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

            /// Compulsory
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
        ));
  }
}
