import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_for_friends/constants/colors.dart';
import 'package:shopping_for_friends/providers/content_provider.dart';
import 'package:shopping_for_friends/screens/auth_container.dart';

class ShoppingForFriendsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    final ContentProvider contentProvider = ContentProvider();
    return MaterialApp(
      title: 'Shopping For Friends',
      theme: ThemeData(
          primaryColor: AppColors.cornflower_blue,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: AppColors.cornflower_blue,
          ),
          scaffoldBackgroundColor: AppColors.tuna),
      /* home: ChangeNotifierProvider(
        create: (context) => contentProvider,
        child: MainContainer(
          contentProvider: contentProvider,
        ),
      ), */
      home: AuthContainer(
        contentProvider: contentProvider,
      ),
    );
  }
}
