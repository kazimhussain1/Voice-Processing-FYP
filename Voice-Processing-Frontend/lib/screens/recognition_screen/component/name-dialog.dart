import 'package:flutter/material.dart';

class NameDialog extends StatefulWidget {
  const NameDialog({Key key, this.controller, this.onPressSend}) : super(key: key);

  @override
  _NameDialogState createState() => _NameDialogState();

  final TextEditingController controller;
  final Function() onPressSend;
}

class _NameDialogState extends State<NameDialog> {

  String errorText;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller.addListener(() {
      if(widget.controller.text.isNotEmpty && errorText != null)
        setState(() {
          errorText = null;
        });
    });
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Enter Name and send"),
      content: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
            errorText: errorText, labelText: "Name"),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context,rootNavigator: true).pop();
            },
            child: Text("Cancel")),
        ElevatedButton(
            onPressed: () async {
              if (widget.controller.text.isEmpty) {
                setState(() {
                  errorText = "Name is required";
                });
                return;
              }
              widget?.onPressSend();
            },
            child: Text("Send")),
      ],
    );
  }
}
