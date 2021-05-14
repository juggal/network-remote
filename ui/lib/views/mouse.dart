import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:network_remote/utils/base_url.dart';
import 'package:network_remote/widgets/mouse_button.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class Mouse extends StatefulWidget {
  @override
  _MouseState createState() => _MouseState();
}

class _MouseState extends State<Mouse> {
  double _prevX;
  double _prevY;
  IOWebSocketChannel channel;

  @override
  void initState() {
    channel = IOWebSocketChannel.connect(BaseUrl.getSocketUri("8001"));
    super.initState();
  }

  @override
  void dispose() {
    channel.sink.close(status.normalClosure);
    super.dispose();
  }

  void hanldePointerMove(X, Y, channel) async {
    double deltaX = X - this._prevX;
    double deltaY = Y - this._prevY;

    this._prevX = X;
    this._prevY = Y;

    final data = {"dx": deltaX, "dy": deltaY};

    channel.sink.add(json.encode(data));
  }

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
                onPointerMove: (event) => this.hanldePointerMove(
                    event.position.dx, event.position.dy, channel),
                onPointerDown: (event) {
                  this._prevY = event.position.dy;
                  this._prevX = event.position.dx;
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
              ),
              MouseButton(
                text: "MMB",
              ),
              MouseButton(
                text: "RMB",
              ),
            ],
          )
        ],
      ),
    );
  }
}
