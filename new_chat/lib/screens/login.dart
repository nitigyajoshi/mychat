import 'package:flutter/material.dart';
import 'package:new_chat/screens/home.dart';

import '../Widgets/button.dart';
import '../model/chatmodel.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  ChatModel? chatmodel;
  ChatModel? sourcechat;

  List<ChatModel> chatmodels = [
    ChatModel(name: 'Ravi', time: '4:00', message: 'hello buddy', id: 1),
    ChatModel(name: 'Vicky', time: '4:00', message: 'hello buddy', id: 2),
    ChatModel(name: 'walke', time: '4:00', message: 'hello buddy', id: 3),
    ChatModel(name: 'yj244', time: '4:00', message: 'hello buddy', id: 4),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:

//Navigator.pushReplacement(context,MaterialPageRoute(builder:(builder)=>Home(chatmodels:chatmodels)));

          ListView.builder(
              itemCount: chatmodels.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      sourcechat = chatmodels.removeAt(index);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => Home(
                                  chatmodels: chatmodels,
                                  sourcechat: sourcechat)));
                    },
                    child: Button(
                      name: chatmodels[index].name,
                      icon: Icons.person,
                    ));
              }),
      //sourcechat=chatmodels.removeAt(index);
    );
  }
}
