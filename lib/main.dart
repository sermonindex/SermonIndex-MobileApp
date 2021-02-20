import 'package:flutter/material.dart';

import 'pages/homepage.dart';

void main() => runApp(SermonIndexApp());

class SermonIndexApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SermonIndex",
      home: HomePage(),
    );
  }
}
