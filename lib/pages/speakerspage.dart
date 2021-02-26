import 'package:flutter/material.dart';
import 'package:SermonIndex/widgets/wdg_floatingactionbutton.dart';
import 'package:SermonIndex/widgets/wdg_header.dart';
import 'package:SermonIndex/widgets/wdg_speakers.dart';

class SpeakerPage extends StatefulWidget {
  @override
  SpeakerPageState createState() => SpeakerPageState();
}

class SpeakerPageState extends State<SpeakerPage> {
  String searchText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(124, 123, 60, 1.0),
        child: Column(
          children: [
            Header(),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, left: 8.0, right: 8.0, bottom: 10.0),
              child: Speakers(),
            ))
          ],
        ),
      ),
      floatingActionButton: HomeButton(),
    );
  }
}
