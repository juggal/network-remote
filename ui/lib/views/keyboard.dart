import 'package:flutter/material.dart';
import 'package:network_remote/widgets/keyboard_keys.dart';
import 'package:network_remote/widgets/search_bar.dart';

class Keyboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SearchBar(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              KeyboardKeys(
                icon: Icons.keyboard_arrow_up,
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
                keyboardKey: "left",
              ),
              KeyboardKeys(
                icon: Icons.keyboard_arrow_down,
                keyboardKey: "down",
              ),
              KeyboardKeys(
                icon: Icons.keyboard_arrow_right,
                keyboardKey: "right",
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: KeyboardKeys(
                  icon: Icons.space_bar,
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
                keyboardKey: "v",
              ),
              KeyboardKeys(
                icon: Icons.settings,
                keyboardKey: "winleft",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
