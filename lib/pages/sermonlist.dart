import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      appBar: AppBar(
          title: Text(
            Commons.formattedName(_speakerName),
            style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w600,
                color: Colors.black54),
          ),
          actions: [
            (_speaker != null)
                ? IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.infoCircle,
                      color: Colors.white30,
                    ),
                    onPressed: () {
                      setState(() {
                        showBio = true;
                      });
                    })
                : SizedBox(
                    height: 0,
                  )
          ],
          centerTitle: true,
          backgroundColor: AppSettings.SI_BGCOLOR),
      body: Container(
        color: AppSettings.SI_BGCOLOR,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Sermons(
                speaker: _speaker, scripture: _scripture, topic: _topic)),
      ),
      floatingActionButton: HomeButton(),
    );
  }
}
