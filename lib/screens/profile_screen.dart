import 'package:flutter/material.dart';
import 'package:generation_stars/screens/lengkapi_profile_screen.dart';
import 'package:generation_stars/utils/colors.dart';
import 'package:generation_stars/shared/shared_appbar.dart'; // Pastikan import AppColors

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: SharedAppbar(title: 'Profil Saya'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/ibu_hamil.png'),
                    backgroundColor: Colors.grey[300],
                  ),
                  // Positioned(
                  //   bottom: 0,
                  //   right: 4,
                  //   child: Container(
                  //     padding: EdgeInsets.all(6),
                  //     decoration: BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       color: AppColors.button,
                  //     ),
                  //     child: Icon(
                  //       Icons.edit,
                  //       size: 20,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Nama
            Text(
              'Nama Pengguna',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.heading,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'email@example.com',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.subtext.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 30),

            // Info Section
            _buildProfileInfo('Nomor Telepon', '+62 812 3456 7890'),
            _buildProfileInfo('Alamat', 'Jl. Contoh No. 123, Jakarta'),
            _buildProfileInfo('Tanggal Lahir', '12 Januari 1990'),
            const SizedBox(height: 30),

            // Button Edit Profil
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LengkapiProfileScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.button,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Edit Profil',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: TextStyle(
                color: AppColors.subtext.withOpacity(0.8),
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: TextStyle(
                color: AppColors.heading,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
