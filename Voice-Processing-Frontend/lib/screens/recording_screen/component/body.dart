import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fyp/constants.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:fyp/screens/recording_screen/component/stopWatchStream.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import './INsidetext.dart';
import './playPause.dart';
import './ButtonContainer.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FlutterSoundRecorder _myRecorder = FlutterSoundRecorder();
  bool _mRecorderIsInitialized = false;

  bool isRecording = false;

  Stream<int> timerStream;

  StreamSubscription<int> timerSubscription;

  String hoursStr = "00";
  String minutesStr = "00";
  String secondsStr = "00";

  File audioTempFile;

  TextEditingController nameController = TextEditingController();

  String errorText;

  bool isPaused = false;

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
    double width = MediaQuery
        .of(context)
        .size
        .width;
//    double height = MediaQuery.of(context).size.height;

// Get the proportionate height as per screen size
    double getProportionateScreenWidth(double inputWidth) {
      double screenWidth = width;
      // 375 is the layout width that designer use
      return (inputWidth / 375.0) * screenWidth;
    }

    return Column(children: [
      SizedBox(
        height: getProportionateScreenWidth(100),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [InsideText(text: "$hoursStr : $minutesStr : $secondsStr")],
      ),
      SizedBox(height: getProportionateScreenWidth(10)),
      isRecording
          ? PlayPause(text: isRecording && isPaused ? "Paused" : "Recording")
          : PlayPause(
        text: "Press the mic to start recording",
      ),
      SizedBox(height: getProportionateScreenWidth(40)),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        ButtonContainer(
          width: getProportionateScreenWidth(45),
          height: getProportionateScreenWidth(45),
          iconSize: getProportionateScreenWidth(15),
          gradient: kSecondaryGradientColor,
          color: Color(0xFFfb7c85),
          icon: Icons.close,
          onTap: () {
            if (isRecording) {
              stopRecorder();
            }
          },
        ),
        SizedBox(width: getProportionateScreenWidth(25)),
        ButtonContainer(
            width: getProportionateScreenWidth(55),
            height: getProportionateScreenWidth(55),
            iconSize: getProportionateScreenWidth(25),
            gradient: kSecondaryGradientColor,
            color: Color(0xFFfb7c85),
            icon: isRecording
                ? isPaused
                ? Icons.mic_sharp
                : Icons.mic_off_sharp
                : Icons.mic_sharp,
            onTap: () {
              if (isPaused) {
                resumeRecorder();
              } else {
                if (isRecording) {
                  pauseRecorder();
                } else {
                  startRecording(
                  );
                }
              }
            }),
        SizedBox(width: getProportionateScreenWidth(25)),
        ButtonContainer(
          width: getProportionateScreenWidth(45),
          height: getProportionateScreenWidth(45),
          iconSize: getProportionateScreenWidth(15),
          gradient: isRecording ? kSecondaryGradientColor : kGreyGradientColor,
          color: isRecording ? Color(0xFFfb7c85) : Colors.grey,
          icon: Icons.check,
          onTap: isRecording
              ? () async {
            if (isRecording) {
              stopRecorder();

              var dio = Dio();
              // dio.options.baseUrl = 'http://192.168.0.192:5000/api/';
              var formData = FormData();
              formData.files.add(MapEntry(
                  "audio",
                  await MultipartFile.fromFile(audioTempFile.path,
                      filename: "audio.wav")));
              formData.fields.add(MapEntry("name", nameController.text));

              var response = await dio
                  .post('http://10.0.2.2:5000/api/speaker-diarization', data: formData);

              var responseJson = json.decode(response.toString());

              showDialog(context: context, builder: (_) =>
                  AlertDialog(
                    title: Text("Success!"),
                    content: Padding(padding: EdgeInsets.all(8.0),
                      child: Text(responseJson["success"]),
                    ),
                  ));
              print(response);
            }
          }
              : null,
        ),
      ]),
    ]);
  }

  Future<void> startRecording() async {
    if (await Permission.microphone
        .request()
        .isGranted) {
      // Either the permission was already granted before or the user just granted it.

      String dir = (await getTemporaryDirectory()).path;
      audioTempFile = new File('$dir/audio.wav');
      await audioTempFile.create();

      await _myRecorder.startRecorder(
        toFile: audioTempFile.path,
        codec: Codec.pcm16WAV,
        sampleRate: 16000,
        numChannels: 1,
      );

      timerStream = stopWatchStream();
      timerSubscription = timerStream.listen((int newTick) {
        setState(() {
          hoursStr =
              ((newTick / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
          minutesStr = ((newTick / 60) % 60).floor().toString().padLeft(2, '0');
          secondsStr = (newTick % 60).floor().toString().padLeft(2, '0');
        });
      });

      isRecording = !isRecording;
    }
  }

  Future<void> stopRecorder() async {
    await _myRecorder.stopRecorder();
    timerSubscription.cancel();
    timerStream = null;
    setState(() {
      hoursStr = '00';
      minutesStr = '00';
      secondsStr = '00';
      isPaused = false;
      isRecording = !isRecording;
    });
  }

  Future<void> pauseRecorder() async {
    await _myRecorder.pauseRecorder();
    timerSubscription.pause();
    setState(() {
      isPaused = true;
    });
  }

  Future<void> resumeRecorder() async {
    await _myRecorder.resumeRecorder();
    timerSubscription.resume();
    setState(() {
      isPaused = false;
    });
  }
}