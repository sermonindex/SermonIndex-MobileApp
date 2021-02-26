import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:SermonIndex/config/appsettings.dart';
import 'package:SermonIndex/models/mdl_topic.dart';
import 'package:SermonIndex/pages/sermonlist.dart';
import 'package:SermonIndex/widgets/wdg_searchbox.dart';

class Topics extends StatefulWidget {
  @override
  _TopicsState createState() => _TopicsState();
}

class _TopicsState extends State<Topics> {
  String strSearch;
  List allTopics = [];
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
    filterTopics();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchTopics();
  }

  fetchTopics() async {
    getTopics().then((data) => {
          setState(() {
            allTopics = data;
            filteredList = data;
            print('Topics data loaded ' + allTopics.length.toString());
          })
        });
  }

  filterTopics() {
    print('Applying filter');
    List temp = [];
    if (strSearch == "") {
      temp = List.from(allTopics);
    } else {
      allTopics.forEach((topic) {
        if (topic.topic
            .toLowerCase()
            .contains(strSearch.toString().toLowerCase())) {
          temp.add(topic);
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
          hintText: "Search Topic",
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
                                            topic: filteredList[index],
                                            speaker: null,
                                            scripture: null,
                                          )));
                            },
                            leading: FaIcon(
                              AppSettings.topicIcon,
                              size: 32,
                            ),
                            title: Text(
                              filteredList[index].topic,
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
                      "Loading Topics",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    )),
                  ))
      ],
    );
  }
}
