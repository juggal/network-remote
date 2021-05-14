import 'package:flutter/material.dart';
import 'package:network_remote/widgets/keyboard_keys.dart';
import 'dart:convert';

class SearchBar extends StatelessWidget {
  final TextEditingController _queryController = TextEditingController();

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
            onSubmitted: (value) {
              // channel.sink.add(json.encode({
              //   "type": "sendText",
              //   "text": value,
              // }));
              this._queryController.clear();
            },
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
