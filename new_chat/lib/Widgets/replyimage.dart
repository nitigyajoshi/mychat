//@dart=2.9
//import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
class ReplyImage extends StatefulWidget {
  const ReplyImage({ Key key,this.path,this.message }) : super(key: key);
final String path;
final String message;
  @override
  _ReplyImageState createState() => _ReplyImageState();
}

class _ReplyImageState extends State<ReplyImage> {
  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 5),
        child: Container(decoration: BoxDecoration(
borderRadius: BorderRadius.circular(13),
color: Colors.grey[300]

        ),
          height: MediaQuery.of(context).size.height/2.6,
          width: MediaQuery.of(context).size.width/1.7,child:
   Column(
            children: [
              Expanded(
                child: Image.network('http:// 192.168.1.5:5000/uploads/${widget.path}',
                // Image.file(File(widget.path),
                 fit: BoxFit.fitHeight,
                 ),
              ),
              widget.message.length>0?Container(
height: 40,
                child: Padding(
                  padding: const EdgeInsets.only(left: 14,top: 8),
                  child: Text(widget.message,
                  overflow:TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15
                  ),),
                ),
              ):Container(),
              Text(widget.message)
            ],
          ),
          // Image.file(widget.path),
margin: EdgeInsets.all(4),
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(13)
            // ),
          ),
        ),
      );

  }
}