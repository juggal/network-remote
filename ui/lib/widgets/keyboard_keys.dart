import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:network_remote/utils/base_url.dart';

class KeyboardKeys extends StatelessWidget {
  final IconData icon;

  KeyboardKeys({
    @required this.icon,
    @required this.keyboardKey,
  });

  final String keyboardKey;

  void handlePressed() async {
    try {
      await http
          .post(BaseUrl.getUri("/keyboard/press"),
              body: json.encode({
                "key": this.keyboardKey,
              }))
          .timeout(
            Duration(seconds: 1),
            onTimeout: () => throw TimeoutException,
          );
    } catch (e) {
      // Navigator.pushReplacementNamed(context, "/address");
      print(e);
    }
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
