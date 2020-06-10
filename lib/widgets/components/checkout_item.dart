import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shopping_for_friends/constants/colors.dart';
import 'package:shopping_for_friends/models/friend_list.dart';
import 'package:shopping_for_friends/models/product.dart';
import 'package:shopping_for_friends/other/s_f_f_line_awesome_icons.dart';

class CheckoutTile extends StatelessWidget {
  final Product product;
  final GestureTapCallback onTap;

  const CheckoutTile({
    Key key,
    @required this.product,
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
            this.product.name.toUpperCase(),
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          trailing: IconButton(
              icon: Icon(
                SFFLineAwesome.check_circle,
                color: product.purchased
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
