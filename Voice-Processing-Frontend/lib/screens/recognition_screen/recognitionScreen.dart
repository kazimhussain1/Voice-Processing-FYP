import 'package:flutter/material.dart';
import './component/train-body.dart';
import './component/test-body.dart';

class RecognitionScreen extends StatefulWidget {
  static final routeName = "/recognition";
  final String title;

  const RecognitionScreen({Key key, this.title}) : super(key: key);

  @override
  _RecognitionScreenState createState() => _RecognitionScreenState();
}

class _RecognitionScreenState extends State<RecognitionScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            bottom: TabBar(
              tabs: [Tab(text: "Train Model"), Tab(text: "Test Model")],
            ),
          ),
          body: TabBarView(children: [TrainBody(), TestBody()])),
    );
  }
}
