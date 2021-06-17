import 'package:audioplayers/audioplayers.dart';
import 'package:first_app/playlist.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './constants.dart';
import 'home.dart';
import 'playlistplayer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AudioPlayerUrl extends StatefulWidget {
  final String uid;
  final String passedPreview;
  final String passedCover;
  final String passedName;
  final String passedTitle;
  final String passedPicture;
  final String passedCoverBig;
  AudioPlayerUrl(
      {Key key,
      this.uid,
      this.passedPreview,
      this.passedCover,
      this.passedName,
      this.passedPicture,
      this.passedTitle,
      this.passedCoverBig})
      : super(key: key);

  @override
  _AudioPlayerUrlState createState() => _AudioPlayerUrlState();
}

class _AudioPlayerUrlState extends State<AudioPlayerUrl> {
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
      'Preview': widget.passedPreview,
      'Cover_big': widget.passedCoverBig
    });
    final snackBar = SnackBar(content: Text('Song added to Playlist'));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // onComplete() {
  //   print(count);
  //   FirebaseFirestore.instance
  //       .collection(auth.currentUser.uid)
  //       .get()
  //       .then((querySnapshot) {
  //     var doc = querySnapshot.docs.elementAt(count);

  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (_) => AudioPlayerUrl(
  //           passedPreview: doc['Preview'],
  //           passedCover: doc['Cover'],
  //           passedName: doc['ArtistName'],
  //           passedTitle: doc['Name'],
  //         ),
  //       ),
  //     );
  //   });
  // }

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
    audioPlayer.setUrl(widget.passedPreview);
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
    //   audioPlayer.onPlayerCompletion.listen((event) async {
    //     print('hi');

    //     setState(() {
    //       count++;
    //     });

    //     onComplete();
    //   });
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
          image: DecorationImage(
            image: NetworkImage(widget.passedCoverBig),
            fit: BoxFit.cover,
          ),
          // gradient: LinearGradient(
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight,
          //     colors: [Colors.white70, Colors.blue]),
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
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                Spacer(),
                // cbutton(options),
                PopupMenuButton<int>(
                    elevation: 50,
                    color: Colors.white,
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
            // Container(
            //   padding: EdgeInsets.all(50),
            //   height: 350,
            //   width: 350,
            //   decoration: BoxDecoration(
            //     image: DecorationImage(image: AssetImage(disk)),
            //   ),
            //   child: CircleAvatar(
            //       backgroundImage: NetworkImage(widget.passedCover),
            //       child: CircleAvatar(
            //         backgroundColor: cwhite,
            //         radius: 25,
            //       )),
            // ),
            // SizedBox(
            //   height: 10,
            // ),

            // Container(
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: NetworkImage(widget.passedCover),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 300,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.passedTitle,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.passedName,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(
                  width: 95,
                ),
                IconButton(
                  iconSize: 40,
                  onPressed: () {
                    audioPlayer.setPlaybackRate(playbackRate: 0.7);
                  },
                  icon: Icon(Icons.fast_rewind_rounded),
                  color: Colors.white,
                  splashColor: Colors.blue,
                ),
                SizedBox(width: 5),
                IconButton(
                  iconSize: 60,
                  onPressed: () {
                    audioPlayerState == AudioPlayerState.PLAYING
                        ? pauseMusic()
                        : playMusic();
                  },
                  icon: audioPlayerState == AudioPlayerState.PLAYING
                      ? FaIcon(
                          FontAwesomeIcons.solidPauseCircle,
                          color: Colors.blue[300],
                        )
                      : FaIcon(
                          FontAwesomeIcons.solidPlayCircle,
                          color: Colors.blue[300],
                        ),
                  color: Colors.white,
                ),
                IconButton(
                  iconSize: 40,
                  onPressed: () {
                    audioPlayer.setPlaybackRate(playbackRate: 1.3);
                  },
                  icon: Icon(Icons.fast_forward_rounded),
                  color: Colors.white,
                ),
                SizedBox(
                  width: 35,
                ),
                IconButton(
                    iconSize: 25,
                    onPressed: () {
                      if (isRepeat == false) {
                        audioPlayer.setReleaseMode(ReleaseMode.LOOP);
                        setState(() {
                          isRepeat = true;
                        });
                      } else if (isRepeat == true) {
                        audioPlayer.setReleaseMode(ReleaseMode.RELEASE);
                        setState(() {
                          isRepeat = false;
                        });
                      }
                    },
                    icon: isRepeat == false
                        ? Icon(
                            Icons.loop,
                            color: Colors.white,
                          )
                        : Icon(
                            Icons.loop,
                            color: Colors.red[900],
                          )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 20),
                Container(width: 340, child: slider()),
                SizedBox(width: 20),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  getTimeString(timeProgress),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 290,
                ),
                Text(
                  getTimeString(audioDuration),
                  style: TextStyle(color: Colors.white),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
