import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_for_friends/constants/colors.dart';
import 'package:shopping_for_friends/widgets/auth/change_password.dart';
import 'package:shopping_for_friends/widgets/auth/login.dart';
import 'package:shopping_for_friends/widgets/auth/signup.dart';
import 'package:shopping_for_friends/widgets/components/button.dart';
import 'package:shopping_for_friends/widgets/components/input.dart';
import 'package:shopping_for_friends/widgets/components/linked_text.dart';

class AuthContainer extends StatefulWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: widget._scaffoldKey,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500), child: content),
        ),
      ),
    );
  }
}
