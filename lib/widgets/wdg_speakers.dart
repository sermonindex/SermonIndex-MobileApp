import 'package:flutter/material.dart';
import 'package:sermonindex/models/mdl_speaker.dart';
import 'package:sermonindex/pages/sermonlist.dart';
import 'package:sermonindex/utils/utils.dart';
import 'package:sermonindex/widgets/wdg_searchbox.dart';

class Speakers extends StatefulWidget {
  @override
  _SpeakersState createState() => _SpeakersState();
}

class _SpeakersState extends State<Speakers> {
  String strSearch;
  List allSpeakers = [];
  List filteredList = [];
  TextEditingController _searhTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searhTextController.addListener(_onSearchTextChange);
  }

  _onSearchTextChange() {
    print(_searhTextController.text);

    setState(() {
      strSearch = _searhTextController.text;
    });
    filterSpeakers();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchSpeakers();
  }

  fetchSpeakers() async {
    getSpeakers().then((data) => {
          setState(() {
            allSpeakers = data;
            filteredList = data;
            print('Speakers data loaded ' + allSpeakers.length.toString());
          })
        });
  }

  filterSpeakers() {
    print('Applying filter');
    List temp = [];
    if (strSearch == "") {
      temp = List.from(allSpeakers);
    } else {
      allSpeakers.forEach((speaker) {
        if (speaker.spkName
            .toLowerCase()
            .contains(strSearch.toString().toLowerCase())) {
          temp.add(speaker);
        }
      });
    }
    setState(() {
      filteredList = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBox(
          searchController: _searhTextController,
          hintText: "Search Speaker",
          padding: EdgeInsets.symmetric(horizontal: 20),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
            child: (filteredList.isNotEmpty)
                ? ListView.builder(
                    // padding: EdgeInsets.only(top: 20),
                    shrinkWrap: true,
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
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
                                      builder: (context) => Sermonlist(
                                            speaker: filteredList[index],
                                            scripture: null,
                                          )));
                            },
                            leading: Icon(
                              Icons.record_voice_over,
                              size: 50.0,
                            ),
                            title: Text(
                              Commons.formattedName(
                                  filteredList[index].spkName),
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
                    })
                : Container(
                    child: Center(
                        child: Text(
                      "Loading Speakers",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    )),
                  ))
      ],
    );
  }
}
