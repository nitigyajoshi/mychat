//@dart=2.9
//import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';

class OwnImage extends StatefulWidget {
  const OwnImage({Key key, this.path, this.message}) : super(key: key);
  final String path;
  final String message;
  @override
  _OwnImageState createState() => _OwnImageState();
}

class _OwnImageState extends State<OwnImage> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: Colors.green[300]),
          height: MediaQuery.of(context).size.height / 2.6,
          width: MediaQuery.of(context).size.width / 1.7,
          child: Card(
            child: Column(
              children: [
                Image.file(
                  File(widget.path),
                  fit: BoxFit.fitHeight,
                ),
                Text(widget.message)
              ],
            ),
            // Image.file(widget.path),
            margin: EdgeInsets.all(4),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
          ),
        ),
      ),
    );
  }
}
