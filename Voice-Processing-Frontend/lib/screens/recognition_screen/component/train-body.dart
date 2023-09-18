import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fyp/constants.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:fyp/screens/recognition_screen/component/name-dialog.dart';
import 'package:fyp/screens/recording_screen/component/stopWatchStream.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import './INsidetext.dart';
import './playPause.dart';
import './ButtonContainer.dart';

class TrainBody extends StatefulWidget {
  @override
  _TrainBodyState createState() => _TrainBodyState();
}

class _TrainBodyState extends State<TrainBody> {
  FlutterSoundRecorder _myRecorder = FlutterSoundRecorder();
  bool _mRecorderIsInitialized = false;
  String audioPath = "";

  bool isRecording = false;

  Stream<int> timerStream;

  StreamSubscription<int> timerSubscription;

  String secondsStr = "00";

  String _mPath;

  File audioTempFile;

  TextEditingController nameController = TextEditingController();

  String errorText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _myRecorder.openAudioSession().then((value) {
      setState(() {
        _mRecorderIsInitialized = true;
      });
    });
  }

  @override
  void dispose() {
    // Be careful : you must `close` the audio session when you have finished with it.
    _myRecorder.closeAudioSession();
    _myRecorder = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height -
        Scaffold.of(context).appBarMaxHeight;
//    double height = MediaQuery.of(context).size.height;

// Get the proportionate height as per screen size
    double getProportionateScreenWidth(double inputWidth) {
      double screenWidth = width;
      // 375 is the layout width that designer use
      return (inputWidth / 375.0) * screenWidth;
    }

    double paddingHorizontal = getProportionateScreenWidth(92);

    return SingleChildScrollView(
      child: Container(
        height: height,
        child: Column(children: [
          SizedBox(
            height: getProportionateScreenWidth(48),
          ),
          Container(
            height: width - paddingHorizontal,
            child: Stack(
              children: [
                CircularPercentIndicator(
                  radius: width - paddingHorizontal,
                  lineWidth: 13.0,
                  // animation: true,
                  percent: int.parse(secondsStr, radix: 10) / 60,
                  center: InsideText(text: "${secondsStr}s / 60s"),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: kPrimaryColor,
                  backgroundColor: kPrimaryColor.withAlpha(100),
                )
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenWidth(10)),
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(8)),
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: getProportionateScreenWidth(18)),
                textAlign: TextAlign.center,
              ),
            ),
          )),
          SizedBox(height: getProportionateScreenWidth(16)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ButtonContainer(
                width: getProportionateScreenWidth(55),
                height: getProportionateScreenWidth(55),
                iconSize: getProportionateScreenWidth(25),
                gradient: kSecondaryGradientColor,
                color: Color(0xFFfb7c85),
                icon: isRecording ? Icons.close : Icons.mic_sharp,
                onTap: () {
                  if (isRecording) {
                    stopRecorder();
                  } else {
                    startRecording();
                  }
                }),
          ]),
          SizedBox(height: getProportionateScreenWidth(32)),
        ]),
      ),
    );
  }

  Future<void> startRecording() async {
    if (await Permission.microphone.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.

      String dir = (await getTemporaryDirectory()).path;
      audioTempFile = new File('$dir/audio.wav');
      await audioTempFile.create();

      await _myRecorder.startRecorder(
        toFile: audioTempFile.path,
        codec: Codec.pcm16WAV,
      );

      timerStream = stopWatchStream();
      timerSubscription = timerStream.listen((int newTick) {
        if (newTick == 61) {
          stopRecorder();
          showDialog(
              context: context,
              builder: (_) => NameDialog(controller: nameController,onPressSend: () async{
                var dio = Dio();
                // dio.options.baseUrl = 'http://192.168.0.192:5000/api/';
                var formData = FormData();
                formData.files.add(MapEntry(
                    "audio",
                    await MultipartFile.fromFile(
                    audioTempFile.path,
                    filename: "audio.wav")));
                formData.fields
                    .add(MapEntry("name", nameController.text));

                var response = await dio.post(
                'http://10.0.2.2:5000/api/train',
                data: formData);
                print(response);
                Navigator.of(context,rootNavigator: true).pop();

                var responseJson = json.decode(response.toString());

                showDialog(context: context, builder: (_)=> AlertDialog(
                  title: Text("Success!"),
                  content: Padding(padding: EdgeInsets.all(8.0),
                    child: Text(responseJson["success"]),
                  ),
                ));
              }));


        } else {
          setState(() {
            secondsStr = (newTick).floor().toString().padLeft(2, '0');
          });
        }
      });

      isRecording = !isRecording;
    }
  }

  Future<void> stopRecorder() async {
    await _myRecorder.stopRecorder();
    timerSubscription.cancel();
    timerStream = null;
    setState(() {
      secondsStr = '00';
      isRecording = !isRecording;
    });
  }
}
