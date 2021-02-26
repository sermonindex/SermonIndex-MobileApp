import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:SermonIndex/config/appsettings.dart';
import 'package:SermonIndex/models/mdl_scripture.dart';
import 'package:SermonIndex/models/mdl_speaker.dart';
import 'package:SermonIndex/models/mdl_speakerinfo.dart';
import 'package:SermonIndex/models/mdl_topic.dart';
import 'package:SermonIndex/pages/playerpage.dart';
import 'package:SermonIndex/widgets/wdg_searchbox.dart';

class Sermons extends StatefulWidget {
  final Speaker speaker;
  final Scripture scripture;
  final Topic topic;

  Sermons({this.speaker, this.scripture, this.topic});

  @override
  _SermonsState createState() =>
      _SermonsState(this.speaker, this.scripture, this.topic);
}

class _SermonsState extends State<Sermons> {
  final Speaker _speaker;
  final Scripture _scripture;
  final Topic _topic;

  String _speakerType;

  String strSearch;
  List allSermons = [];
  List filteredSermons = [];
  String speakerName;
  String speakerImageUrl;
  String speakerBio;
  TextEditingController _searhController = new TextEditingController();

  _SermonsState(this._speaker, this._scripture, this._topic);

  @override
  void initState() {
    super.initState();
    _searhController.addListener(_onSearchTextChange);
  }

  _onSearchTextChange() {
    print(_searhController.text);

    setState(() {
      strSearch = _searhController.text;
    });
    filterList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_speaker != null) {
      fetchSermonsForSpeaker();
    }
    if (_scripture != null) {
      fetchSermonsForScripture();
    }
    if (_topic != null) {
      fetchSermonsForTopic();
    }
  }

  fetchSermonsForScripture() {
    getScriptureInfo(_scripture).then((data) => {
          setState(() {
            _speakerType = "Scripture";
            allSermons = data;
            filteredSermons = data;
            print(
                'Sermons for Scripture loaded ' + allSermons.length.toString());
          })
        });
  }

  fetchSermonsForTopic() {
    getTopicInfo(_topic).then((data) => {
          setState(() {
            _speakerType = "Topic";
            allSermons = data;
            filteredSermons = data;
            print(
                'Sermons for Scripture loaded ' + allSermons.length.toString());
          })
        });
  }

  fetchSermonsForSpeaker() async {
    getSpeakerInfo(_speaker).then((data) => {
          setState(() {
            _speakerType = "Speaker";
            speakerName = data.speakerName;
            speakerImageUrl = data.imageUrl;
            speakerBio = data.description;
            allSermons = data.sermons;
            filteredSermons = data.sermons;
            print('Sermons for Speaker loaded ' + allSermons.length.toString());
          })
        });
  }

  filterList() {
    print('Applying filter');
    List temp = [];
    if (strSearch == "") {
      temp = List.from(allSermons);
    } else {
      allSermons.forEach((sermon) {
        if (sermon.title
            .toLowerCase()
            .contains(strSearch.toString().toLowerCase())) {
          temp.add(sermon);
        }
      });
    }
    setState(() {
      filteredSermons = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBox(
          searchController: _searhController,
          hintText: "Search Sermons",
          padding: EdgeInsets.symmetric(horizontal: 5),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: (filteredSermons.isNotEmpty)
              ? ListView.builder(
                  itemCount: filteredSermons.length,
                  itemBuilder: (context, index) {
                    print("Speaker type : " + _speakerType);
                    // print(filteredSermons[index].toString());
                    // if (_speakerType != "Speaker") {
                    //   setState(() {
                    //     speakerName = filteredSermons[index].speakerName;
                    //     speakerImageUrl = filteredSermons[index].imageUrl;
                    //   });
                    // }
                    return Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Card(
                          color: AppSettings.SI_BGCOLOR.withAlpha(180),
                          child: ListTile(
                            title: Text(
                              filteredSermons[index].title,
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
                                                filteredSermons[index],
                                                (_speakerType) == "Speaker"
                                                    ? speakerName
                                                    : filteredSermons[index]
                                                        .speakerName,
                                                (_speakerType) == "Speaker"
                                                    ? speakerImageUrl
                                                    : filteredSermons[index]
                                                        .imageUrl,
                                              )));
                                  // print(snapshot.data.speakerName);
                                  // print(snapshot.data.imageUrl);
                                },
                              ),
                            ),
                          ),
                        ));
                  })
              : Container(
                  child: Center(
                    child: Text(
                      "Loading Sermons..",
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
