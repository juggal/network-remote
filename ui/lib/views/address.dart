import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Address extends StatefulWidget {
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ipController = TextEditingController();
  final TextEditingController _portController = TextEditingController();
  final String protocol = "ws";
  IOWebSocketChannel channel;
  bool _isLoading = false;

  void handleSubmit() {
    // save current state and extract values
    setState(() {
      this._isLoading = true;
    });
    this._formKey.currentState.save();
    final String ipAddress = this._ipController.text;
    final String port = this._portController.text;

    // connect to websocket server
    final String uri = "$protocol://$ipAddress:$port";
    channel = IOWebSocketChannel.connect(Uri.parse(uri));

    Navigator.pushReplacementNamed(context, '/home', arguments: channel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !this._isLoading
          ? Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: this._ipController,
                      decoration: InputDecoration(
                        hintText: "IP Address",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: this._portController,
                      decoration: InputDecoration(
                        hintText: "PORT",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: this.handleSubmit,
                      child: Text("Connect"),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: SpinKitRing(
                color: Colors.white,
                size: 50.0,
              ),
            ),
    );
  }
}
