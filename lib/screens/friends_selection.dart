import 'dart:collection';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_for_friends/backend/shopping_list.dart';
import 'package:shopping_for_friends/constants/colors.dart';
import 'package:shopping_for_friends/constants/formatter.dart';
import 'package:shopping_for_friends/models/friend_list.dart';
import 'package:shopping_for_friends/providers/content_provider.dart';
import 'package:shopping_for_friends/widgets/components/friend_selection_item.dart';

class FriendSelection extends StatefulWidget {
  final ContentProvider contentNotifier;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  FriendSelection({Key key, @required this.contentNotifier}) : super(key: key);

  @override
  _FriendSelectionState createState() => _FriendSelectionState();
}

class _FriendSelectionState extends State<FriendSelection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey,
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
              child: StreamBuilder<QuerySnapshot>(
                stream: getPublicShoppingLists(),
                builder: (context, snapshot) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      widget.contentNotifier.resetFriendLists();
                      return ListView(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 8.0),
                        children: snapshot.data.documents
                            .map((DocumentSnapshot listMap) {
                          print(listMap.data.runtimeType);
                          FriendList friendList =
                              FriendList.fromMap(listMap.data);
                          friendList.checked =
                              widget.contentNotifier.isSelected(friendList.uid);
                          widget.contentNotifier.addFriendList(friendList);
                          return FriendSelectionTile(
                            friendList: friendList,
                            formatter: Formatter.currency,
                            onTap: () {
                              if (friendList.uid !=
                                  widget.contentNotifier.user.uid) {
                                if (!widget.contentNotifier.isFinished) {
                                  widget.contentNotifier
                                      .switchFriendListState(friendList);
                                } else {
                                  widget._scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "No puedes hacer esto, finalizaste la lista...")));
                                }
                              } else {
                                widget._scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "No puedes seleccionar tu lista")));
                              }
                            },
                          );
                        }).toList(),
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
