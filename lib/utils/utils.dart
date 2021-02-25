import 'dart:io';

class Commons {
  static String formattedName(spkname) {
    var words = spkname.split("_");
    String speakername = '';
    for (int index = 0; index < words.length; index++) {
      speakername += words[index][0].toUpperCase();
      speakername +=
          (words[index].length > 1) ? words[index].substring(1) : ' ';
      speakername += " ";
    }
    return speakername;
  }
}
