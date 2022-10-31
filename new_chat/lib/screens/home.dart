//@dart=2.9
import 'package:flutter/material.dart';
import 'package:new_chat/screens/camera.dart';
import 'package:new_chat/screens/chat_screen.dart';

import '../model/chatmodel.dart';

class Home extends StatefulWidget {
  const Home({Key key, this.chatmodels, this.sourcechat}) : super(key: key);
  //const Home({ Key? key,this.chatmodels} ;
  final List<ChatModel> chatmodels;
  final ChatModel sourcechat;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController controller;
  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 4, vsync: this, initialIndex: 1);
    //TabController controller=TabController();
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            PopupMenuButton(
                onSelected: (value) {},
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      child: Text('NewGroup'),
                      value: "NewGroup",
                    ),
                    PopupMenuItem(
                      child: Text('New bodcast'),
                      value: "New bodcast",
                    ),
                    PopupMenuItem(
                        child: Text('WhatsApp web'), value: "'WhatsApp web"),
                    PopupMenuItem(
                        child: Text('Shared message'), value: "Shared message"),
                    PopupMenuItem(child: Text('Setting'), value: "Settingt")
                  ];
                })
          ],
          title: Text('WhatsApp_Clone'),
          bottom: TabBar(controller: controller, tabs: [
            //Icon(Icons.camera_alt),
            // IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt)),
            Tab(
              icon: Icon(Icons.camera_alt),
            ),
            Text('chat'),
            Tab(
              text: 'Status',
            ),
            Tab(
              text: 'Calls',
            )
          ]),
        ),
        body: TabBarView(
          controller: controller,
          children: [
            Camera(),
            Chat(chatmodels: widget.chatmodels, sourcechat: widget.sourcechat),
            //Text('chats'),
            Text('status'),
            Text(''),
          ],
        ));
  }
}
