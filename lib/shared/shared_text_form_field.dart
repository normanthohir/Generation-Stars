import 'package:flutter/material.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class SharedTextFormField extends StatelessWidget {
  final TextEditingController Controller;
  final String labelText;
  final bool readOnly;
  final VoidCallback? onTap;
  final bool obsecureText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;

  const SharedTextFormField({
    super.key,
    required this.Controller,
    required this.labelText,
    this.readOnly = false,
    this.onTap,
    this.obsecureText = false,
    this.validator,
    this.suffixIcon,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          cursorColor: ColorsApp.text,
          style: GoogleFonts.poppins(color: ColorsApp.text),
          obscureText: obsecureText,
          controller: Controller,
          readOnly: readOnly,
          onTap: onTap,
          validator: validator,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 17),
            floatingLabelStyle: GoogleFonts.poppins(color: ColorsApp.text),
            labelText: labelText,
            labelStyle: GoogleFonts.poppins(color: ColorsApp.text),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Colors.transparent,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  BorderSide(color: ColorsApp.text.withOpacity(0.5), width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  BorderSide(color: ColorsApp.text.withOpacity(0.6), width: 2),
            ),
            focusColor: ColorsApp.hijau,
          ),
        ),
      ],
    );
  }
}
