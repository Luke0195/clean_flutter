import 'package:flutter/material.dart';

class HeadinLine1 extends StatelessWidget {
  final String text;

  const HeadinLine1({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
