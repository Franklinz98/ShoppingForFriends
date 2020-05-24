import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shopping_for_friends/constants/colors.dart';
import 'package:shopping_for_friends/models/product.dart';
import 'package:shopping_for_friends/providers/content_provider.dart';
import 'package:shopping_for_friends/screens/product_search.dart';
import 'package:shopping_for_friends/widgets/components/dismissible_background.dart';
import 'package:shopping_for_friends/widgets/components/draft_item.dart';
import 'package:shopping_for_friends/widgets/components/input.dart';

class DraftList extends StatefulWidget {
  final copFormatter =
      NumberFormat.currency(name: "COP", symbol: "\$", decimalDigits: 0);
  final ContentProvider contentNotifier;

  DraftList({Key key, @required this.contentNotifier}) : super(key: key);

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
              if (index != widget.contentNotifier.length) {
                Product product = widget.contentNotifier.myList[index];
                return DraftTile(
                  product: product,
                  formatter: widget.copFormatter,
                  onDismissed: (direction) {
                    setState(() {
                      widget.contentNotifier.removeProduct(index);
                    });
                  },
                  onMinusPressed: () {
                    setState(() {
                      product.removeUnit();
                    });
                  },
                  onPlusPressed: () {
                    setState(() {
                      product.addUnit();
                    });
                  },
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: FloatingActionButton(
                    heroTag: 'Add Product',
                    child: Icon(
                      Icons.add,
                    ),
                    mini: true,
                    onPressed: () {
                      _navigateAndDisplaySelection(context);
                    },
                    elevation: 0,
                  ),
                );
              }
            },
            itemCount: widget.contentNotifier.length + 1,
          ),
        ),
      ],
    );
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchScreen()),
    );
    if (result != null) {
      setState(() {
        widget.contentNotifier.addProduct(result);
      });
    }
  }
}
