import 'package:flutter/material.dart';
import './main.dart';
import 'Model/listModel.dart';
import './constants.dart';
import './testplayer.dart';

class Metallist extends StatefulWidget {
  final String passedSong;

  const Metallist({Key key, this.passedSong}) : super(key: key);
  @override
  _MetallistState createState() => _MetallistState();
}

class _MetallistState extends State<Metallist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
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
                            'https://cdns-preview-c.dzcdn.net/stream/c-c3b9551a5251328165b49d77d6597be4-5.mp3',
                        passedCover:
                            'https://api.deezer.com/album/15485488/image',
                        passedName: 'Black Sabbath',
                        passedPicture:
                            'https://api.deezer.com/artist/5313805/image',
                        passedTitle: 'War Pigs',
                      ),
                    ),
                  );
                },
                child: ListTile(
                  title: Text('1. War Pigs   -    Black Sabbath'),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AudioPlayerUrl(
                        passedPreview:
                            'https://cdns-preview-7.dzcdn.net/stream/c-7b10aab8626095cd79480ff2bf345ad5-5.mp3',
                        passedCover: 'https://api.deezer.com/album/80396/image',
                        passedName: 'Pantera',
                        passedPicture:
                            'https://api.deezer.com/artist/5313805/image',
                        passedTitle: 'Walk',
                      ),
                    ),
                  );
                },
                child: ListTile(
                  title: Text('2. Walk   -    Pantera'),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AudioPlayerUrl(
                        passedPreview:
                            'https://cdns-preview-c.dzcdn.net/stream/c-c571577cdf89471b39a8ce1973498576-5.mp3',
                        passedCover:
                            'https://api.deezer.com/album/303656/image',
                        passedName: 'The Iron Maidens',
                        passedPicture:
                            'https://api.deezer.com/artist/4050205/image',
                        passedTitle: 'Run to the Hills',
                      ),
                    ),
                  );
                },
                child: ListTile(
                  title: Text('3. Run to the Hills   -    The Iron Maidens'),
                ),
              ),
            ]).toList(),
      ),
    );
  }
}
