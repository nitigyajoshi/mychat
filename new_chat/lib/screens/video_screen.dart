
//@dart=2.9
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
class VideoGallary extends StatefulWidget {
 VideoGallary({ Key key,this.path }) : super(key: key);
String path;

  @override
  _VideoGallaryState createState() => _VideoGallaryState();
}

class _VideoGallaryState extends State<VideoGallary> {
    VideoPlayerController _controller;
 void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});

       // print(widget.path);
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,title:Text('Video'),actions: [
IconButton(onPressed: (){}, icon: Icon(Icons.crop_rotate,size: 27,)),
IconButton(onPressed: (){}, icon: Icon(Icons.emoji_emotions_outlined,size: 27,)),
IconButton(onPressed: (){}, icon: Icon(Icons.title,size: 27,)),
IconButton(onPressed: (){}, icon: Icon(Icons.edit,size: 27,)),


      ],),
      body: Container(
height:MediaQuery.of(context).size.height,
width:MediaQuery.of(context).size.width,
child: Stack(children: [Container(
 // color: Colors.black,
height:MediaQuery.of(context).size.height-150,
width:MediaQuery.of(context).size.width,
child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
)
 ]))); }
}