import 'package:flutter/material.dart';
import 'package:shopping_for_friends/constants/colors.dart';
import 'package:shopping_for_friends/models/product.dart';
import 'package:shopping_for_friends/other/s_f_f_line_awesome_icons.dart';

class PreviewTile extends StatelessWidget {
  final Product product;

  const PreviewTile({
    Key key,
    @required this.product,
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
            this.product.name.toUpperCase(),
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
                SFFLineAwesome.dolly_solid,
                color: AppColors.cornflower_blue,
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(
                product.quantity.toString(),
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 14,
                  color: Color(0xffa8a8af),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
