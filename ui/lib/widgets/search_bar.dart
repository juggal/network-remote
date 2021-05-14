import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:network_remote/utils/base_url.dart';
import 'package:network_remote/widgets/keyboard_keys.dart';
import 'package:http/http.dart' as http;

class SearchBar extends StatelessWidget {
  final TextEditingController _queryController = TextEditingController();

  void handleSubmit(String value) async {
    try {
      await http
          .post(BaseUrl.getUri("/keyboard/type"),
              body: json.encode({
                "text": value,
              }))
          .timeout(Duration(seconds: 1),
              onTimeout: () => throw TimeoutException);
    } catch (e) {
      // Navigator.pushReplacementNamed(context, "/address");
      print(e);
    } finally {
      this._queryController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: KeyboardKeys(
            icon: Icons.backspace,
            keyboardKey: "backspace",
          ),
        ),
        Flexible(
          flex: 3,
          child: TextField(
            controller: this._queryController,
            decoration: InputDecoration(
              hintText: "Write here",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.text,
            onSubmitted: (value) => this.handleSubmit(value),
          ),
        ),
        Flexible(
          child: KeyboardKeys(
            icon: Icons.search,
            keyboardKey: "enter",
          ),
        ),
      ],
    );
  }
}
