import 'package:flutter/material.dart';
import 'package:sermonindex/models/mdl_scripture.dart';
import 'package:sermonindex/widgets/wdg_header.dart';
import 'package:sermonindex/widgets/wdg_scriptures.dart';

class ScripturePage extends StatefulWidget {
  final Scripture scripture;

  const ScripturePage({Key key, this.scripture}) : super(key: key);

  @override
  ScripturePageState createState() => ScripturePageState();
}

class ScripturePageState extends State<ScripturePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(124, 123, 60, 1.0),
        child: Column(
          children: [
            Header(
              title: "Scriptures",
              titleAlignment: Alignment.centerRight,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, left: 8.0, right: 8.0, bottom: 10.0),
              child: Scriptures(),
            ))
          ],
        ),
      ),
    );
  }
}
