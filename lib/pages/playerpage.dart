import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:sermonindex/config/appsettings.dart';
import 'package:sermonindex/models/mdl_speakerinfo.dart';
// import 'package:sermonindex/widgets/sermonlistheader.dart';

class PlayerPage extends StatefulWidget {
  final Sermon sermon;
  final String speakerName;
  final String speakerImageUrl;

  PlayerPage(this.sermon, this.speakerName, this.speakerImageUrl);

  @override
  _PlayerPageState createState() =>
      _PlayerPageState(this.sermon, this.speakerName, this.speakerImageUrl);
}

class _PlayerPageState extends State<PlayerPage> {
  final Sermon sermon;
  final String speakerName;
  final String imageUrl;
  AudioPlayer player = new AudioPlayer();

  _PlayerPageState(this.sermon, this.speakerName, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    print("> Speaker Name > " + speakerName + ", imageUrl > " + imageUrl);
    print(imageUrl == "");
    return Scaffold(
        body: Container(
      width: double.infinity,
      decoration: BoxDecoration(color: AppSettings.SI_BGCOLOR),
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Text(
            speakerName,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black45,
                fontSize: 24,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            // child: Image.network(imageUrl,scale: , ),
            child: FittedBox(
              child: (imageUrl == "")
                  ? Image(
                      image: AssetImage("assets/sermonindex.jpg"),
                      fit: BoxFit.fill,
                      height: 200,
                      width: 200,
                    )
                  : Image.network(
                      imageUrl,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          SizedBox(
            height: 0,
          ),
          Text(
            sermon.title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black45,
                fontSize: 24,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(15),
              scrollDirection: Axis.vertical,
              child: Text(
                sermon.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black45,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                  color: AppSettings.SI_BGCOLOR,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      print('Rewind clicked');
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(50)),
                      child: Icon(
                        Icons.fast_rewind,
                        size: 32,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: playAudio,
                    // (player.state == AudioPlayerState.PAUSED)
                    //     ? playAudio
                    //     : pauseAudio,
                    child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(50)),
                        child: Icon(
                          Icons.play_arrow,
                          size: 50,
                        )
                        // (player.state == AudioPlayerState.PAUSED)
                        //     ? Icon(
                        //         Icons.play_arrow,
                        //         size: 50,
                        //       )
                        //     : Icon(
                        //         Icons.pause,
                        //         size: 50,
                        //       ),
                        ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('Fast forward clicked');
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(50)),
                      child: Icon(
                        Icons.fast_forward,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  void playAudio() async {
    // var url = "https://www.dropbox.com/s/t75549sfu9aanb5/SID13473.mp3?dl=1";
    // var url = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3";
    var url = getFinalUrl(sermon.url);

    // try {
    //   // player.setUrl(url);
    //   int result = await player.play(url);
    //   if (result == 1) {
    //     print('Playing successfully');
    //   }
    // } catch (err) {
    //   print(err);
    // }
  }

  String getFinalUrl(url) async {
    print(sermon.url);
    var finalUrl;
    var client = http.Client();
    var request = new http.Request('GET', Uri.parse(sermon.url))
      ..followRedirects = true;

    var response = await client.send(request);
    if (response.statusCode == 302) {}
    print(response);
    return finalUrl;
  }

  void pauseAudio() {
    if (player.state == AudioPlayerState.PLAYING) {
      player.pause();
    }
  }

  void stopAudio() {
    if (player.state == AudioPlayerState.PLAYING) {
      player.stop();
    }
  }
}
