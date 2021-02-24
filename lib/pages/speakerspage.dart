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
      body: Container(
        color: Color.fromRGBO(124, 123, 60, 1.0),
        child: Column(
          children: [
            Header(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black38,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        maxLines: 1,
                        cursorHeight: 28,
                        cursorColor: Colors.white60,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white60,
                        ),
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.white60,
                            ),
                            fillColor: Colors.white10,
                            focusColor: Colors.black12,
                            hintText: "Search speaker",
                            hintStyle: TextStyle(color: Colors.white60),
                            focusedBorder: InputBorder.none),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, left: 8.0, right: 8.0, bottom: 8.0),
              child: Speakers(),
            ))
          ],
        ),
      ),
    );
  }
}
