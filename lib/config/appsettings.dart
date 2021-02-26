import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  static const String scriptureApi = baseApi + "scripture/_sermonindex.json";
  static const String topicApi = baseApi + "topic/_sermonindex.json";
  static const IconData bibleIcon = FontAwesomeIcons.book;
  static const IconData speakerIcon = FontAwesomeIcons.user;
  static const IconData topicIcon = FontAwesomeIcons.list;
}
