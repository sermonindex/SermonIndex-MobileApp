import 'package:flutter/material.dart';
import 'package:sermonindex/models/mdl_speaker.dart';
import 'package:sermonindex/pages/sermons.dart';
import 'package:sermonindex/utils/utils.dart';

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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.black38,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searhTextController,
                    maxLines: 1,
                    cursorHeight: 28,
                    cursorColor: Colors.white60,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white60,
                    ),
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white60,
                        ),
                        fillColor: Colors.white10,
                        focusColor: Colors.black12,
                        hintText: "Search speaker",
                        hintStyle: TextStyle(color: Colors.white60),
                        focusedBorder: InputBorder.none),
                  ),
                ),
              ],
            ),
          ),
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
                                      builder: (context) =>
                                          Sermonlist(filteredList[index])));
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

  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder(
  //       future: getSpeakers(),
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           print(snapshot.data[0].spkName);
  //           return ListView.builder(
  //               shrinkWrap: true,
  //               itemCount: snapshot.data.length,
  //               itemBuilder: (context, index) {
  //                 // if (snapshot.data[index].spkName
  //                 //     .toString()
  //                 //     .contains(strSearch)) {
  //                 return Padding(
  //                   padding: const EdgeInsets.all(0.5),
  //                   child: Card(
  //                     // shadowColor: Colors.black,
  //                     color: Color.fromRGBO(124, 123, 60, 1.0),
  //                     child: ListTile(
  //                       onTap: () {
  //                         Navigator.push(
  //                             context,
  //                             new MaterialPageRoute(
  //                                 builder: (context) =>
  //                                     Sermonlist(snapshot.data[index])));
  //                       },
  //                       leading: Icon(
  //                         Icons.record_voice_over,
  //                         size: 50.0,
  //                       ),
  //                       title: Text(
  //                         Commons.formattedName(snapshot.data[index].spkName),
  //                         style: TextStyle(
  //                             fontSize: 20.0,
  //                             fontWeight: FontWeight.w600,
  //                             color: Colors.black54),
  //                       ),
  //                       // subtitle: Text('Here is a second line'),
  //                       trailing: Icon(Icons.more_vert),
  //                     ),
  //                   ),
  //                 );
  //                 // }
  //               });
  //         } else {
  //           return Container(
  //             child: Center(
  //               child: Text("Loading Speakers.."),
  //             ),
  //           );
  //         }
  //       });
  // }
}
