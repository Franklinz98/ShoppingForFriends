import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_for_friends/constants/colors.dart';

class Input extends StatefulWidget {
  final Function validator;
  final TextInputType inputType;
  final bool obscureText;
  final TextEditingController controller;

  const Input(
      {Key key,
      @required this.validator,
      @required this.controller,
      this.inputType,
      this.obscureText = false})
      : super(key: key);

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      decoration: BoxDecoration(
        color: AppColors.gun_powder,
        borderRadius: BorderRadius.circular(4.00),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
        style: GoogleFonts.roboto(
          fontSize: 16,
          color: AppColors.spun_pearl,
        ),
        keyboardType: widget.inputType,
        obscureText: widget.obscureText,
        validator: widget.validator,
        controller: widget.controller,
      ),
    );
  }
}
