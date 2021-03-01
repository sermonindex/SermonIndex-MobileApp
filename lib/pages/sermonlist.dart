import 'package:flutter/material.dart';
import 'package:SermonIndex/config/appsettings.dart';
import 'package:SermonIndex/models/mdl_scripture.dart';
import 'package:SermonIndex/models/mdl_speaker.dart';
import 'package:SermonIndex/models/mdl_topic.dart';
import 'package:SermonIndex/utils/utils.dart';
import 'package:SermonIndex/widgets/wdg_floatingactionbutton.dart';
import 'package:SermonIndex/widgets/wdg_sermons.dart';

class Sermonlist extends StatefulWidget {
  final Speaker speaker;
  final Scripture scripture;
  final Topic topic;

  Sermonlist({this.speaker, this.scripture, this.topic});

  @override
  _SermonlistState createState() =>
      _SermonlistState(this.speaker, this.scripture, this.topic);
}

class _SermonlistState extends State<Sermonlist> {
  final Speaker _speaker;
  final Scripture _scripture;
  final Topic _topic;

  String _speakerName;
  bool showBio = false;

  _SermonlistState(this._speaker, this._scripture, this._topic);

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
    if (_topic != null) {
      _speakerName = _topic.topic;
      print('Topic is not null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppSettings.SI_BGCOLOR,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Sermons(
              speaker: _speaker,
              scripture: _scripture,
              topic: _topic,
              pageTitle: Commons.formattedName(_speakerName),
            )),
      ),
      floatingActionButton: HomeButton(),
    );
  }
}
