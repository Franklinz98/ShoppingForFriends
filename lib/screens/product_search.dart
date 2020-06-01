import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shopping_for_friends/constants/colors.dart';
import 'package:shopping_for_friends/constants/formatter.dart';
import 'package:shopping_for_friends/models/product.dart';
import 'package:shopping_for_friends/other/s_f_f_line_awesome_icons.dart';
import 'package:shopping_for_friends/widgets/components/input.dart';
import 'package:shopping_for_friends/widgets/components/search_item.dart';

class SearchScreen extends StatefulWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Product> items = List<Product>.generate(
    12,
    (i) => Product(
        name: "Producto $i", price: Random().nextInt(20000), quantity: 1),
  );
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: AppColors.cornflower_blue,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    "Añadir Producto",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Input(
                validator: (value) {},
                controller: null,
                hintText: "Nombre del producto",
                icon: Icon(
                  SFFLineAwesome.search_solid,
                  color: AppColors.cornflower_blue,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                itemBuilder: (_, index) {
                  Product product = widget.items[index];
                  return SearchTile(
                    product: product,
                    formatter: Formatter.currency,
                    onTap: () {
                      Navigator.pop(context, product);
                    },
                  );
                },
                itemCount: widget.items.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
