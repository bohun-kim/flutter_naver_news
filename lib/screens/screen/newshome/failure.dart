import 'package:flutter/material.dart';

class Failure extends StatelessWidget {
  const Failure({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text(text),
      ),
    );
  }
}
