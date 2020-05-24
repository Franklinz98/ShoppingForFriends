import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shopping_for_friends/constants/colors.dart';
import 'package:shopping_for_friends/models/product.dart';

import 'dismissible_background.dart';

class DraftTile extends StatelessWidget {
  final Product product;
  final NumberFormat formatter;
  final DismissDirectionCallback onDismissed;
  final VoidCallback onMinusPressed;
  final VoidCallback onPlusPressed;

  const DraftTile({
    Key key,
    @required this.product,
    @required this.formatter,
    @required this.onDismissed,
    @required this.onMinusPressed,
    @required this.onPlusPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: this.onDismissed,
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: AppColors.gun_powder,
            borderRadius: BorderRadius.circular(4.00),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      product.name,
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    "${formatter.format(product.price)} c/u",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 14,
                      color: Color(0xffa8a8af),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Total",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color(0xffa8a8af),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: Text(
                      "${formatter.format(product.price * product.quantity)}",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 14,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      LineIcons.minus_circle,
                      color: AppColors.cornflower_blue,
                    ),
                    onPressed: this.onMinusPressed,
                  ),
                  Container(
                    height: 32.00,
                    width: 85.00,
                    decoration: BoxDecoration(
                      color: Color(0xff343542),
                      borderRadius: BorderRadius.circular(4.00),
                    ),
                    child: Center(
                      child: Text(
                        product.quantity.toString(),
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 14,
                          color: Color(0xffa8a8af),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      LineIcons.plus_circle,
                      color: AppColors.cornflower_blue,
                    ),
                    onPressed: this.onPlusPressed,
                  ),
                ],
              ),
            ],
          ),
        ),
        background: DismissibleBackground(alignment: -1.0),
        secondaryBackground: DismissibleBackground(alignment: 1.0),
      ),
    );
  }
}
