import 'dart:io';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';
import 'package:sermonindex/config/appsettings.dart';
import 'package:sermonindex/models/mdl_speakerinfo.dart';
import 'package:flutter/painting.dart';

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

  var playing = false;
  Duration currentPosition = new Duration();
  Duration musicDuration = new Duration();

  @override
  void initState() {
    playing = false;
    currentPosition = new Duration(seconds: 0);
    musicDuration = new Duration(seconds: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    player.onPlayerCompletion.listen((event) {
      setState(() {
        currentPosition = musicDuration;
        playing = false;
      });
    });

    player.onDurationChanged.listen((Duration duration) {
      setState(() {
        musicDuration = duration;
      });
    });

    player.onAudioPositionChanged.listen((position) {
      currentPosition = position;
    });

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppSettings.SI_BGCOLOR,
          elevation: 0,
        ),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(color: AppSettings.SI_BGCOLOR),
          child: Column(
            children: [
              // SizedBox(
              //   height: 50,
              // ),
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
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                // child: Image.network(imageUrl,scale: , ),
                child: FittedBox(
                  child: (imageUrl == "")
                      ? Image(
                          image: AssetImage("assets/sermonindex.jpg"),
                          fit: BoxFit.fill,
                          height: 200,
                          width: 200,
                        )
                      : Column(
                          children: [
                            Image.network(
                              imageUrl,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: 25,
                            )
                          ],
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          currentPosition.toString().substring(
                              0, currentPosition.toString().indexOf('.')),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          musicDuration.toString().substring(
                              0, musicDuration.toString().indexOf('.')),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    Slider.adaptive(
                      value: currentPosition.inSeconds.toDouble(),
                      min: 0,
                      max: musicDuration.inSeconds.toDouble(),
                      onChanged: (double value) {},
                      activeColor: Colors.black45,
                      inactiveColor: Colors.black12,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppSettings.SI_BGCOLOR,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          onTap: (!playing) ? playAudio : pauseAudio,
                          child: Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                                color: Colors.white10,
                                borderRadius: BorderRadius.circular(50)),
                            child: (!playing)
                                ? Icon(
                                    Icons.play_arrow,
                                    size: 50,
                                  )
                                : Icon(
                                    Icons.pause,
                                    size: 50,
                                  ),
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
                ),
              )
            ],
          ),
        ));
  }

  //Play audio
  void playAudio() async {
    String finalUrl;
    HttpClient client = new HttpClient();
    client.getUrl(Uri.parse(sermon.url)).then((HttpClientRequest request) {
      return request.close();
    }).then((HttpClientResponse response) async {
      // print(response);
      if (response.statusCode == 200) {
        var maxIndex = response.redirects.length - 1;
        finalUrl = response.redirects[maxIndex].location.toString();
        finalUrl = finalUrl.replaceFirst('dl=0', 'dl=1');
        // print(finalUrl);
        if (finalUrl != null) {
          // await player.setUrl(finalUrl);
          await player.play(finalUrl);
          setState(() {
            if (player.state == AudioPlayerState.PLAYING) {
              playing = true;
            } else {
              playing = false;
            }
          });
        }
      }
    });
  }

  //pause audio
  void pauseAudio() async {
    if (player.state == AudioPlayerState.PLAYING) {
      await player.pause();
      setState(() {
        (player.state == AudioPlayerState.PLAYING)
            ? playing = true
            : playing = false;
      });
    }
  }

  //stop audio
  void stopAudio() async {
    if (player.state == AudioPlayerState.PLAYING) {
      await player.stop();
      setState(() {
        (player.state == AudioPlayerState.PLAYING)
            ? playing = true
            : playing = false;
      });
    }
  }
}
