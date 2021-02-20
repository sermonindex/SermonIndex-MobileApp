import 'package:flutter/material.dart';
import 'package:sermonindex/widgets/wdg_header.dart';
// import 'package:sermonindex/widgets/wdg_appheader.dart';
// import 'package:sermonindex/widgets/wdg_appheader.dart';
// import 'package:sermonindex/widgets/wdg_header.dart';
import 'package:sermonindex/widgets/wdg_speakers.dart';

class SpeakerPage extends StatefulWidget {
  @override
  SpeakerPageState createState() => SpeakerPageState();
}

class SpeakerPageState extends State<SpeakerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppHeader,
      body: Container(
        color: Color.fromRGBO(124, 123, 60, 1.0),
        child: Column(
          children: [
            Header(),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(
                  top: 0.0, left: 8.0, right: 8.0, bottom: 8.0),
              child: Speakers(),
            ))
          ],
        ),
      ),
    );
  }
}
