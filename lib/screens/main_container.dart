import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:shopping_for_friends/constants/colors.dart';
import 'package:shopping_for_friends/providers/content_provider.dart';
import 'package:shopping_for_friends/widgets/draft/draft.dart';

class MainContainer extends StatefulWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
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
      heroTag: 'Show Friends',
      onPressed: () {},
      child: Icon(Icons.group),
    );
    _selectedScreen = SelectedScreen.edit;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: widget._scaffoldKey,
        body: Consumer<ContentProvider>(
          builder: (context, contentNotifier, child) {
            return DraftList(
              contentNotifier: contentNotifier,
            );
          },
        ),
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
                  onPressed: () {
                    setState(() {
                      _selectedScreen = SelectedScreen.edit;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    LineIcons.list_alt,
                    color: _selectedScreen == SelectedScreen.preview
                        ? AppColors.cornflower_blue
                        : Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedScreen = SelectedScreen.preview;
                    });
                  },
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
