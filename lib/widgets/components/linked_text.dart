import 'package:flutter/material.dart';

class LinkedText extends StatelessWidget {
  final text;
  final textStyle;
  final onTap;

  const LinkedText(
      {Key key,
      @required this.text,
      @required this.textStyle,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(
        this.text,
        textAlign: TextAlign.center,
        style: this.textStyle,
      ),
      onTap: this.onTap,
    );
  }
}
