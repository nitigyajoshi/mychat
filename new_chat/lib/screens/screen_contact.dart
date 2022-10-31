import 'package:flutter/material.dart';
import 'package:new_chat/screens/new_group.dart';

import '../Widgets/button.dart';
import '../Widgets/contact.dart';
import '../model/chatmodel.dart';

class Contact extends StatefulWidget {
  //const Contact({ Key? key }) : super(key: key);

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  List<ChatModel> person = [
    ChatModel(name: 'Nicky', status: 'App Developer'),
    ChatModel(name: 'Rocky', status: 'Web Developer'),
    ChatModel(name: 'Vicky', status: 'Fullstack Developer')
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Select Contact',
              style: TextStyle(fontSize: 19),
            ),
            Text(
              '200 contacts',
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          PopupMenuButton(
              onSelected: (value) {},
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Text('Invite friend'),
                    value: "Invite friend",
                  ),
                  PopupMenuItem(
                    child: Text('contact'),
                    value: "contact",
                  ),
                  PopupMenuItem(child: Text('Refresh'), value: "Refresh"),
                  PopupMenuItem(child: Text('Help'), value: "Help"),
                ];
              })
        ],
      ),
      body: ListView.builder(
          itemCount: person.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => NewGroup()));
                  },
                  child: Button(
                    icon: Icons.group,
                    name: 'New Group',
                  ));
            } else if (index == 1) {
              return Button(
                icon: Icons.person_add,
                name: 'New Contact',
              );
            }
            return ContactPage(contact: person[index - 2]);
          }),
    );
  }
}
