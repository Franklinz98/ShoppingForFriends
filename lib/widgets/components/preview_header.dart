import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_for_friends/constants/colors.dart';
import 'package:shopping_for_friends/constants/formatter.dart';

class PreviewHeader extends StatelessWidget {
  final bool finishedList;
  final IconData icon;
  final String text;
  final int total;
  final VoidCallback onChatTap;

  const PreviewHeader({
    Key key,
    @required this.finishedList,
    @required this.icon,
    @required this.text,
    @required this.total,
    @required this.onChatTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return finishedList
        ? Row(
            children: <Widget>[
              Icon(
                this.icon,
                color: AppColors.cornflower_blue,
              ),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Text(
                  this.text,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(
                Formatter.currency.format(this.total),
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 18,
                  color: Colors.white,
                ),
              )
            ],
          )
        : Row(
            children: <Widget>[
              Icon(
                this.icon,
                color: AppColors.cornflower_blue,
              ),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Text(
                  this.text,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(
                Formatter.currency.format(this.total),
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 18,
                  color: Colors.white,
                ),
              )
            ],
          );
  }
}
