//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../model/chatmodel.dart';
import '../screens/individual_chat.dart';

//final ChatModel model;
class CustomCard extends StatelessWidget {
  const CustomCard({Key key, this.model, this.sourcechat}) : super(key: key);
  final ChatModel model;
  final sourcechat;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    IndividualChat(model: model, sourcechat: sourcechat)));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Icon(
                Icons.group,
              ),
              // child: SvgPicture.asset("assets/person.svg",),
              radius: 25,
            ),
            title: Text(
              '${model.name}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                Icon(Icons.done_all),
                SizedBox(
                  width: 4,
                ),
                Text('hi nicky'),
              ],
            ),
            trailing: Text('16:00'),
          ),
          Divider(thickness: 1.0)
        ],
      ),
    );
  }
}
