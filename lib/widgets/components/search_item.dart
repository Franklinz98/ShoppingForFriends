import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shopping_for_friends/constants/colors.dart';
import 'package:shopping_for_friends/models/product.dart';

class SearchTile extends StatelessWidget {
  final Product product;
  final NumberFormat formatter;
  final GestureTapCallback onTap;

  const SearchTile({
    Key key,
    @required this.product,
    @required this.formatter,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.gun_powder,
          borderRadius: BorderRadius.circular(4.00),
        ),
        child: ListTile(
          dense: true,
          title: Text(
            this.product.name,
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                LineIcons.tags,
                color: AppColors.cornflower_blue,
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(
                "${formatter.format(this.product.price)} c/u",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 14,
                  color: Color(0xffa8a8af),
                ),
              ),
            ],
          ),
          onTap: this.onTap,
        ),
      ),
    );
  }
}
