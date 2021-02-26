import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:SermonIndex/config/appsettings.dart';
import 'package:SermonIndex/models/mdl_scripture.dart';
import 'package:SermonIndex/pages/sermonlist.dart';
import 'package:SermonIndex/widgets/wdg_searchbox.dart';

class Scriptures extends StatefulWidget {
  @override
  _ScripturesState createState() => _ScripturesState();
}

class _ScripturesState extends State<Scriptures> {
  String strSearch;
  List allScriptures = [];
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
    filterScriptures();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchScriptures();
  }

  fetchScriptures() async {
    getScriptures().then((data) => {
          setState(() {
            allScriptures = data;
            filteredList = data;
            print('Scriptures data loaded ' + allScriptures.length.toString());
          })
        });
  }

  filterScriptures() {
    print('Applying filter');
    List temp = [];
    if (strSearch == "") {
      temp = List.from(allScriptures);
    } else {
      allScriptures.forEach((scripture) {
        if (scripture.reference
            .toLowerCase()
            .contains(strSearch.toString().toLowerCase())) {
          temp.add(scripture);
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
          hintText: "Search Scripture",
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
                                            scripture: filteredList[index],
                                            speaker: null,
                                          )));
                            },
                            leading: FaIcon(
                              AppSettings.bibleIcon,
                              size: 32,
                            ),
                            title: Text(
                              filteredList[index].reference,
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
                      "Loading Scriptures",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    )),
                  ))
      ],
    );
  }
}
