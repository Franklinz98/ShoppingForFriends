import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_for_friends/app/app.dart';

import 'constants/colors.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: AppColors.charade,
      statusBarBrightness: Brightness.dark
    )
  );
  runApp(ShoppingForFriendsApp());
}
