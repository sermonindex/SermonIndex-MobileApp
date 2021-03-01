import 'package:SermonIndex/widgets/wdg_speakerbio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:SermonIndex/config/appsettings.dart';
import 'package:SermonIndex/models/mdl_scripture.dart';
import 'package:SermonIndex/models/mdl_speaker.dart';
import 'package:SermonIndex/models/mdl_speakerinfo.dart';
import 'package:SermonIndex/models/mdl_topic.dart';
import 'package:SermonIndex/pages/playerpage.dart';
import 'package:SermonIndex/widgets/wdg_searchbox.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Sermons extends StatefulWidget {
  final Speaker speaker;
  final Scripture scripture;
  final Topic topic;
  final String pageTitle;

  Sermons({this.speaker, this.scripture, this.topic, this.pageTitle});

  @override
  _SermonsState createState() =>
      _SermonsState(this.speaker, this.scripture, this.topic, this.pageTitle);
}

class _SermonsState extends State<Sermons> {
  final Speaker _speaker;
  final Scripture _scripture;
  final Topic _topic;
  final String _pageTitle;

  String _speakerType;

  String strSearch;
  List allSermons = [];
  List filteredSermons = [];
  String speakerName;
  String speakerImageUrl;
  String speakerBio;
  bool showBio = false;
  TextEditingController _searhController = new TextEditingController();

  _SermonsState(this._speaker, this._scripture, this._topic, this._pageTitle);

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
            showBio = false;
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
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: Text(
            _pageTitle,
            style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w600,
                color: Colors.black54),
          ),
          centerTitle: true,
          backgroundColor: AppSettings.SI_BGCOLOR),
      body: Container(
        color: AppSettings.SI_BGCOLOR,
        child: Column(
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
                      itemCount: filteredSermons.length + 1,
                      itemBuilder: (context, index) {
                        print("Speaker type : " + _speakerType);
                        return (index == 0)
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: SpeakerBio(
                                  bio: speakerBio,
                                  imageUrl: speakerImageUrl,
                                  speakerName: speakerName,
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Card(
                                  color: AppSettings.SI_BGCOLOR.withAlpha(180),
                                  child: ListTile(
                                    title: Text(
                                      filteredSermons[index - 1].title,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    trailing: Container(
                                      child: IconButton(
                                        icon: Icon(Icons.play_circle_fill,
                                            size: 30),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (context) =>
                                                      PlayerPage(
                                                        filteredSermons[
                                                            index - 1],
                                                        (_speakerType) ==
                                                                "Speaker"
                                                            ? speakerName
                                                            : filteredSermons[
                                                                    index]
                                                                .speakerName,
                                                        (_speakerType) ==
                                                                "Speaker"
                                                            ? speakerImageUrl
                                                            : filteredSermons[
                                                                    index - 1]
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
        ),
      ),
    );
  }
}
