import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shopping_for_friends/constants/colors.dart';
import 'package:shopping_for_friends/models/message.dart';

class ChatPreviewTile extends StatelessWidget {
  final String name;
  final Message message;
  final GestureTapCallback onTap;
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy - hh:mm a', 'es-CO');

  ChatPreviewTile({
    Key key,
    @required this.name,
    @required this.message,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.gun_powder,
          borderRadius: BorderRadius.circular(4.00),
        ),
        child: ListTile(
          dense: true,
          title: Text(
            this.name,
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 14,
              color: AppColors.cornflower_blue,
            ),
          ),
          trailing: Text(
            dateFormat.format(
              DateTime.fromMillisecondsSinceEpoch(this.message.millis),
            ),
            textAlign: TextAlign.right,
            style: GoogleFonts.roboto(
              fontSize: 12,
              color: AppColors.spun_pearl,
            ),
          ),
          subtitle: Text(
            this.message.message,
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          isThreeLine: true,
          onTap: this.onTap,
        ),
      ),
    );
  }
}
