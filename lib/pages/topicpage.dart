import 'package:flutter/material.dart';
import 'package:sermonindex/models/mdl_topic.dart';
import 'package:sermonindex/widgets/wdg_floatingactionbutton.dart';
import 'package:sermonindex/widgets/wdg_header.dart';
import 'package:sermonindex/widgets/wdg_topics.dart';

class TopicPage extends StatefulWidget {
  final Topic topic;

  const TopicPage({Key key, this.topic}) : super(key: key);

  @override
  TopicPageState createState() => TopicPageState();
}

class TopicPageState extends State<TopicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(124, 123, 60, 1.0),
        child: Column(
          children: [
            Header(
              title: "Topics",
              titleAlignment: Alignment.centerRight,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, left: 8.0, right: 8.0, bottom: 10.0),
              child: Topics(),
            ))
          ],
        ),
      ),
      floatingActionButton: HomeButton(),
    );
  }
}
