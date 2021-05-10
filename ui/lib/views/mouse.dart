import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:network_remote/widgets/mouse_button.dart';
import 'package:web_socket_channel/io.dart';

class Mouse extends StatelessWidget {
  Mouse({
    @required this.channel,
  });

  final IOWebSocketChannel channel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints.tight(const Size.fromWidth(450)),
              child: Listener(
                onPointerMove: (event) {
                  // send Offset(x, y) to server
                  final data = {
                    "type": "moveMouse",
                    "dx": event.delta.dx,
                    "dy": event.delta.dy
                  };
                  this.channel.sink.add(json.encode(data));
                },
                onPointerDown: (event) {
                  this.channel.sink.add(json.encode({
                        "type": "mouseClick",
                        "button": "left",
                      }));
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MouseButton(
                text: "LMB",
                channel: this.channel,
              ),
              MouseButton(
                text: "MMB",
                channel: this.channel,
              ),
              MouseButton(
                text: "RMB",
                channel: this.channel,
              ),
            ],
          )
        ],
      ),
    );
  }
}
