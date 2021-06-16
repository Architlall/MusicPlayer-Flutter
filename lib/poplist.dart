import 'package:flutter/material.dart';

import './testplayer.dart';

class Poplist extends StatefulWidget {
  final String passedSong;

  const Poplist({Key key, this.passedSong}) : super(key: key);
  @override
  _PoplistState createState() => _PoplistState();
}

class _PoplistState extends State<Poplist> {
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
                            'https://cdns-preview-1.dzcdn.net/stream/c-1dad0ee9a3cc34130171fea60b07cdd7-7.mp3',
                        passedCover:
                            'https://api.deezer.com/album/122664252/image',
                        passedName: 'Harry Styles',
                        passedPicture:
                            'https://api.deezer.com/artist/5313805/image',
                        passedTitle: 'Watermelon Sugar',
                        passedCoverBig:
                            'https://cdns-images.dzcdn.net/images/cover/346c524c15ecccbc4a8a78e8972a352c/500x500-000000-80-0-0.jpg',
                      ),
                    ),
                  );
                },
                child: ListTile(
                  title: Text('1. Watermelon Sugar    -     Harry Styles'),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AudioPlayerUrl(
                        passedPreview:
                            'https://cdns-preview-5.dzcdn.net/stream/c-58c2f2bd81ee0d60e70310831737a910-6.mp3',
                        passedCover:
                            'https://api.deezer.com/album/100856872/image',
                        passedName: 'Camila Cabello and Shawn Mendes',
                        passedPicture:
                            'https://api.deezer.com/artist/5313805/image',
                        passedTitle: 'Señorita',
                        passedCoverBig:
                            'https://cdns-images.dzcdn.net/images/cover/4426e8a06d8d0cd96263094c6178bbf9/500x500-000000-80-0-0.jpg',
                      ),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(
                      '2. Senorita   -    Shawn Mendes and Camila Cabello'),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AudioPlayerUrl(
                        passedPreview:
                            'https://cdns-preview-3.dzcdn.net/stream/c-31bb797f043b544baa792ccf827e5cd8-8.mp3',
                        passedCover:
                            'https://api.deezer.com/album/137217782/image',
                        passedName: 'The Weeknd',
                        passedPicture:
                            'https://api.deezer.com/artist/4050205/image',
                        passedTitle: 'Save Your Tears',
                        passedCoverBig:
                            'https://cdns-images.dzcdn.net/images/cover/fd00ebd6d30d7253f813dba3bb1c66a9/500x500-000000-80-0-0.jpg',
                      ),
                    ),
                  );
                },
                child: ListTile(
                  title: Text('3. Save Your Tears    -     The Weeknd'),
                ),
              ),
            ]).toList(),
      ),
    );
  }
}
