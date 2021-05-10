import 'package:flutter/material.dart';
import 'package:network_remote/views/address.dart';
import 'package:network_remote/views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Address(),
      routes: {
        "/address": (context) => Address(),
        "/home": (context) => Home(),
      },
    );
  }
}
