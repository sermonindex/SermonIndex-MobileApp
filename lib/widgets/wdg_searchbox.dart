import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final searchController;
  final hintText;
  final padding;

  SearchBox({Key key, this.searchController, this.hintText, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.black38,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: searchController,
                maxLines: 1,
                cursorHeight: 28,
                cursorColor: Colors.white60,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white60,
                ),
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white60,
                    ),
                    fillColor: Colors.white10,
                    focusColor: Colors.black12,
                    hintText: hintText,
                    hintStyle: TextStyle(color: Colors.white60),
                    focusedBorder: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
