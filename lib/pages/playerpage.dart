import 'package:flutter/material.dart';
import 'package:sermonindex/config/appsettings.dart';
import 'package:sermonindex/models/audioprovider.dart';
import 'package:sermonindex/models/mdl_speakerinfo.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

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

  _PlayerPageState(this.sermon, this.speakerName, this.imageUrl) {}

  @override
  void initState() {
    super.initState();
    if (context.read<AudioProvider>().status != "Playing") {
      context.read<AudioProvider>().playAudio(sermon.url);
    } else {
      context.read<AudioProvider>().stopAudio();
      context.read<AudioProvider>().playAudio(sermon.url);
    }
  }

  @override
  void dispose() {
    context.read<AudioProvider>().stopAudio();
    context.read<AudioProvider>().disposeAudio();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(context.read<AudioProvider>().status);

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
                          context.watch<AudioProvider>().positionLabel(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          context.watch<AudioProvider>().durationLabel(),
                          // musicDuration.toString().substring(
                          //     0, musicDuration.toString().indexOf('.')),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    Slider.adaptive(
                      value: (context.read<AudioProvider>().position() != null)
                          ? context
                              .watch<AudioProvider>()
                              .currentPosition
                              .inMilliseconds
                              .toDouble()
                          : 0,
                      min: 0,
                      max: (context.read<AudioProvider>().duration() != null)
                          ? context
                              .watch<AudioProvider>()
                              .totalDuration
                              .inMilliseconds
                              .toDouble()
                          : 0,
                      onChanged: (value) => context
                          .read<AudioProvider>()
                          .seekAudio(value.toInt()),
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
                        //rewind button
                        Container(
                          height: 60,
                          width: 60,
                          child: RaisedButton(
                            padding: EdgeInsets.only(left: 1),
                            splashColor: Colors.white38,
                            color: Colors.white24,
                            onPressed: context
                                .read<AudioProvider>()
                                .rewindPlayPosition,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(48)),
                            child: Icon(
                              Icons.fast_rewind,
                              size: 32,
                            ),
                          ),
                        ),
                        //play/pause toggle button
                        Container(
                          height: 60,
                          width: 60,
                          child: RaisedButton(
                            padding: EdgeInsets.only(left: 4),
                            splashColor: Colors.white38,
                            color: Colors.white24,
                            onPressed: () => {
                              (context.read<AudioProvider>().status ==
                                      "Playing")
                                  ? context.read<AudioProvider>().pauseAudio()
                                  : context
                                      .read<AudioProvider>()
                                      .playAudio(sermon.url)
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60)),
                            child: Icon(
                              (context.read<AudioProvider>().status ==
                                      "Playing")
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              size: 44,
                            ),
                          ),
                        ),
                        //fast forward button
                        Container(
                          height: 60,
                          width: 60,
                          child: RaisedButton(
                            splashColor: Colors.white38,
                            color: Colors.white24,
                            onPressed: context
                                .read<AudioProvider>()
                                .advancePlayPosition,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(48)),
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
}
