import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:network_remote/widgets/keyboard_keys.dart';
import 'package:web_socket_channel/io.dart';

class Keyboard extends StatelessWidget {
  Keyboard({
    @required this.channel,
  });

  final IOWebSocketChannel channel;
  final TextEditingController _queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextField(
            controller: this._queryController,
            decoration: InputDecoration(
              hintText: "Write here",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.text,
            onSubmitted: (value) {
              channel.sink.add(json.encode({
                "type": "sendText",
                "text": value,
              }));
              this._queryController.clear();
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              KeyboardKeys(
                icon: Icons.keyboard_arrow_up,
                channel: this.channel,
                keyboardKey: "up",
              ),
            ],
          ),
          // SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              KeyboardKeys(
                icon: Icons.keyboard_arrow_left,
                channel: this.channel,
                keyboardKey: "left",
              ),
              KeyboardKeys(
                icon: Icons.keyboard_arrow_down,
                channel: this.channel,
                keyboardKey: "down",
              ),
              KeyboardKeys(
                icon: Icons.keyboard_arrow_right,
                channel: this.channel,
                keyboardKey: "right",
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: KeyboardKeys(
                  icon: Icons.space_bar,
                  channel: this.channel,
                  keyboardKey: "space",
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              KeyboardKeys(
                icon: Icons.settings,
                channel: this.channel,
                keyboardKey: "command",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
