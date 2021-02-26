////////////////////////////////////////////////////////////////////////////////////////////////
///Author       : Sherebiah Tisbi
///Date Written : 18th Feb 2021
///Last Modified: 25th Feb 2021
///
///This is the code for the actual player page and deals with all common player functionality
///////////////////////////////////////////////////////////////////////////////////////////////

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sermonindex/config/appsettings.dart';
import 'package:sermonindex/models/audioprovider.dart';
import 'package:sermonindex/models/mdl_speakerinfo.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:sermonindex/widgets/wdg_floatingactionbutton.dart';

class PlayerPage extends StatefulWidget {
  //Class parameters set in constructor
  final Sermon sermon;
  final String speakerName;
  final String speakerImageUrl;

  //Constructor
  PlayerPage(this.sermon, this.speakerName, this.speakerImageUrl);

  @override
  _PlayerPageState createState() =>
      _PlayerPageState(this.sermon, this.speakerName, this.speakerImageUrl);
}

//State manager class
class _PlayerPageState extends State<PlayerPage> {
  //Class parameters set in constructor
  final Sermon sermon;
  final String speakerName;
  final String imageUrl;
  String _imageUrl;

  //Constructor
  _PlayerPageState(this.sermon, this.speakerName, this.imageUrl);

  //Initialize the state
  @override
  void initState() {
    super.initState();

    //Start loading and playing audio immediately when the page
    //is shown
    if (context.read<AudioProvider>().status != "Playing") {
      context.read<AudioProvider>().playAudio(sermon.url);
    } else {
      //If user selected different audio while one is already playing
      //then stop the existing and start the newly selected
      context.read<AudioProvider>().stopAudio();
      context.read<AudioProvider>().playAudio(sermon.url);
    }

    //Check if the iage URL exists for the speaker
    imageExist();
  }

  //dispose the player when page is disposed.
  @override
  void dispose() {
    context.read<AudioProvider>().stopAudio();
    context.read<AudioProvider>().disposeAudio();
    super.dispose();
  }

  //makes an Http call to the image Url to see if it exists and
  //sets the state variable which will be used later on
  imageExist() {
    print("Image url : " + imageUrl);
    if (imageUrl == "") {
      setState(() {
        _imageUrl = "";
      });
    } else {
      HttpClient client = new HttpClient();
      client.getUrl(Uri.parse(imageUrl)).then((HttpClientRequest request) {
        return request.close();
      }).then((HttpClientResponse response) {
        setState(() {
          print("Status code : " + response.statusCode.toString());
          print("Redirects : " + response.redirects.length.toString());
          _imageUrl = (response.redirects.length > 1) ? "" : imageUrl;
        });
      });
    }
  }

  //main Widget which delivers the page UI
  @override
  Widget build(BuildContext context) {
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
              child: FittedBox(
                //state variable set in imageExist() function is used here to
                //render the speaker image, if speaker image does not exist
                //then display serminindex logo
                child: (_imageUrl == "")
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
            //Set the Sermon Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                sermon.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black45,
                    fontSize: 24,
                    fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            //Set the sermon descrioption as a scrollable view in case
            //description is longer than the available display area.
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                scrollDirection: Axis.vertical,
                child: Text(
                  sermon.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black38,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            //Set the labels for current play position and total music duration
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
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  //Slider which displays the actual play position
                  //can be dragged forward and backwar to change play position
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
                    onChanged: (value) =>
                        context.read<AudioProvider>().seekAudio(value.toInt()),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        child: RaisedButton(
                          padding: EdgeInsets.only(left: 2),
                          splashColor: Colors.white38,
                          color: Colors.white24,
                          onPressed: () => {
                            //if audio is already playing then pause
                            //else play
                            (context.read<AudioProvider>().status == "Playing")
                                ? context.read<AudioProvider>().pauseAudio()
                                : context
                                    .read<AudioProvider>()
                                    .playAudio(sermon.url)
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60)),
                          child: Icon(
                            (context.read<AudioProvider>().status == "Playing")
                                ? Icons.pause
                                : Icons.play_arrow,
                            size: 44,
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
      ),
      floatingActionButton: HomeButton(),
    );
  }
}
