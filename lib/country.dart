import 'package:flutter/material.dart';

import './testplayer.dart';

class Countrylist extends StatefulWidget {
  final String passedSong;

  const Countrylist({Key key, this.passedSong}) : super(key: key);
  @override
  _CountrylistState createState() => _CountrylistState();
}

class _CountrylistState extends State<Countrylist> {
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
                            'https://cdns-preview-e.dzcdn.net/stream/c-e61822859254c16c31b6e178c3a98834-4.mp3',
                        passedCover:
                            'https://api.deezer.com/album/164589572/image',
                        passedName: 'Tyler Rich',
                        passedPicture:
                            'https://api.deezer.com/artist/5313805/image',
                        passedTitle: 'Feels like Home',
                        passedCoverBig:
                            'https://cdns-images.dzcdn.net/images/cover/67fac386ed40827f3d5dc4363a114d3b/500x500-000000-80-0-0.jpg',
                      ),
                    ),
                  );
                },
                child: ListTile(
                  title: Text('1. Feels like Home   -    Tyler Rich'),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AudioPlayerUrl(
                        passedPreview:
                            'https://cdns-preview-9.dzcdn.net/stream/c-97fa832f7c4d1d3dfb941b08d86ce71c-10.mp3',
                        passedCover:
                            'https://api.deezer.com/album/86994512/image',
                        passedName: 'Florida Georgia Line',
                        passedPicture:
                            'https://api.deezer.com/artist/5313805/image',
                        passedTitle: 'Simple',
                        passedCoverBig:
                            'https://cdns-images.dzcdn.net/images/cover/dc076016ebcc167ba9591c68f5e36a97/500x500-000000-80-0-0.jpg',
                      ),
                    ),
                  );
                },
                child: ListTile(
                  title: Text('2. Simple   -    Florida Georgia Line'),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AudioPlayerUrl(
                        passedPreview:
                            'https://cdns-preview-a.dzcdn.net/stream/c-ad9b160b0a6eba64e59ca874fc41d41d-4.mp3',
                        passedCover:
                            'https://api.deezer.com/album/228464512/image',
                        passedName: 'Tim Mcgraw',
                        passedPicture:
                            'https://api.deezer.com/artist/4050205/image',
                        passedTitle: 'I called Mama',
                        passedCoverBig:
                            'https://cdns-images.dzcdn.net/images/cover/07d48b9242e549a1ad2a582e3f09754e/500x500-000000-80-0-0.jpg',
                      ),
                    ),
                  );
                },
                child: ListTile(
                  title: Text('3. I called Mama   -    Tim Mcgraw'),
                ),
              ),
            ]).toList(),
      ),
    );
  }
}
