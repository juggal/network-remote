import 'package:flutter/material.dart';
import 'package:network_remote/views/keyboard.dart';
import 'package:network_remote/views/mouse.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _handleTap(int index) {
    setState(() {
      this._selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Network Remote"),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/address');
          },
        ),
      ),
      body: Center(child: this._selectedIndex == 0 ? Mouse() : Keyboard()),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.mouse),
            label: "Mouse",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.keyboard),
            label: "Keyboard",
          ),
        ],
        currentIndex: this._selectedIndex,
        onTap: this._handleTap,
        elevation: 36.0,
      ),
    );
  }
}
