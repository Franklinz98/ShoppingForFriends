import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping_for_friends/constants/colors.dart';
import 'package:shopping_for_friends/models/friend_list.dart';
import 'package:shopping_for_friends/providers/content_provider.dart';
import 'package:shopping_for_friends/widgets/components/friend_selection_item.dart';

class FriendSelection extends StatefulWidget {
  final copFormatter =
      NumberFormat.currency(name: "COP", symbol: "\$", decimalDigits: 0);
  final ContentProvider contentNotifier;

  FriendSelection({Key key, @required this.contentNotifier}) : super(key: key);

  @override
  _FriendSelectionState createState() => _FriendSelectionState();
}

class _FriendSelectionState extends State<FriendSelection> {
  @override
  void initState() {
    super.initState();
    widget.contentNotifier.resetFriendLists();
    final List<FriendList> items = List<FriendList>.generate(
      7,
      (i) => FriendList(
        name: "Amigo $i",
        uid: "UID$i",
        total: Random().nextInt(90000),
        list: UnmodifiableListView([]),
        checked: widget.contentNotifier.isSelected("UID$i"),
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.contentNotifier.addFriendLists(items);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                    "Amigos",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                itemBuilder: (_, index) {
                  FriendList friendList =
                      widget.contentNotifier.friendsLists[index];
                  return FriendSelectionTile(
                    friendList: friendList,
                    formatter: widget.copFormatter,
                    onTap: () {
                      widget.contentNotifier.switchFriendListState(friendList);
                    },
                  );
                },
                itemCount: widget.contentNotifier.friendsLength,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
