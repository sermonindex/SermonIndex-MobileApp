import 'package:flutter/material.dart';

class AppSettings {
  // ignore: non_constant_identifier_names
  static const Color SI_BGCOLOR = Color.fromRGBO(112, 111, 48, 1);
  // ignore: non_constant_identifier_names
  static const Text SI_TITLE_HOME = Text("SermonIndex");
  // ignore: non_constant_identifier_names
  static const TextStyle SI_TITLE_STYLE = TextStyle(
      color: Colors.white10, fontSize: 24, fontWeight: FontWeight.bold);

  // SermonIndex APIs
  static const String baseApi = "http://api.sermonindex.net/audio/";
  static const String speakerApi = baseApi + "speaker/_sermonindex.json";
  static const String imageBaseApi = "http://api.sermonindex.net/";
}
