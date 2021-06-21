import 'package:flutter/material.dart';

import 'testplayer.dart';

class SearchList extends StatefulWidget {
  final int passedLength;

  final List passedName;
  final List passedTitle;

  const SearchList(
      {Key key, this.passedLength, this.passedName, this.passedTitle})
      : super(key: key);
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 30,
      ),
      body: ListView.separated(
        itemCount: widget.passedLength,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AudioPlayerUrl(
                    passedPreview: widget.passedName[index].preview,
                    passedCover: widget.passedName[index].album.cover,
                    passedName: widget.passedName[index].artist.name,
                    passedPicture: widget.passedName[index].artist.picture,
                    passedTitle: widget.passedName[index].title,
                    passedCoverBig: widget.passedName[index].album.cover_big,
                  ),
                ),
              );
            },
            child: Card(
              color: Colors.grey[900],
              child: ListTile(
                title: new Text(
                  (index + 1).toString() +
                      '.   ' +
                      widget.passedName[index].title +
                      '   -   ' +
                      widget.passedName[index].artist.name,
                  style: TextStyle(color: Colors.white),
                ),
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage(widget.passedName[index].album.cover),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(color: Colors.grey[900]);
        },
      ),
    );
  }
}
