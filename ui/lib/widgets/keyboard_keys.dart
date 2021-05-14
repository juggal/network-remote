import 'dart:convert';

import 'package:flutter/material.dart';

class KeyboardKeys extends StatelessWidget {
  final IconData icon;

  KeyboardKeys({
    @required this.icon,
    @required this.keyboardKey,
  });

  final String keyboardKey;

  void handlePressed() {
    // channel.sink.add(json.encode({
    //   "type": "keyTap",
    //   "key": this.keyboardKey,
    // }));
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Icon(this.icon),
      onPressed: this.handlePressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.teal,
      ),
    );
  }
}
