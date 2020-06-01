import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final double height;
  final EdgeInsetsGeometry edgeInsets;
  final Color color;
  final Widget child;
  final VoidCallback onPressed;

  Button(
      {Key key,
      @required this.height,
      @required this.color,
      @required this.child,
      @required this.onPressed,
      this.edgeInsets})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      padding: this.edgeInsets,
      decoration: BoxDecoration(
        color: this.color,
        borderRadius: BorderRadius.circular(4.00),
      ),
      child: FlatButton(
        onPressed: this.onPressed,
        child: this.child,
      ),
    );
  }
}
