import 'package:flutter/material.dart';

import './testplayer.dart';

class Hiphoplist extends StatefulWidget {
  final String passedSong;

  const Hiphoplist({Key key, this.passedSong}) : super(key: key);
  @override
  _HiphoplistState createState() => _HiphoplistState();
}

class _HiphoplistState extends State<Hiphoplist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 30,
      ),
      body: ListView(
        children: ListTile.divideTiles(
            //          <-- ListTile.divideTiles
            context: context,
            tiles: [
              GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AudioPlayerUrl(
                        passedPreview:
                            'https://cdns-preview-6.dzcdn.net/stream/c-673dc701e6cac674d6935923b6b663e4-6.mp3',
                        passedCover:
                            'https://api.deezer.com/album/127437082/image',
                        passedName: 'Jack Harlow',
                        passedPicture:
                            'https://api.deezer.com/artist/5313805/image',
                        passedTitle: 'WHATS POPPIN',
                      ),
                    ),
                  );
                },
                child: ListTile(
                  title: Text('1. WHATS POPPIN    -     Jack Harlow'),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AudioPlayerUrl(
                        passedPreview:
                            'https://cdns-preview-3.dzcdn.net/stream/c-394a045508902a29eaa7ffe17a699f37-3.mp3',
                        passedCover:
                            'https://api.deezer.com/album/205396982/image',
                        passedName: 'Cardi B',
                        passedPicture:
                            'https://api.deezer.com/artist/5313805/image',
                        passedTitle: 'Up',
                      ),
                    ),
                  );
                },
                child: ListTile(
                  title: Text('2. UP   -    Cardi B'),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AudioPlayerUrl(
                        passedPreview:
                            'https://cdns-preview-1.dzcdn.net/stream/c-1afe80e99f64107a65a730966f301ed1-6.mp3',
                        passedCover:
                            'https://api.deezer.com/album/142409332/image',
                        passedName: 'DaBaby',
                        passedPicture:
                            'https://api.deezer.com/artist/4050205/image',
                        passedTitle: 'ROCKSTAR',
                      ),
                    ),
                  );
                },
                child: ListTile(
                  title: Text('3. ROCKSTAR   -    DaBaby'),
                ),
              ),
            ]).toList(),
      ),
    );
  }
}
