import 'dart:math';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shopping_for_friends/constants/colors.dart';
import 'package:shopping_for_friends/models/product.dart';
import 'package:shopping_for_friends/widgets/components/dismissible_background.dart';
import 'package:shopping_for_friends/widgets/components/input.dart';

class DraftList extends StatefulWidget {
  final List<Product> items = List<Product>.generate(
    12,
    (i) => Product(
        name: "Producto $i", price: Random().nextInt(20000), quantity: 1),
  );
  @override
  _DraftListState createState() => _DraftListState();
}

class _DraftListState extends State<DraftList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Text(
            "Lista",
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            itemBuilder: (_, index) {
              if (index != widget.items.length) {
                Product product = widget.items[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      setState(() {
                        widget.items.removeAt(index);
                      });
                    },
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
                                "\$ ${product.price} c/u",
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
                                  "\$ ${product.price * product.quantity}",
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
                                onPressed: () {
                                  setState(() {
                                    product.removeUnit();
                                  });
                                },
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
                                onPressed: () {
                                  setState(() {
                                    product.addUnit();
                                  });
                                },
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
              } else {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: FloatingActionButton(
                    child: Icon(
                      Icons.add,
                    ),
                    mini: true,
                    onPressed: () {},
                    elevation: 0,
                  ),
                );
              }
            },
            itemCount: widget.items.length + 1,
          ),
        ),
      ],
    );
  }
}
