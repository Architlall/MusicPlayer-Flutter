import 'package:flutter/material.dart';
import './constants.dart';
import './main.dart';
import 'package:wave_progress_bars/wave_progress_bars.dart';

class NowPlaying extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cwhite,
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
                backgroundImage: AssetImage(albumart),
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
            "You Need To Calm Down",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Taylor Swift",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 20,
          ),

          //Now we will create Music Controller Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //The buttons are called passing its above symbol
              cbutton(previous),
              cbutton(play),
              cbutton(next),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          //Now we will create Wave song progress bar
          Center(
            child: WaveProgressBar(
              progressPercentage: 30,
              width: 350,
              initalColor: cblue.withAlpha(10),
              progressColor: cblue,
              backgroundColor: cwhite,
              timeInMilliSeconds: 30,
              isHorizontallyAnimated: false,
              isVerticallyAnimated: false,
            ),
          ),
          SizedBox(
            height: 10,
          ),

          // Now we will create Song TimeStamp
          RichText(
            text: TextSpan(
                style: TextStyle(
                    color: cblue.withAlpha(100), fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                      text: '0:54',
                      style:
                          TextStyle(color: cblue, fontWeight: FontWeight.bold)),
                  TextSpan(text: ' | '),
                  TextSpan(text: '03:15')
                ]),
          ),
        ],
      ),
    );
  }
}
