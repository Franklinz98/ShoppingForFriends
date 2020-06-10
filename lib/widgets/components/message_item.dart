import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shopping_for_friends/constants/colors.dart';
import 'package:shopping_for_friends/constants/enums.dart';
import 'package:shopping_for_friends/models/message.dart';

class MessageTile extends StatelessWidget {
  final Message message;
  final MessageType type;
  final DateFormat dateFormat = DateFormat('dd MMMM yyyy - hh:mm a', 'es-CO');

  MessageTile({
    Key key,
    @required this.type,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: type == MessageType.local
          ? Row(
              children: <Widget>[
                Spacer(
                  flex: 1,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: AppColors.cornflower_blue.withOpacity(0.25),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4.00),
                        bottomLeft: Radius.circular(4.00),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          "Yo",
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: AppColors.cornflower_blue,
                          ),
                        ),
                        Text(
                          dateFormat.format(
                            DateTime.fromMillisecondsSinceEpoch(
                                this.message.millis),
                          ),
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            color: AppColors.spun_pearl,
                          ),
                        ),
                        Text(
                          this.message.message,
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: AppColors.light_slate_blue.withOpacity(0.25),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4.00),
                        bottomLeft: Radius.circular(4.00),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          this.message.name,
                          textAlign: TextAlign.right,
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: AppColors.light_slate_blue,
                          ),
                        ),
                        Text(
                          dateFormat.format(
                            DateTime.fromMillisecondsSinceEpoch(
                                this.message.millis),
                          ),
                          textAlign: TextAlign.right,
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            color: AppColors.spun_pearl,
                          ),
                        ),
                        Text(
                          this.message.message,
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
              ],
            ),
    );
  }
}
