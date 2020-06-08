import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_for_friends/constants/colors.dart';
import 'package:shopping_for_friends/constants/formatter.dart';
import 'package:shopping_for_friends/models/friend_list.dart';
import 'package:shopping_for_friends/models/product.dart';
import 'package:shopping_for_friends/other/s_f_f_line_awesome_icons.dart';
import 'package:shopping_for_friends/providers/content_provider.dart';
import 'package:shopping_for_friends/screens/chat.dart';
import 'package:shopping_for_friends/screens/main_container.dart';
import 'package:shopping_for_friends/widgets/components/preview_header.dart';
import 'package:shopping_for_friends/widgets/components/preview_item.dart';

class Checkout extends StatefulWidget {
  final ContentProvider contentNotifier;

  Checkout({Key key, @required this.contentNotifier}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  List<Widget> _items = [];

  @override
  void initState() {
    super.initState();
    _initList();
  }

  @override
  Widget build(BuildContext context) {
    print("checkout: ${widget.contentNotifier.hashCode}");
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      itemBuilder: (_, index) {
        return _items[index];
      },
      itemCount: _items.length,
    );
  }

  _initList() {
    _items.add(PreviewHeader(
      finishedList: false,
      icon: SFFLineAwesome.user,
      text: "afd",
      total: widget.contentNotifier.listTotal,
      onChatTap: () {},
    ));
    for (Product item in widget.contentNotifier.myList) {
      _items.add(PreviewTile(product: item));
    }
    if (widget.contentNotifier.selectedFriends != 0) {
      for (FriendList friendList in widget.contentNotifier.friendsLists) {
        if (widget.contentNotifier.isSelected(friendList.uid)) {
          _items.add(PreviewHeader(
            finishedList: widget.contentNotifier.isFinished,
            icon: SFFLineAwesome.user_friends_solid,
            text: friendList.name,
            total: friendList.total,
            onChatTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Chat(user: null),
                ),
              );
            },
          ));
          for (Product item in friendList.list) {
            _items.add(PreviewTile(product: item));
          }
        }
      }
    }
  }
}
