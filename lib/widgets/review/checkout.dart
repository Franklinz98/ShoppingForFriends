import 'package:flutter/material.dart';
import 'package:shopping_for_friends/backend/chat.dart';
import 'package:shopping_for_friends/models/friend_list.dart';
import 'package:shopping_for_friends/models/product.dart';
import 'package:shopping_for_friends/other/s_f_f_line_awesome_icons.dart';
import 'package:shopping_for_friends/providers/content_provider.dart';
import 'package:shopping_for_friends/screens/chat.dart';
import 'package:shopping_for_friends/widgets/components/checkout_item.dart';
import 'package:shopping_for_friends/widgets/components/preview_header.dart';
import 'package:shopping_for_friends/widgets/components/preview_item.dart';

class Checkout extends StatefulWidget {
  final ContentProvider contentNotifier;

  Checkout({Key key, @required this.contentNotifier}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  List<Widget> _items;

  @override
  void initState() {
    super.initState();
    _items = [];
    print(widget.contentNotifier.user.name);
  }

  @override
  Widget build(BuildContext context) {
    _items.clear();

    return FutureBuilder<List<String>>(
      future: getChatRooms(widget.contentNotifier.user.uid),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            List<String> chatRooms = snapshot.data;
            _getMyList();
            _getFriendList(chatRooms);
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              itemBuilder: (_, index) {
                return _items[index];
              },
              itemCount: _items.length,
            );
          } else {
            return Center(
              child: Text("error"),
            );
          }
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  _getMyList() {
    if (widget.contentNotifier.myList.isNotEmpty) {
      _items.add(PreviewHeader(
        finishedList: widget.contentNotifier.isFinished,
        icon: SFFLineAwesome.user,
        text: widget.contentNotifier.user.name,
        total: widget.contentNotifier.listTotal,
        onChatTap: null,
      ));
      for (Product item in widget.contentNotifier.myList) {
        _items.add(widget.contentNotifier.isFinished
            ? CheckoutTile(
                product: item,
                onTap: () => widget.contentNotifier.purchaseProduct(item))
            : PreviewTile(product: item));
      }
    }
  }

  _getFriendList(List<String> chatRooms) {
    if (widget.contentNotifier.selectedFriends != 0) {
      widget.contentNotifier.friendsLists.forEach((friendList) {
        if (friendList.checked) {
          String chatRoomId = "";
          chatRooms.forEach((chatRoom) {
            if (chatRoom.contains(friendList.uid)) {
              chatRoomId = chatRoom;
            }
          });
          if (chatRoomId.isEmpty) {
            List<String> uids = [
              widget.contentNotifier.user.uid,
              friendList.uid
            ];
            uids.sort();
            String chatRoomId =
                uids.reduce((value, element) => "${value}_$element");
            createChatRoom(
                chatRoomId,
                [widget.contentNotifier.user.uid, friendList.uid],
                [widget.contentNotifier.user.name, friendList.name]);
          }
          _items.add(PreviewHeader(
            finishedList: widget.contentNotifier.isFinished,
            icon: SFFLineAwesome.user_friends_solid,
            text: friendList.name,
            total: friendList.total,
            onChatTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Chat(
                    user: widget.contentNotifier.user,
                    friendName: friendList.name,
                    chatRoomId: chatRoomId,
                  ),
                ),
              );
            },
          ));
          for (Product item in friendList.list) {
            _items.add(widget.contentNotifier.isFinished
                ? CheckoutTile(
                    product: item,
                    onTap: () => widget.contentNotifier.purchaseProduct(item))
                : PreviewTile(product: item));
          }
        }
      });
    }
  }
}
