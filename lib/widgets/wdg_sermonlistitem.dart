import 'package:SermonIndex/config/appsettings.dart';
import 'package:SermonIndex/pages/playerpage.dart';
import 'package:flutter/material.dart';

class SermonListItem extends StatelessWidget {
  final sermonData;
  final sermomParentType;
  final speakerName;
  final imageUrl;

  const SermonListItem(
      {Key key,
      this.sermonData,
      this.sermomParentType,
      this.speakerName,
      this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(1.0),
        child: Card(
          color: AppSettings.SI_BGCOLOR.withAlpha(180),
          child: ListTile(
            title: Text(
              sermonData.title,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
            ),
            trailing: Container(
              child: IconButton(
                icon: Icon(Icons.play_circle_fill, size: 30),
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => PlayerPage(
                                sermonData,
                                (sermomParentType) == "Speaker"
                                    ? speakerName
                                    : sermonData.speakerName,
                                (sermomParentType) == "Speaker"
                                    ? imageUrl
                                    : sermonData.imageUrl,
                              )));
                },
              ),
            ),
          ),
        ));
    ;
  }
}
