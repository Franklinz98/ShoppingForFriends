import 'package:flutter/material.dart';
import 'package:shopping_for_friends/constants/colors.dart';
import 'package:shopping_for_friends/screens/main_container.dart';

class ShoppingForFriendsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping For Friends',
      theme: ThemeData(
        primaryColor: AppColors.cornflower_blue,
      ),
      home: MainContainer(),
    );
  }
}
