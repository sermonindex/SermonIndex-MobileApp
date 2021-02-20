import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sermonindex/config/appsettings.dart';

class Speaker {
  final String spkName;
  final String spkSermonFilename;
  final String spkImageUrl;

  Speaker({this.spkName, this.spkSermonFilename, this.spkImageUrl});

  factory Speaker.fromJson(Map<String, dynamic> _speaker) {
    return Speaker(
        spkName: _speaker.toString(), spkSermonFilename: _speaker[0]);
  }
}

Future<List<Speaker>> getSpeakers() async {
  final response = await http.get(AppSettings.speakerApi);
  print(response.statusCode);
  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    // print(jsonData);
    List<Speaker> speakers = [];
    final spkNames = jsonData.keys.toList();
    // print(spkNames.length);
    for (int i = 0; i < spkNames.length; i++) {
      var speakerName = spkNames[i];
      // print(speakerName);
      // print(jsonData[speakerName]);
      speakers.add(new Speaker(
          spkName: speakerName,
          spkSermonFilename: jsonData[speakerName],
          spkImageUrl: AppSettings.baseApi + "images/" + speakerName + ".gif"));
    }
    print("# of speakers : " + speakers.length.toString());
    print(speakers[1200].spkName);
    return speakers;
  } else {
    return null;
  }
}
