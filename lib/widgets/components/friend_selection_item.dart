import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shopping_for_friends/constants/colors.dart';
import 'package:shopping_for_friends/models/friend_list.dart';

class FriendSelectionTile extends StatelessWidget {
  final FriendList friendList;
  final NumberFormat formatter;
  final GestureTapCallback onTap;

  const FriendSelectionTile({
    Key key,
    @required this.friendList,
    @required this.formatter,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          color: AppColors.gun_powder,
          borderRadius: BorderRadius.circular(4.00),
        ),
        child: ListTile(
          dense: true,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                friendList.name,
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    LineIcons.tags,
                    color: AppColors.cornflower_blue,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    formatter.format(friendList.total),
                    textAlign: TextAlign.right,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: AppColors.spun_pearl,
                    ),
                  ),
                ],
              ),
            ],
          ),
          trailing: IconButton(
              icon: Icon(
                LineIcons.check_circle,
                color: friendList.checked
                    ? AppColors.cornflower_blue
                    : AppColors.tuna,
              ),
              onPressed: this.onTap),
          onTap: this.onTap,
        ),
      ),
    );
  }
}
