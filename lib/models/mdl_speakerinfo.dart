import 'dart:convert';

import 'package:sermonindex/config/appsettings.dart';
import 'package:sermonindex/models/mdl_speaker.dart';
import 'package:http/http.dart' as http;
import 'package:sermonindex/utils/utils.dart';

class SpeakerInfo {
  final String speakerName;
  final String description;
  final int totalSermons;
  final List<Sermon> sermons;
  final String imageUrl;

  SpeakerInfo(
      {this.speakerName,
      this.description,
      this.totalSermons,
      this.sermons,
      this.imageUrl});
}

class Sermon {
  final String title;
  final String url;
  final List<String> scriptures;
  final String topic;
  final String description;
  final String imageUrl;

  Sermon(
      {this.title,
      this.url,
      this.scriptures,
      this.topic,
      this.description,
      this.imageUrl});
}

Future<SpeakerInfo> getSpeakerInfo(Speaker speaker) async {
  final response = await http
      .get(AppSettings.baseApi + "speaker/" + speaker.spkName + ".json");

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    // print(jsonData);
    List<Sermon> sermons = [];
    var jsonSermons = jsonData["sermons"];
    jsonSermons.forEach((sermon) => {
          if (sermon["format"].toString().toLowerCase() == "mp3")
            {
              sermons.add(new Sermon(
                  title: sermon["title"],
                  url: sermon["url"],
                  topic: sermon["topic"],
                  description: sermon["description"]))
            }
        });

    SpeakerInfo speakerInfo = SpeakerInfo(
        speakerName: Commons.formattedName(jsonData["name"]),
        description: jsonData["description"],
        totalSermons: jsonSermons.length,
        sermons: sermons,
        imageUrl: jsonData["image"] == ""
            ? ""
            : AppSettings.imageBaseApi + jsonData["image"]);
    return speakerInfo;
  } else {
    return null;
  }
}
