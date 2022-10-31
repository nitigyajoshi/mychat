import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../Widgets/contact.dart';
import '../Widgets/selected_avatar.dart';
import '../model/chatmodel.dart';

class NewGroup extends StatefulWidget {
  const NewGroup({Key? key}) : super(key: key);

  @override
  _NewGroupState createState() => _NewGroupState();
}

class _NewGroupState extends State<NewGroup> {
  List<ChatModel> person = [
    ChatModel(name: 'Nicky', status: 'App Developer'),
    ChatModel(name: 'Rocky', status: 'Web Developer'),
    ChatModel(name: 'Vicky', status: 'Fullstack Developer')
  ];
  List<ChatModel> groups = [];
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
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
              itemCount: person.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                    height: groups.length > 0 ? 90 : 10,
                  );
                }
                return InkWell(
                    onTap: () {
                      if (person[index - 1].select == false) {
                        setState(() {
                          person[index - 1].select = true;
                          groups.add(person[index - 1]);
                        });
                      } else {
                        person[index - 1].select = false;
                        groups.remove(person[index - 1]);
                      }
                    },
                    child: ContactPage(contact: person[index]));
              }),

          groups.length > 0
              ? Column(
                  children: [
                    Container(
                        height: 75,
                        color: Colors.white,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: person.length,
                            itemBuilder: (context, index) {
                              if (person[index].select) {
                                return InkWell(
                                    onTap: () {
                                      setState(() {
                                        groups.remove(person[index]);
                                        // person[index].select=false;
                                      });
                                    },
                                    child: SelectedAvatar());
                              } else {
                                return Container();
                              }
                            })),
                    Divider(
                      thickness: 1,
                    )
                  ],
                )
              : Container(),
          // Divider(thickness: 1,)
        ],
      ),
    );
  }
}
/*
  List<ChatModel>person=[
ChatModel(name:'Nicky',
status:'App Developer'
),
ChatModel(name:'Rocky',
status:'Web Developer'
),ChatModel(name:'Vicky',
status:'Fullstack Developer'
)

    ];
  @override
  Widget build(BuildContext context) {
    
  }




 */