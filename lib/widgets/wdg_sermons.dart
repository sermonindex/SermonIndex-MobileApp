import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sermonindex/config/appsettings.dart';
import 'package:sermonindex/models/mdl_speaker.dart';
import 'package:sermonindex/models/mdl_speakerinfo.dart';
import 'package:sermonindex/pages/playerpage.dart';
import 'package:sermonindex/widgets/wdg_searchbox.dart';

class Sermons extends StatefulWidget {
  final Speaker speaker;

  Sermons({this.speaker});

  @override
  _SermonsState createState() => _SermonsState(this.speaker);
}

class _SermonsState extends State<Sermons> {
  final Speaker spk;
  String strSearch;
  List allSermons = [];
  List filteredSermons = [];
  String speakerName;
  String speakerImageUrl;
  TextEditingController _searhController = new TextEditingController();

  _SermonsState(this.spk);

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
    filterSpeakers();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchSermons();
  }

  fetchSermons() async {
    getSpeakerInfo(spk).then((data) => {
          setState(() {
            speakerName = data.speakerName;
            speakerImageUrl = data.imageUrl;
            allSermons = data.sermons;
            filteredSermons = data.sermons;
            print('Speakers data loaded ' + allSermons.length.toString());
          })
        });
  }

  filterSpeakers() {
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
                                              speakerName,
                                              speakerImageUrl)));
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
