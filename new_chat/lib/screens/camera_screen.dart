//@dart=2.9
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:new_chat/screens/camera_gallary.dart';
import 'package:new_chat/screens/video_screen.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

List<CameraDescription> cam;

class Camerascreen extends StatefulWidget {
  const Camerascreen({Key key, this.onsend}) : super(key: key);
  final Function onsend;
  @override
  _CamerascreenState createState() => _CamerascreenState();
}

class _CamerascreenState extends State<Camerascreen> {
  bool flash = false;
  bool isfront = true;
  String videopath = "";
  CameraController _controller;
  bool isrecording = false;
  Future<void> cameravalue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CameraController(cam[0], ResolutionPreset.high);
    cameravalue = _controller.initialize();
  }

  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: cameravalue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          Positioned(
            bottom: 0.0,
            child: Container(
              //height: 10,

              color: Colors.black,

              width: MediaQuery.of(context).size.width,

              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              flash = true;
                            });
                            flash
                                ? _controller.setFlashMode(FlashMode.torch)
                                : _controller.setFlashMode(FlashMode.off);
                          },
                          icon: Icon(
                            flash ? Icons.flash_on : Icons.flash_off,
                            color: Colors.white,
                            size: 20,
                          )),
                      GestureDetector(
                          onLongPress: () async {
//final path=join((await getTemporaryDirectory()).path,"${DateTime.now()}.mp4");
//await _controller.takePicture();
                            await _controller.startVideoRecording();
                            //var v =await _controller.startVideoRecording();

                            setState(() {
                              isrecording = true;
                            });
                            //videopath=path;
//saveTo(path);
                            // picture.saveTo(path);
//Navigator.push(context, MaterialPageRoute(builder: (builder)=>CameraGallary(path: path,)));
                          },
                          onLongPressUp: () async {
                            XFile videopath =
                                await _controller.stopVideoRecording();
                            setState(() {
                              isrecording = false;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) =>
                                        VideoGallary(path: videopath.path)));
// final path=join((await getTemporaryDirectory()).path,"${DateTime.now()}.mp4");
// await _controller.startVideoRecording();
//XFile video=await _controller.startVideoRecording();
                            //XFile picture = await _controller.takePicture();
                            //  picture.saveTo(path);
                          },
                          onTap: () {
                            if (isrecording == false) takephoto(context);
                          },
                          child: isrecording
                              ? Icon(
                                  Icons.radio_button_on,
                                  color: Colors.red,
                                  size: 70,
                                )
                              : Icon(
                                  Icons.panorama_fish_eye,
                                  color: Colors.white,
                                  size: 60,
                                )),
                      IconButton(
                          onPressed: () async {
                            setState(() {
                              isfront = !isfront;
                            });

                            int campostion = isfront ? 0 : 1;
                            _controller = CameraController(
                                cam[campostion], ResolutionPreset.high);
                            cameravalue = _controller.initialize();
                          },
                          icon: Icon(
                            Icons.flip_camera_ios,
                            color: Colors.white,
                            size: 25,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    'hold for video,Tap for photo',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void takephoto(BuildContext context) async {
    final path =
        join((await getTemporaryDirectory()).path, "${DateTime.now()}.png");
//await _controller.takePicture();
    XFile picture = await _controller.takePicture();
    picture.saveTo(path);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (builder) => CameraGallary(
                  path: path,
                  onsend: widget.onsend,
                )));
  }
}
