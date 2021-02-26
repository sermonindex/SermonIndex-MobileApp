import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:SermonIndex/config/appsettings.dart';
import 'package:SermonIndex/models/mdl_speakerinfo.dart';
import 'package:SermonIndex/utils/utils.dart';

class Topic {
  final String topic;
  final String sermonsUrl;

  Topic({this.topic, this.sermonsUrl});

  factory Topic.fromJson(Map<String, dynamic> _topic) {
    return Topic(
        topic: _topic.toString(), sermonsUrl: Commons.formattedName(_topic[0]));
  }
}

Future<List<Topic>> getTopics() async {
  final response = await http.get(AppSettings.topicApi);
  print(response.statusCode);
  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    // print(jsonData);
    List<Topic> topics = [];
    final rowJsonData = jsonData.keys.toList();
    // print(spkNames.length);
    for (int i = 0; i < rowJsonData.length; i++) {
      var jsonElement = rowJsonData[i];
      topics.add(new Topic(
          topic: Commons.formattedName(jsonElement),
          sermonsUrl: AppSettings.baseApi + "topic/" + jsonElement + ".json"));
    }
    print("# of topics : " + topics.length.toString());
    print(topics[10].topic + "," + topics[10].sermonsUrl);
    return topics;
  } else {
    return null;
  }
}

//Fetch Sermons for a given Scripture
Future<List<Sermon>> getTopicInfo(Topic topic) async {
  final response = await http.get(topic.sermonsUrl);

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    // print(jsonData);
    List<Sermon> sermons = [];
    var jsonSermons = jsonData["sermons"];
    jsonSermons.forEach((sermon) => {
          if (sermon["format"].toString().toLowerCase() == "mp3")
            {
              sermons.add(new Sermon(
                  speakerName: sermon["speaker_name"],
                  imageUrl: AppSettings.imageBaseApi +
                      "/images/" +
                      sermon["speaker_name"]
                          .toString()
                          .toLowerCase()
                          .replaceAll(" ", "_")
                          .replaceAll(".", "") +
                      ".gif",
                  title: sermon["title"],
                  url: sermon["url"],
                  topic: sermon["topic"],
                  description: sermon["description"]))
            }
        });

    return sermons;
  } else {
    return null;
  }
}
