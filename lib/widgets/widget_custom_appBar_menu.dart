import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarMenuItem {
  final String value;
  final String label;
  final IconData icon;
  final Function(BuildContext)? onSelected;

  AppBarMenuItem({
    required this.value,
    required this.label,
    required this.icon,
    this.onSelected,
  });
}

class CustomAppBarMenu extends StatelessWidget {
  final List<AppBarMenuItem> items;
  final Color? iconColor;
  final Color? menuColor;
  final Color? textColor;
  final Color? iconItemColor;

  const CustomAppBarMenu({
    Key? key,
    required this.items,
    this.iconColor,
    this.menuColor,
    this.textColor,
    this.iconItemColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      color: menuColor,
      iconColor: iconColor,
      icon: const Icon(FontAwesomeIcons.ellipsisVertical),
      onSelected: (value) {
        final selectedItem = items.firstWhere((item) => item.value == value);
        if (selectedItem.onSelected != null) {
          selectedItem.onSelected!(context);
        }
      },
      itemBuilder: (BuildContext context) {
        return items.map((item) {
          return PopupMenuItem<String>(
            value: item.value,
            child: Row(
              children: [
                Icon(
                  item.icon,
                  size: 20,
                  color: iconItemColor,
                ),
                const SizedBox(width: 8),
                Text(
                  item.label,
                  style: GoogleFonts.poppins(
                    color: textColor,
                  ),
                ),
              ],
            ),
          );
        }).toList();
      },
    );
  }
}
