import 'package:flutter/material.dart';
import 'package:shopping_for_friends/backend/shopping_list.dart';
import 'package:shopping_for_friends/constants/formatter.dart';
import 'package:shopping_for_friends/models/product.dart';
import 'package:shopping_for_friends/providers/content_provider.dart';
import 'package:shopping_for_friends/screens/product_search.dart';
import 'package:shopping_for_friends/widgets/components/draft_item.dart';

class DraftList extends StatefulWidget {
  final ContentProvider contentNotifier;

  DraftList({Key key, @required this.contentNotifier}) : super(key: key);

  @override
  _DraftListState createState() => _DraftListState();
}

class _DraftListState extends State<DraftList> {
  @override
  Widget build(BuildContext context) {
    return widget.contentNotifier.isFinished
        // TODO add finished list decoration
        ? Center(
            child: Text(
              "La lista ya no se puede modificar",
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          )
        : ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            itemBuilder: (_, index) {
              if (index != widget.contentNotifier.length) {
                Product product = widget.contentNotifier.myList[index];
                return DraftTile(
                  product: product,
                  formatter: Formatter.currency,
                  onDismissed: (direction) {
                    widget.contentNotifier.removeProduct(index);
                    _updateRemoteList();
                  },
                  onMinusPressed: () {
                    widget.contentNotifier.removeUnit(index);
                    _updateRemoteList();
                  },
                  onPlusPressed: () {
                    widget.contentNotifier.addUnit(index);
                    _updateRemoteList();
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
          );
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    _initRemoteList();
    Product result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchScreen()),
    );
    if (result != null) {
      bool isAdded = false;
      int productIndex;
      widget.contentNotifier.myList.forEach((product) {
        if (product.name == result.name) {
          isAdded = true;
          productIndex = widget.contentNotifier.myList.indexOf(product);
        }
      });
      if (isAdded) {
        widget.contentNotifier.addUnit(productIndex);
      } else {
        widget.contentNotifier.addProduct(result);
      }
      _updateRemoteList();
    }
  }

  _initRemoteList() async {
    String _uid = widget.contentNotifier.user.uid;
    bool _userHasList = await userHasList(_uid);
    if (!_userHasList) {
      createShoppingList(_uid, {});
    }
  }

  _updateRemoteList() async {
    String _uid = widget.contentNotifier.user.uid;
    await updateList(_uid, widget.contentNotifier.myListToMap());
  }
}
