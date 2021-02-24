import 'package:flutter/material.dart';
import 'package:sermonindex/models/mdl_speaker.dart';
import 'package:sermonindex/pages/sermons.dart';
import 'package:sermonindex/utils/utils.dart';

class Speakers extends StatefulWidget {
  final searchString;

  const Speakers({Key key, this.searchString}) : super(key: key);

  @override
  _SpeakersState createState() => _SpeakersState(searchString);
}

class _SpeakersState extends State<Speakers> {
  final searchString;
  String strSearch;

  _SpeakersState(this.searchString);

  @override
  void initState() {
    strSearch = "A";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getSpeakers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data[0].spkName);
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  // if (snapshot.data[index].spkName
                  //     .toString()
                  //     .contains(strSearch)) {
                  return Padding(
                    padding: const EdgeInsets.all(0.5),
                    child: Card(
                      // shadowColor: Colors.black,
                      color: Color.fromRGBO(124, 123, 60, 1.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      Sermonlist(snapshot.data[index])));
                        },
                        leading: Icon(
                          Icons.record_voice_over,
                          size: 50.0,
                        ),
                        title: Text(
                          Commons.formattedName(snapshot.data[index].spkName),
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54),
                        ),
                        // subtitle: Text('Here is a second line'),
                        trailing: Icon(Icons.more_vert),
                      ),
                    ),
                  );
                  // }
                });
          } else {
            return Container(
              child: Center(
                child: Text("Loading Speakers.."),
              ),
            );
          }
        });
  }
}
