import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:network_remote/utils/base_url.dart';
import 'package:network_remote/widgets/mouse_button.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Mouse extends StatefulWidget {
  @override
  _MouseState createState() => _MouseState();
}

class _MouseState extends State<Mouse> {
  // double _prevX;
  // double _prevY;

  // void hanldePointerMove(X, Y, client) async {
  //   double deltaX = X - this._prevX;
  //   double deltaY = Y - this._prevY;

  //   this._prevX = X;
  //   this._prevY = Y;

  //   final data = {"dx": deltaX, "dy": deltaY};
  //   try {
  //     await client.post(BaseUrl.getUri("/mouse/move"), body: json.encode(data));
  //   } catch (e) {
  //     print(e);
  //   }

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
                // onPointerMove: (event) => this.hanldePointerMove(
                //     event.position.dx, event.position.dy, client),
                onPointerDown: (event) {
                  // this._prevY = event.position.dy;
                  // this._prevX = event.position.dx;
                  print("hello");
                  IO.io("http://192.168.1.7:8001/socket.io")                  
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
