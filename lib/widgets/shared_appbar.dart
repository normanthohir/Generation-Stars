import 'package:flutter/material.dart';
import 'package:generation_stars/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class SharedAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final String title;
  final List<Widget>? actions;

  const SharedAppbar({
    super.key,
    this.leading,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.background,
      leading: leading,
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: AppColors.heading,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
