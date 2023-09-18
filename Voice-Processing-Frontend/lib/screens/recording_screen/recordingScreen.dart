import 'package:flutter/material.dart';
import './component/body.dart';

class RecordingScreen extends StatefulWidget {
  static final routeName = "/record";
  final String title;

  const RecordingScreen({Key key, this.title}) : super(key: key);

  @override
  _RecordingScreenState createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Body());
  }
}
