import 'package:flutter/material.dart';
import 'package:sermonindex/config/appsettings.dart';
import 'package:sermonindex/models/mdl_speaker.dart';
import 'package:sermonindex/widgets/sermonlistheader.dart';
import 'package:sermonindex/widgets/wdg_sermons.dart';

class Sermonlist extends StatefulWidget {
  final Speaker speaker;

  Sermonlist(this.speaker);

  @override
  _SermonlistState createState() => _SermonlistState(this.speaker);
}

class _SermonlistState extends State<Sermonlist> {
  final Speaker _speaker;

  _SermonlistState(this._speaker);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SermonlistHeader(speakername: _speaker.spkName).build(context),
      body: Container(
        color: AppSettings.SI_BGCOLOR,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: Sermons(
              speaker: _speaker,
            ))),
      ),
    );
  }
}
