import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class MouseButton extends StatelessWidget {
  final String text;
  final IOWebSocketChannel channel;
  final Map<String, String> buttonMap = {
    "LMB": "left",
    "MMB": "middle",
    "RMB": "right",
  };

  MouseButton({
    @required this.text,
    @required this.channel,
  });
  void hanlePressed() {
    channel.sink.add(json
        .encode({"type": "mouseClick", "button": this.buttonMap[this.text]}));
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: this.hanlePressed,
      child: Text("$text"),
      style: ElevatedButton.styleFrom(
        primary: Colors.teal,
      ),
    );
  }
}
