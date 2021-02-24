///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Author    : Sherebiah Tisbi
//Date      : 02/20/2021
//Modified  : 02/23/2021
//Objective : A provider class which handles all Audioplayer related functions and notifies the listeners accordingly.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioProvider with ChangeNotifier {
  Duration totalDuration;
  Duration currentPosition;
  AudioPlayer player = new AudioPlayer();
  String status = "Unknown";
  String url = '';

  AudioProvider() {
    initAudio();
  }

  double position() {
    return (currentPosition == null)
        ? null
        : currentPosition.inMilliseconds.toDouble();
  }

  double duration() {
    return (totalDuration == null)
        ? null
        : totalDuration.inMilliseconds.toDouble();
  }

  void initAudio() {
    //handle all player events
    player.onAudioPositionChanged.listen((position) {
      currentPosition = position;
      notifyListeners();
    });

    player.onDurationChanged.listen((duration) {
      totalDuration = duration;
      notifyListeners();
    });

    player.onPlayerStateChanged.listen((value) {
      print(value);
      switch (value) {
        case AudioPlayerState.PLAYING:
          status = "Playing";
          break;
        case AudioPlayerState.STOPPED:
          status = "Stopped";
          break;
        case AudioPlayerState.COMPLETED:
          status = "Completed";
          break;
        case AudioPlayerState.PAUSED:
          status = "Paused";
          break;
      }
      notifyListeners();
    });

    player.onPlayerCompletion.listen((event) {
      currentPosition = totalDuration;
      status = "Completed";
      notifyListeners();
    });

    player.onPlayerError.listen((event) {
      status = "Error";
      notifyListeners();
    });
  }

  ////////////////////////////////////////////////////////////////////////////////////////
  //Function to play the audio for a selected sermon
  //First loop through the redirect list received from exposed API url. The last URL in the resdirect list is
  //the final dropbox MP3 URL.
  //One more update to be made to the URL is to replace dl=0 with dl=1 or else it doesnt work.
  /////////////////////////////////////////////////////////////////////////////////////////
  void playAudio(url) async {
    String finalUrl;
    //use native http client and response insted of any layered third party package
    //as they dont give the redirect info correctly
    HttpClient client = new HttpClient();
    client.getUrl(Uri.parse(url)).then((HttpClientRequest request) {
      return request.close();
    }).then((HttpClientResponse response) async {
      // print(response);
      if (response.statusCode == 200) {
        //get the last index of the resdiect list from HttpResponse object
        var maxIndex = response.redirects.length - 1;
        finalUrl = response.redirects[maxIndex].location.toString();

        //replace dl=0 with dl=1 to make it work. This seems to be contrained with the dropbox url
        finalUrl = finalUrl.replaceFirst('dl=0', 'dl=1');
        // print(finalUrl);
        if (finalUrl != null) {
          // await player.setUrl(finalUrl);
          await player.play(finalUrl);
          status = getStatus();
          notifyListeners();
        }
      }
    });
  }

  void pauseAudio() async {
    await player.pause();
    notifyListeners();
  }

  void stopAudio() async {
    await player.stop();
    notifyListeners();
  }

  void seekAudio(int location) async {
    await player.seek(Duration(milliseconds: location));
    notifyListeners();
  }

  void disposeAudio() async {
    await player.dispose();
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////////////////////////
  //function to handle when forward button is clicked.
  //increments the curent position by 10% of the total duration of the music
  //////////////////////////////////////////////////////////////////////////////////
  void advancePlayPosition() async {
    if (currentPosition == null || totalDuration == null) return;
    int increment = (totalDuration.inMilliseconds.toInt() * .10).toInt();
    var newPosition = currentPosition + new Duration(milliseconds: increment);
    if (newPosition.inMilliseconds > totalDuration.inMilliseconds) {
      newPosition = totalDuration;
    }
    await player.seek(newPosition);
  }

  ///////////////////////////////////////////////////////////////////////////////////
  //function to handle when rewind button is clicked.
  //reverses the curent position by 10% of the total duration of the music
  //////////////////////////////////////////////////////////////////////////////////
  void rewindPlayPosition() async {
    if (currentPosition == null || totalDuration == null) return;
    int decrement = (totalDuration.inMilliseconds.toInt() * .10).toInt();
    var newPosition = currentPosition - new Duration(milliseconds: decrement);
    if (newPosition.inMilliseconds < 0) {
      newPosition = Duration(milliseconds: 0);
    }
    await player.seek(newPosition);
  }

  String getStatus() {
    switch (player.state) {
      case AudioPlayerState.PLAYING:
        status = "Playing";
        break;
      case AudioPlayerState.STOPPED:
        status = "Stopped";
        break;
      case AudioPlayerState.COMPLETED:
        status = "Completed";
        break;
      case AudioPlayerState.PAUSED:
        status = "Paused";
        break;
    }
    return status;
  }

  String positionLabel() {
    return (currentPosition != null)
        ? getFormattedLabel(currentPosition)
        : "00:00";
  }

  String durationLabel() {
    return (totalDuration != null) ? getFormattedLabel(totalDuration) : "00:00";
  }

  String getFormattedLabel(Duration d) {
    var hour = d.inHours;
    var mins = d.inMinutes;
    var secs = d.inSeconds.remainder(60);
    var finalLabel = '';
    if (hour != 0) {
      finalLabel += hour.toString() + ":";
    }
    finalLabel +=
        (mins.toString().length == 1) ? "0" + mins.toString() : mins.toString();
    finalLabel += ":";
    finalLabel +=
        (secs.toString().length == 1) ? "0" + secs.toString() : secs.toString();

    return finalLabel;
  }
}
