import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sermonindex/config/appsettings.dart';
import 'package:sermonindex/utils/utils.dart';

class Scripture {
  final String reference;
  final String sermonsUrl;

  Scripture({this.reference, this.sermonsUrl});

  factory Scripture.fromJson(Map<String, dynamic> _scripture) {
    return Scripture(
        reference: _scripture.toString(),
        sermonsUrl: Commons.formattedName(_scripture[0]));
  }
}

Future<List<Scripture>> getScriptures() async {
  final response = await http.get(AppSettings.scriptureApi);
  print(response.statusCode);
  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    // print(jsonData);
    List<Scripture> scriptures = [];
    final rowJsonData = jsonData.keys.toList();
    // print(spkNames.length);
    for (int i = 0; i < rowJsonData.length; i++) {
      var jsonElement = rowJsonData[i];
      scriptures.add(new Scripture(
          reference: Commons.formattedName(jsonElement),
          sermonsUrl:
              AppSettings.baseApi + "scripture/" + jsonElement + ".json"));
    }
    print("# of scripture : " + scriptures.length.toString());
    print(scriptures[10].reference + "," + scriptures[10].sermonsUrl);
    return scriptures;
  } else {
    return null;
  }
}
