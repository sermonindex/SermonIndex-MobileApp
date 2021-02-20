import 'package:flutter/material.dart';
import 'package:sermonindex/config/appsettings.dart';
import 'package:sermonindex/utils/utils.dart';

class SermonlistHeader extends StatelessWidget {
  final String speakername;

  SermonlistHeader({this.speakername});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
          Commons.formattedName(speakername),
          style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.w600,
              color: Colors.black54),
        ),
        centerTitle: true,
        backgroundColor: AppSettings.SI_BGCOLOR);
  }
}
