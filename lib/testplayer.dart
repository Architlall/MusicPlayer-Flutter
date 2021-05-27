import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import './main.dart';
import './constants.dart';

class AudioPlayerUrl extends StatefulWidget {
  final String passedPreview;
  final String passedCover;
  final String passedName;
  final String passedTitle;
  final String passedPicture;
  const AudioPlayerUrl(
      {Key key,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              },
            ),
            Spacer(),
            Text(
              'NOW PLAYING',
              style: TextStyle(
                  color: cblue, fontSize: 17, fontWeight: FontWeight.w300),
            ),
            Spacer(),
            cbutton(options),
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
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          widget.passedName,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
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
