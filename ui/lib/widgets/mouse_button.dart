import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:network_remote/utils/base_url.dart';

class MouseButton extends StatelessWidget {
  final String text;
  final Map<String, String> buttonMap = {
    "LMB": "left",
    "MMB": "middle",
    "RMB": "right",
  };

  MouseButton({
    @required this.text,
  });
  void hanlePressed(BuildContext context) async {
    try {
      await http
          .post(BaseUrl.getUri("/mouse/click"),
              body: json.encode({"button": buttonMap[this.text]}))
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
      onPressed: () => this.hanlePressed(context),
      child: Text("$text"),
      style: ElevatedButton.styleFrom(
        primary: Colors.teal,
      ),
    );
  }
}
