import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sermonindex/pages/homepage.dart';

class HomeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context, new MaterialPageRoute(builder: (_) => HomePage()));
      },
      child: FaIcon(FontAwesomeIcons.home),
      backgroundColor: Colors.black,
    );
  }
}
