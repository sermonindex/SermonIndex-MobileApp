import 'package:flutter/material.dart';
import 'package:sermonindex/config/appsettings.dart';
import 'package:sermonindex/models/mdl_scripture.dart';
import 'package:sermonindex/models/mdl_speaker.dart';
import 'package:sermonindex/widgets/sermonlistheader.dart';
import 'package:sermonindex/widgets/wdg_floatingactionbutton.dart';
import 'package:sermonindex/widgets/wdg_sermons.dart';

class Sermonlist extends StatefulWidget {
  final Speaker speaker;
  final Scripture scripture;

  Sermonlist({this.speaker, this.scripture});

  @override
  _SermonlistState createState() =>
      _SermonlistState(this.speaker, this.scripture);
}

class _SermonlistState extends State<Sermonlist> {
  final Speaker _speaker;
  final Scripture _scripture;
  String _speakerName;

  _SermonlistState(this._speaker, this._scripture);

  @override
  void initState() {
    super.initState();
    if (_speaker != null) {
      _speakerName = _speaker.spkName;
      print('Speaker is not null');
    }
    if (_scripture != null) {
      _speakerName = _scripture.reference;
      print('Scripture is not null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SermonlistHeader(speakername: _speakerName).build(context),
      body: Container(
        color: AppSettings.SI_BGCOLOR,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: Sermons(
              speaker: _speaker,
              scripture: _scripture,
            ))),
      ),
      floatingActionButton: HomeButton(),
    );
  }
}
