//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

//final ChatModel model;
class Button extends StatelessWidget {
  const Button({Key key, this.name, this.icon}) : super(key: key);
  final String name;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Color(0xFF25D366),
        child: Icon(
          icon,
          color: Colors.white,
        ),
        radius: 25,
      ),
      title: Text(
        name,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
