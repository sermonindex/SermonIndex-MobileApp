import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Image.network(
                  imageUrl,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              )
            : SizedBox(
                height: 0,
              ),
        (bio != null && bio.length > 1)
            ? SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(
                  bio,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black45),
                ),
              )
            : Text(
                "No bio details available for " + speakerName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              )
      ]),
    );
  }
}
