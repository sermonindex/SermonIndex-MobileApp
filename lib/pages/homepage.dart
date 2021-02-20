import 'package:flutter/material.dart';
import 'package:sermonindex/pages/speakerspage.dart';
import 'package:sermonindex/widgets/wdg_header.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppHeader,
      body: Container(
        color: Color.fromRGBO(124, 123, 60, 1.0),
        child: Column(
          children: [
            Header(),
            Column(children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (_) => SpeakerPage()));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.black12,
                  ),
                  child: Center(
                      child: Text(
                    "Continue",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  )),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
