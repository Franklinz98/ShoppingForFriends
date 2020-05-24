import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_for_friends/constants/colors.dart';

class DismissibleBackground extends StatelessWidget {
  final double alignment;

  const DismissibleBackground({Key key, @required this.alignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.charade,
        borderRadius: BorderRadius.circular(4.00),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment(this.alignment, 0.0),
      child: Text(
        'ELIMINAR',
        style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            textStyle: TextStyle(color: Colors.white)),
      ),
    );
  }
}
