import 'package:flutter/material.dart';

import 'package:first_app/Model/model.dart';

class SongsWidget extends StatelessWidget {
  final List<Model> songs;

  SongsWidget({this.songs});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          final song = songs[index];

          return ListTile(
              title: Row(
            children: [
              SizedBox(
                  width: 100,
                  child: ClipRRect(
                    child: Image.network(song.album.cover),
                    borderRadius: BorderRadius.circular(10),
                  )),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(song.album.title), Text(song.artist.name)],
                  ),
                ),
              )
            ],
          ));
        });
  }
}
