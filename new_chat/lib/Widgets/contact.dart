//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../model/chatmodel.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key key, this.contact}) : super(key: key);
  final ChatModel contact;
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      // trailing: Text(Widget.contact.name)),
      leading: Container(
        height: 50,
        width: 50,
        child: Stack(
          children: [
            CircleAvatar(
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ), //contact.select?
            widget.contact.select
                ? Positioned(
                    bottom: 4,
                    right: 5,
                    child: CircleAvatar(
                        backgroundColor: Colors.teal,
                        radius: 11,
                        child:
                            Icon(Icons.check, color: Colors.white, size: 17)))
                : Container(),
          ],
        ),
      ),
      title: Text(widget.contact.name),
      subtitle: Text('Flutter Developer',
          style: TextStyle(
            fontSize: 14,
          )),
    );
  }
}
