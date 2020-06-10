import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_for_friends/backend/chat.dart';
import 'package:shopping_for_friends/backend/firebase_auth.dart';
import 'package:shopping_for_friends/backend/frutiland_api.dart';
import 'package:shopping_for_friends/backend/google_auth.dart';
import 'package:shopping_for_friends/backend/shopping_list.dart';
import 'package:shopping_for_friends/constants/colors.dart';
import 'package:shopping_for_friends/constants/enums.dart';
import 'package:shopping_for_friends/constants/provider.dart';
import 'package:shopping_for_friends/models/user_model.dart';
import 'package:shopping_for_friends/other/s_f_f_line_awesome_icons.dart';
import 'package:shopping_for_friends/providers/content_provider.dart';
import 'package:shopping_for_friends/screens/auth_container.dart';
import 'package:shopping_for_friends/screens/friends_selection.dart';
import 'package:shopping_for_friends/widgets/chat/chat.dart';
import 'package:shopping_for_friends/widgets/draft/draft.dart';
import 'package:shopping_for_friends/widgets/review/checkout.dart';

class MainContainer extends StatefulWidget {
  final ContentProvider contentProvider;
  final User user;
  final LoginType loginType;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  MainContainer({
    Key key,
    @required this.contentProvider,
    @required this.user,
    @required this.loginType,
  }) : super(key: key);

  @override
  _MainContainerState createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  Widget _fab;
  SelectedScreen _selectedScreen;
  Widget _content;
  Widget _draft;
  Widget _checkout;
  Widget _chat;
  String _title;

  @override
  void initState() {
    super.initState();
    widget.contentProvider.updateUser(widget.user);
    _initWidgets();
    _switchContent();
    _title = "Lista";
  }

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
                Expanded(
                  child: Text(
                    _title,
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                    icon: Icon(
                      Icons.power_settings_new,
                      color: AppColors.cornflower_blue,
                    ),
                    onPressed: _signOut),
              ],
            ),
          ),
          Expanded(child: _content),
        ],
      )),
      floatingActionButton: _fab,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        color: AppColors.charade,
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: EdgeInsets.only(right: 88.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  SFFLineAwesome.plus_circle_solid,
                  color: _selectedScreen == SelectedScreen.draft
                      ? AppColors.cornflower_blue
                      : Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _selectedScreen = SelectedScreen.draft;
                    _switchContent();
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  SFFLineAwesome.list_alt_solid,
                  color: _selectedScreen == SelectedScreen.checkout
                      ? AppColors.cornflower_blue
                      : Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _selectedScreen = SelectedScreen.checkout;
                    _switchContent();
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  SFFLineAwesome.comments,
                  color: _selectedScreen == SelectedScreen.chat
                      ? AppColors.cornflower_blue
                      : Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _selectedScreen = SelectedScreen.chat;
                    _switchContent();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _initWidgets() {
    _draft = Consumer<ContentProvider>(
      builder: (context, contentNotifier, child) {
        return DraftList(
          contentNotifier: contentNotifier,
        );
      },
    );
    _checkout = Consumer<ContentProvider>(
      builder: (context, contentNotifier, child) {
        return Checkout(
          contentNotifier: contentNotifier,
        );
      },
    );
    _chat = ChatList(user: widget.contentProvider.user);
    _selectedScreen = SelectedScreen.draft;
  }

  _switchContent() {
    switch (_selectedScreen) {
      case SelectedScreen.draft:
        _content = _draft;
        _title = "Lista";
        _fab = FloatingActionButton(
          heroTag: 'Show Friends',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ChangeNotifierProvider<ContentProvider>.value(
                  value: widget.contentProvider,
                  child: Consumer<ContentProvider>(
                    key: UniqueKey(),
                    builder: (context, contentNotifier, child) {
                      return FriendSelection(
                        contentNotifier: contentNotifier,
                      );
                    },
                  ),
                ),
              ),
            );
          },
          child: Icon(Icons.group),
        );
        break;
      case SelectedScreen.checkout:
        _content = _checkout;
        _title = "Revisión";
        if (widget.contentProvider.isFinished) {
          _fab = FloatingActionButton(
            heroTag: 'Done',
            onPressed: () {
              if (widget.contentProvider.testCheckout()) {
                _deleteList();
                setState(() {
                  _selectedScreen = SelectedScreen.draft;
                  _switchContent();
                });
              } else {
                widget._scaffoldKey.currentState.showSnackBar(
                  SnackBar(
                    content: Text(
                        "Debes confirmar la compra de todos los productos..."),
                  ),
                );
              }
            },
            child: Icon(Icons.done_all),
          );
        } else {
          _fab = FloatingActionButton(
            heroTag: 'Finish List',
            onPressed: () {
              setShoppingListPublic(widget.contentProvider.user.uid).then(
                (value) {
                  setState(
                    () {
                      widget.contentProvider.finishList();
                      _switchContent();
                    },
                  );
                },
              );
            },
            child: Icon(Icons.done),
          );
        }
        break;
      case SelectedScreen.chat:
        _content = _chat;
        _title = "Chats";
        break;
    }
  }

  _deleteList() async {
    await deteleList(widget.contentProvider.user.uid);
    widget.contentProvider.selectedFriendsUid.forEach((uid) => deteleList(uid));
    widget.contentProvider.clearMyList();
  }

  _signOut() {
    switch (widget.loginType) {
      case LoginType.google:
        signOutGoogle().then((value) {
          ProviderConstant.newContentProvider();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AuthContainer(
                contentProvider: ProviderConstant.contentProvider,
              ),
            ),
          );
        });
        break;
      case LoginType.email:
        signOutFirebase().then((value) {
          ProviderConstant.newContentProvider();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AuthContainer(
                contentProvider: ProviderConstant.contentProvider,
              ),
            ),
          );
        });
        break;
    }
  }
}
