import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class SharedAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final String title;
  final List<Widget>? actions;
  final bool ipmlayLeadingFalse;

  SharedAppbar({
    super.key,
    this.leading,
    required this.title,
    this.ipmlayLeadingFalse = false,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: ipmlayLeadingFalse,
      // systemOverlayStyle: SystemUiOverlayStyle.light,
      iconTheme: IconThemeData(
        color: AppColors.button,
      ),
      backgroundColor: ColorsApp.white,
      leading: leading,
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: ColorsApp.text,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
