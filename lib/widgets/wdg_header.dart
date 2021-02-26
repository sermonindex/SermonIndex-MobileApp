import 'dart:ui';

import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  final Alignment titleAlignment;
  final Padding titlePadding;

  const Header({Key key, this.title, this.titleAlignment, this.titlePadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Image(
                            image:
                                AssetImage("assets/sermonidex-top-large-2.png"),
                            fit: BoxFit.fill,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 0, right: 20),
          //   child: Align(
          //     alignment: titleAlignment,
          //     child: Text(
          //       title,
          //       style: TextStyle(
          //           fontSize: 24,
          //           fontWeight: FontWeight.w600,
          //           color: Colors.black38),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
