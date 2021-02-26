import 'package:flutter/material.dart';
import 'package:sermonindex/pages/scripturepage.dart';
import 'package:sermonindex/pages/speakerspage.dart';
import 'package:sermonindex/pages/topicpage.dart';
import 'package:sermonindex/widgets/wdg_header.dart';
import 'package:sermonindex/models/mdl_modules.dart';
import 'package:sermonindex/widgets/wdg_moduleitem.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<SermonIndexModule> modules = sermonIndexModules();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppHeader,
      body: Container(
        color: Color.fromRGBO(124, 123, 60, 1.0),
        child: Column(
          children: [
            Header(
              title: " ",
              titleAlignment: Alignment.center,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        SIModule(
                          index: 0,
                          modules: modules,
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (_) => SpeakerPage()));
                          },
                        ),
                        SIModule(
                            index: 1,
                            modules: modules,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (_) => TopicPage()));
                            }),
                        SIModule(
                          index: 2,
                          modules: modules,
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (_) => ScripturePage()));
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
