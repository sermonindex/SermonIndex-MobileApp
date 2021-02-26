import 'package:flutter/material.dart';

class SpeakerBio extends StatelessWidget {
  final String bio;
  final String imageUrl;
  final String speakerName;

  const SpeakerBio({Key key, this.bio, this.imageUrl, this.speakerName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        (imageUrl != "")
            ? Image.network(
                imageUrl,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              )
            : SizedBox(
                height: 0,
              ),
        (bio != null && bio.length > 1)
            ? Text(bio)
            : Text(
                "No bio details available for " + speakerName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              )
      ]),
    );
  }
}
