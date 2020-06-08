import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shopping_for_friends/providers/content_provider.dart';
import 'package:shopping_for_friends/widgets/auth/change_password.dart';
import 'package:shopping_for_friends/widgets/auth/login.dart';
import 'package:shopping_for_friends/widgets/auth/signup.dart';

class AuthContainer extends StatefulWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final ContentProvider contentProvider;

  AuthContainer({Key key, @required this.contentProvider}) : super(key: key);

  @override
  _AuthContainerState createState() => _AuthContainerState();
}

class _AuthContainerState extends State<AuthContainer> {
  Widget content;

  void _updateView(int k) {
    setState(() {
      switch (k) {
        case 1:
          content = SignUp(
            contentProvider: widget.contentProvider,
            onLoginShow: () {
              _updateView(0);
            },
            onBackPressed: () {
              _updateView(0);
            },
          );
          break;
        case 2:
          content = ForgottenPassword(
            onLoginShow: () {
              _updateView(0);
            },
            onBackPressed: () {
              _updateView(0);
            },
          );
          break;
        default:
          content = Login(
            contentProvider: widget.contentProvider,
            onSignUpShow: () {
              _updateView(1);
            },
            onForgottenShow: () {
              _updateView(2);
            },
          );
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _updateView(0);
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500), child: content),
        ),
      ),
    );
  }
}
