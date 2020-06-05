import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_for_friends/constants/colors.dart';

class FilterChipWidget extends StatefulWidget {
  final String text;
  final ValueChanged<bool> onTap;

  const FilterChipWidget({
    Key key,
    @required this.text,
    @required this.onTap,
  }) : super(key: key);

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  bool _selected;

  @override
  void initState() {
    super.initState();
    _selected = true;
  }

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.text),
      labelStyle: GoogleFonts.roboto(
        fontSize: 14,
        color: Colors.white,
      ),
      checkmarkColor: Colors.white,
      backgroundColor: AppColors.cornflower_blue,
      selectedColor: AppColors.light_slate_blue,
      onSelected: (isSelected) {
        setState(() {
          _selected = isSelected;
        });
        widget.onTap.call(_selected);
      },
      selected: _selected,
    );
  }
}
