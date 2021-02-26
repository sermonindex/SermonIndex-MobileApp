import 'package:flutter/material.dart';
import 'package:SermonIndex/config/appsettings.dart';

Widget AppHeader = AppBar(
  // leading: IconButton(
  //   icon: Icon(
  //     Icons.menu,
  //     color: Colors.white,
  //   ),
  //   onPressed: () {},
  // ),
  // leading: Image(
  //   image: AssetImage("assets/sermonidex-top-large-2.png"),
  //   fit: BoxFit.cover,
  // ),
  // title: AppSettings.SI_TITLE_HOME,
  title: Image(
    image: AssetImage("assets/sermonidex-top-large-2.png"),
    fit: BoxFit.cover,
  ),
  // centerTitle: true,
  backgroundColor: AppSettings.SI_BGCOLOR,
  actions: <Widget>[
    IconButton(
      icon: Icon(
        Icons.settings,
        color: Colors.white,
      ),
      onPressed: () {},
    )
  ],
);
