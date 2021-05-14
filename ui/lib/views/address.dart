import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:network_remote/utils/base_url.dart';

class Address extends StatefulWidget {
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ipController = TextEditingController();
  final TextEditingController _portController = TextEditingController();
  final String protocol = "http";
  bool _isLoading = false;
  bool _showError = false;

  void handleSubmit() async {
    // save current state and extract values
    setState(() {
      this._isLoading = true;
    });
    this._formKey.currentState.save();
    final String ipAddress = this._ipController.text;
    final String port = this._portController.text;
    http.Response response;

    // set base url for whole app
    BaseUrl(ipAddress, port);

    try {
      response = await http.get(BaseUrl.getUri("/isalive")).timeout(
            Duration(seconds: 5),
            onTimeout: () => throw TimeoutException,
          );
      setState(() {
        this._isLoading = false;
        this._showError = false;
      });
    } catch (e) {
      // print(e);
      setState(() {
        _showError = true;
        _isLoading = false;
      });
    } finally {
      if (!this._showError && response.statusCode == 200) {
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        setState(() {
          _showError = true;
        });
      }
    }
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
