import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.deepOrangeAccent,
              child: Icon(
                Icons.whatshot,
                color: Colors.white,
                size: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
