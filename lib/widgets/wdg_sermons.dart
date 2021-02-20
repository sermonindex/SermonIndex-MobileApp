import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sermonindex/models/mdl_speaker.dart';
import 'package:sermonindex/models/mdl_speakerinfo.dart';
import 'package:sermonindex/pages/playerpage.dart';

class Sermons extends StatefulWidget {
  final Speaker speaker;

  Sermons({this.speaker});

  @override
  _SermonsState createState() => _SermonsState(this.speaker);
}

class _SermonsState extends State<Sermons> {
  final Speaker spk;

  _SermonsState(this.spk);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getSpeakerInfo(spk),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data.sermons.length);
            print(snapshot.data.sermons[0].title);
            return Expanded(
              child: ListView.builder(
                  itemCount: snapshot.data.sermons.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                          color: Colors.lime[900],
                          child: ListTile(
                            title: Text(
                              snapshot.data.sermons[index].title,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w400),
                            ),
                            trailing: Container(
                              child: IconButton(
                                icon: Icon(Icons.play_circle_fill, size: 30),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => PlayerPage(
                                              snapshot.data.sermons[index],
                                              snapshot.data.speakerName,
                                              snapshot.data.imageUrl)));
                                  // print(snapshot.data.speakerName);
                                  // print(snapshot.data.imageUrl);
                                },
 gh                              ),
                            ),
                          ),
                        ));
                  }),
            );
          } else {
            return Container(
              child: Center(
                child: Text(
                  "Loading Sermons..",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
                ),
              ),
            );
          }
        });
  }
}
