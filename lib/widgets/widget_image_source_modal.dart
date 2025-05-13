import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageSourceModal extends StatelessWidget {
  final VoidCallback onCameraSelected;
  final VoidCallback onGallerySelected;

  ImageSourceModal({
    Key? key,
    required this.onCameraSelected,
    required this.onGallerySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: ColorsApp.hijau,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Pilih Sumber Gambar',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.background,
            ),
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildOption(
                icon: FontAwesomeIcons.camera,
                label: 'Kamera',
                onTap: () {
                  Navigator.pop(context);
                  onCameraSelected();
                },
              ),
              _buildOption(
                icon: FontAwesomeIcons.solidImages,
                label: 'Galeri',
                onTap: () {
                  Navigator.pop(context);
                  onGallerySelected();
                },
              ),
            ],
          ),
          SizedBox(height: 13),
        ],
      ),
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        Ink(
          decoration: ShapeDecoration(
            shape: CircleBorder(),
            color: AppColors.background,
          ),
          child: IconButton(
            icon: Icon(icon, size: 37, color: AppColors.background),
            onPressed: onTap,
          ),
        ),
        SizedBox(height: 0),
        Text(
          label,
          style: GoogleFonts.poppins(
            color: AppColors.background,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
