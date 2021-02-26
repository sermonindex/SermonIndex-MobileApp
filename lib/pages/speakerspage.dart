import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sermonindex/config/appsettings.dart';
import 'package:sermonindex/pages/homepage.dart';
import 'package:sermonindex/widgets/wdg_floatingactionbutton.dart';
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
  String searchText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: AppSettings.SI_BGCOLOR,
      //   leading: IconButton(
      //     icon: FaIcon(FontAwesomeIcons.home),
      //     iconSize: 24,
      //     onPressed: () {
      //       Navigator.push(
      //           context, new MaterialPageRoute(builder: (_) => HomePage()));
      //     },
      //   ),
      //   title: Text(
      //     "Speakers",
      //     style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      //   ),
      //   centerTitle: true,
      // ),
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
