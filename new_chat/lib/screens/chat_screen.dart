//@dart=2.9
import 'package:flutter/material.dart';
import 'package:new_chat/screens/screen_contact.dart';

import '../Widgets/customcard_chatapp.dart';
import '../model/chatmodel.dart';

class Chat extends StatefulWidget {
  const Chat({Key key, this.chatmodels, this.sourcechat}) : super(key: key);
  final ChatModel sourcechat;
  //fianl ChatModel sourcechat;
  final List<ChatModel> chatmodels;
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
//    List<ChatModel>chat=[
//      ChatModel(
// name:'Ravi'
// ,time:'4:00'
// ,message:'hello buddy',
//      ),
//           ChatModel(
// name:'Vicky'
// ,time:'4:00'
// ,message:'hello buddy',
//      ),
//    ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.message),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (builder) => Contact()));
          }),
      body: ListView.builder(
          itemCount: widget.chatmodels.length,
          itemBuilder: (context, index) {
            return CustomCard(
                model: widget.chatmodels[index], sourcechat: widget.sourcechat);
          }),

      // body: CustomCard(),
    );
  }
}
