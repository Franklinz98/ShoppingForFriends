import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shopping_for_friends/constants/colors.dart';

class MainContainer extends StatefulWidget {
  @override
  _MainContainerState createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  Widget _fab;
  SelectedScreen _selectedScreen;

  @override
  void initState() {
    super.initState();
    _fab = FloatingActionButton(
      onPressed: () {},
      child: Icon(Icons.group),
    );
    _selectedScreen = SelectedScreen.edit;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.tuna,
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
                    LineIcons.plus_circle,
                    color: _selectedScreen == SelectedScreen.edit
                        ? AppColors.cornflower_blue
                        : Colors.white,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    LineIcons.list_alt,
                    color: _selectedScreen == SelectedScreen.preview
                        ? AppColors.cornflower_blue
                        : Colors.white,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum SelectedScreen { edit, preview }
