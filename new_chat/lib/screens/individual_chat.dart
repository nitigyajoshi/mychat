//@dart=2.9
import 'dart:convert';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:new_chat/screens/camera_gallary.dart';
import 'package:new_chat/screens/camera_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../Widgets/own_message.dart';
import '../Widgets/ownimage.dart';
import '../Widgets/reply_message.dart';
import '../Widgets/replyimage.dart';
import '../model/chatmodel.dart';
import '../model/messagemodel.dart';

class IndividualChat extends StatefulWidget {
  const IndividualChat({Key key, this.model, this.sourcechat})
      : super(key: key);
  final ChatModel model;
//final Chatmodel sourcechat
  final ChatModel sourcechat;
  @override
  _IndividualChatState createState() => _IndividualChatState();
}

class _IndividualChatState extends State<IndividualChat> {
  bool show = false;
  IO.Socket socket;
  XFile file;
  bool sendbutton = false;
  int pop = 0;
  ImagePicker _picker = ImagePicker();
  //IO.Socket socket = IO.io('http://localhost:3000');
  List<MessageModel> messages = [];

  //IO.Socket socket;
  FocusNode focusnode = FocusNode();
  TextEditingController controller = TextEditingController();
  ScrollController scroll = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
    focusnode.addListener(() {
      if (focusnode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  }

  void message(String message, int sourceid, int targetid, String path) {
    setmessage("source", message, path);

    socket.emit("message", {
      "message": message,
      "sourceid": sourceid,
      "targetid": targetid,
      "path": path
    });
  }

  void connect() {
    socket = IO.io(
        "https://chat-app1011.herokuapp.com/"
        //"http://  192.168.1.5:5000"

        ,
        <String, dynamic>{
          "transports": ["websocket"],
          "autoConnect": false,
        });
    socket.connect();
    socket.onConnect((data) {
      print("...connected................");
      socket.on("message", (msg) {
        print(msg);
        setmessage("destination", msg["message"], msg("path"));
        scroll.animateTo(scroll.position.maxScrollExtent,
            duration: Duration(milliseconds: 100), curve: Curves.easeOut);
      });
    });
    print(socket.connected);
    socket.emit("signin", widget.sourcechat.id);
  }

  void sendimage(String path, String message) async {
    for (var i = 0; i < pop; i++) {
      Navigator.pop(context);
      setState(() {
        pop = 0;
      });
    }
    print('working $message');

    var request = http.MultipartRequest(
        "POST", Uri.parse("http://192.168.1.5:5000/routes/addimage"));
    request.files.add(await http.MultipartFile.fromPath("img", path));
    request.headers.addAll({
      "Content-type": "multipart/from-data",
    });

    http.StreamedResponse response = await request.send();
    var httpResponse = await http.Response.fromStream(response);
    var data = json.decode(httpResponse.body);
    print(data['path']);
    print(response.statusCode);
    setmessage("source", message, path);

    socket.emit("message", {
      "message": message,
      "sourceid": widget.sourcechat.id,
      "targetid": widget.model.id,
      "path": path
    });
  }

////////////////////////////////////////////////////////////////////////////////////////////////////

  void setmessage(String type, String message, String path) {
    MessageModel messageModel =
        MessageModel(type: type, message: message, path: path);
    setState(() {
      messages.add(messageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/whasapp.png',
          width: MediaQuery.of(context).size.height,
          height: MediaQuery.of(context).size.height,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          //backgroundColor: Colors.blueGrey,
          appBar: AppBar(
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.video_call)),
              IconButton(onPressed: () {}, icon: Icon(Icons.call)),
              PopupMenuButton(
                  onSelected: (value) {},
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        child: Text('view contact'),
                        value: "view contact",
                      ),
                      PopupMenuItem(
                        child: Text('Media,linksand docs'),
                        value: "Media,linksand docs",
                      ),
                      PopupMenuItem(
                          child: Text('Mute notification'),
                          value: "Mute notification"),
                      PopupMenuItem(
                          child: Text('Wallpaper'), value: "Wallpaper"),
                      PopupMenuItem(child: Text('More'), value: "More")
                    ];
                  })
            ],
            title: Column(
              children: [
                Text(widget.model.name),
                Text(
                  'last seen Today at 4:00',
                  style: TextStyle(fontSize: 14),
                )
              ],
            ),
            leadingWidth: 70,
            leading: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                CircleAvatar(
                  child: Icon(Icons.person),
                  radius: 10,
                  backgroundColor: Colors.brown,
                )
              ],
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              child: Stack(
                children: [
                  // ListView.builder(itemBuilder: itemBuilder)
                  Container(
                      width: MediaQuery.of(context).size.width - 55,
                      child: Expanded(
                        //height:MediaQuery.of(context).size.height-140,
                        child: ListView.builder(
                            controller: scroll,
                            itemCount: messages.length + 1,
                            itemBuilder: (context, index) {
                              if (index == messages.length) {
                                return Container(
                                  height: 30,
                                );
                              }
                              if (messages[index].type == "source") {
                                if (messages[index].path.length > 0) {
                                  OwnImage(
                                    path: messages[index].path,
                                    message: messages[index].message,
                                  );
                                } else {
                                  return OwnMessage(
                                    messages: messages[index].message,
                                  );
                                }
                                return OwnMessage(
                                  messages: messages[index].message,
                                );
                              } else {
                                if (messages[index].path.length > 0) {
                                  return ReplyImage(
                                    path: messages[index].path,
                                    message: messages[index].message,
                                  );
                                } else
                                  return ReplyMessage(
                                    messages: messages[index].message,
                                  );
                              }
                            }),
                        //shrinkWrap: true,
                      )),

                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 74,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Container(

                                    //color: Colors.brown,

                                    width:
                                        MediaQuery.of(context).size.width - 55,
                                    child: Card(
                                      margin: EdgeInsets.only(
                                          left: 2, right: 2, bottom: 2),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: TextFormField(
                                        onChanged: (value) {
                                          if (value.length > 0) {
                                            setState(() {
                                              sendbutton = true;
                                            });
                                          } else {
                                            setState(() {
                                              sendbutton = false;
                                            });
                                          }
                                        },
                                        controller: controller,
                                        focusNode: focusnode,
                                        maxLines: 5,
                                        minLines: 1,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: InputDecoration(
                                            hintText: 'Type message',
                                            prefix: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    focusnode.unfocus();

                                                    focusnode.canRequestFocus =
                                                        false;

                                                    show = !show;
                                                  });
                                                },
                                                icon:
                                                    Icon(Icons.emoji_emotions)),
                                            suffixIcon: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      showModalBottomSheet(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              bottomsheet());
                                                    },
                                                    icon: Icon(
                                                        Icons.attach_file)),
                                                IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        pop = 2;
                                                      });
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (builder) =>
                                                                  Camerascreen(
                                                                    onsend:
                                                                        sendimage,
                                                                  )));
                                                    },
                                                    icon:
                                                        Icon(Icons.camera_alt))
                                              ],
                                            )),
                                      ),
                                    )),
                                CircleAvatar(
                                  radius: 25,
                                  child: IconButton(
                                      onPressed: () {
                                        if (sendbutton) {
                                          scroll.animateTo(
                                              scroll.position.maxScrollExtent,
                                              duration:
                                                  Duration(milliseconds: 100),
                                              curve: Curves.easeOut);
                                          message(
                                              controller.text,
                                              widget.sourcechat.id,
                                              widget.model.id,
                                              "");

                                          controller.clear();
                                          setState(() {
                                            sendbutton = false;
                                          });
                                        }
                                      },
                                      icon: sendbutton
                                          ? Icon(Icons.send)
                                          : Icon(
                                              Icons.mic,
                                              color: Colors.white,
                                            )),
                                ),
                              ],
                            ),
                            show ? emoji() : Container(),
                          ],
                        ),
                      ))
                ],
              ),
              onWillPop: () {
                if (show) {
                  setState(() {
                    show = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget emoji() {
    return EmojiPicker(
        config: Config(
          // rows: 4,
          columns: 7,
        ),
        onEmojiSelected: (emoji, Category) {
          setState(() {
            textEditingController:
            controller;
            //   controller.text = controller.text + emoji.emoji;
          });
        });
  }

  Widget bottomsheet() {
    return Container(
        height: 278,
        width: MediaQuery.of(context).size.width,
        child: Card(
            margin: EdgeInsets.all(18),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      bottomicon(Icons.insert_drive_file, Colors.indigo,
                          "Documents", () {}),
                      SizedBox(
                        height: 10,
                      ),
                      bottomicon(Icons.camera_alt, Colors.pink, "camera", () {
                        setState(() {
                          pop = 3;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => Camerascreen()));
                      }),
                      SizedBox(
                        height: 10,
                      ),
                      bottomicon(Icons.insert_photo, Colors.purple, "Gallary",
                          () async {
                        setState(() {
                          pop = 2;
                        });
                        file = await _picker.pickImage(
                            source: ImageSource.gallery);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => CameraGallary(
                                      path: file.path,
                                      onsend: sendimage,
                                    )));
                      }),
                    ],
                  ),
                  Row(
                    children: [
                      bottomicon(Icons.headset, Colors.orange, "Audio", () {}),
                      SizedBox(
                        height: 40,
                      ),
                      bottomicon(
                          Icons.location_pin, Colors.pink, "location", () {}),
                      SizedBox(
                        height: 40,
                      ),
                      bottomicon(Icons.person, Colors.blue, "Contact", () {}),
                    ],
                  )
                ],
              ),
            )));
  }

  Widget bottomicon(IconData data, Color color, String text, Function ontap) {
    return InkWell(
      onTap: ontap,
      child: Column(
        children: [
          CircleAvatar(
            //backgroundColor: color,

            radius: 20,

            child: Icon(
              data,
              size: 29,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(text)
        ],
      ),
    );
  }
}
