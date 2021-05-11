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
  bool _showError = false;

  void handleSubmit() {
    // save current state and extract values
    setState(() {
      this._isLoading = true;
    });
    this._formKey.currentState.save();
    final String ipAddress = this._ipController.text;
    final String port = this._portController.text;
    final String uri = "$protocol://$ipAddress:$port";

    // connect to websocket server
    channel = IOWebSocketChannel.connect(Uri.parse(uri));

    channel.stream.listen(
      (event) {
        setState(() {
          this._isLoading = false;
        });

        Navigator.pushReplacementNamed(context, '/home', arguments: channel);
      },
      onError: (error) => setState(() {
        this._showError = true;
        this._isLoading = false;
      }),
      cancelOnError: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !this._isLoading
          ? Padding(
              padding: EdgeInsets.all(16.0),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Form(
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
                  this._showError
                      ? AlertDialog(
                          title: Text('Error'),
                          content: Text('Connection could not be estabilished'),
                          actions: [
                            TextButton(
                                onPressed: () =>
                                    setState(() => this._showError = false),
                                child: Text("CANCEL")),
                            TextButton(
                              onPressed: this.handleSubmit,
                              child: Text("RETRY"),
                            )
                          ],
                          elevation: 10.0,
                        )
                      : Container(),
                ],
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
