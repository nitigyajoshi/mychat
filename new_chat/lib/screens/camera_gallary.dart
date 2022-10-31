//@dart=2.9
import 'dart:io';

import 'package:flutter/material.dart';
class CameraGallary extends StatelessWidget {
 CameraGallary({ Key key,this.path,this.onsend }) : super(key: key);
String path;
Function onsend;
static TextEditingController _controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: 
      Colors.black,title:Text('Photo'),actions: [
IconButton(onPressed: (){}, icon: Icon(Icons.crop_rotate,size: 27,)),
IconButton(onPressed: (){}, icon: Icon(Icons.emoji_emotions_outlined,size: 27,)),
IconButton(onPressed: (){}, icon: Icon(Icons.title,size: 27,)),
IconButton(onPressed: (){}, icon: Icon(Icons.edit,size: 27,)),


      ],),
      body: Container(
height:MediaQuery.of(context).size.height,
width:MediaQuery.of(context).size.width,
child: Stack(children: [Container(
  color: Colors.black,
height:MediaQuery.of(context).size.height-150


,
width:MediaQuery.of(context).size.width,
child: Image.file(File(path),fit: BoxFit.cover,))


,Positioned(bottom: 0,child: Container(width: MediaQuery.of(context).size.width,child: 
TextFormField(controller: _controller,
maxLines: 6,minLines:1,
style: TextStyle(color: Colors.white)


  ,decoration: InputDecoration(suffixIcon: CircleAvatar(radius:24,
  backgroundColor: Colors.tealAccent[700],child: InkWell(onTap: (){
onsend(path,_controller.text.trim());

  },child: Icon(Icons.check)),),prefixIcon: Icon(Icons.add_photo_alternate,color: Colors.black,size: 27,),hintText: 'Add Caption',hintStyle: TextStyle(color:Colors.white)),)))],),
      ),
    );
  }
}