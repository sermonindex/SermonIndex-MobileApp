import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sermonindex/models/audioprovider.dart';

import 'pages/homepage.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AudioProvider()),
      ],
      child: SermonIndexApp(),
    ));

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
