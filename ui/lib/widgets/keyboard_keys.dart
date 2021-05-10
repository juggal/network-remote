import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class KeyboardKeys extends StatelessWidget {
  final IconData icon;

  KeyboardKeys({
    @required this.icon,
    @required this.channel,
    @required this.keyboardKey,
  });

  final IOWebSocketChannel channel;
  final String keyboardKey;

  void handlePressed() {
    channel.sink.add(json.encode({
      "type": "keyTap",
      "key": this.keyboardKey,
    }));
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Icon(this.icon),
      onPressed: this.handlePressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.teal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}