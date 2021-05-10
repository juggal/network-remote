import 'package:flutter/material.dart';
import 'package:network_remote/widgets/keyboard_keys.dart';
import 'package:network_remote/widgets/search_bar.dart';
import 'package:web_socket_channel/io.dart';

class Keyboard extends StatelessWidget {
  Keyboard({
    @required this.channel,
  });

  final IOWebSocketChannel channel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SearchBar(channel: channel),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              KeyboardKeys(
                icon: Icons.subtitles,
                channel: channel,
                keyboardKey: "v",
              ),
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
