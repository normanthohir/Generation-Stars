import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generation_stars/screens/authentication/login_screen.dart';
import 'package:generation_stars/screens/edit_profile_screen.dart';
import 'package:generation_stars/screens/lengkapi_profile_screen.dart';
import 'package:generation_stars/services/authentication_service.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:generation_stars/shared/shared_appbar.dart';
import 'package:generation_stars/widgets/widget_custom_appBar_menu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Pastikan import AppColors

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final auth = AuthService();
  final Map<String, dynamic> userData = {
    'name': 'Nurul Indah',
    'email': 'nurul.indah@example.com',
    'photoUrl': 'assets/images/person.jpg',
    'birthDate': DateTime(1995, 5, 15),
    'pregnancyDate': DateTime(2025, 1, 1),
    'height': 165,
    'weight': 62,
    'address': 'Jl. Melati No. 12, Jakarta',
    'isProfileComplete': true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.white,
      appBar: SharedAppbar(
        title: 'Profil Saya',
        actions: [
          CustomAppBarMenu(
            iconItemColor: ColorsApp.hijauTua,
            textColor: ColorsApp.hijauTua,
            menuColor: ColorsApp.white,
            items: [
              AppBarMenuItem(
                value: 'Edit Profile',
                label: ' Edit profil',
                icon: FontAwesomeIcons.userEdit,
                onSelected: (context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(
                        initialData: {
                          'name': userData['name'],
                          'email': userData['email'],
                          'photoUrl': userData['photoUrl'],
                          'birthDate': userData['birthDate'],
                          'pregnancyDate': userData['pregnancyDate'],
                          'height': userData['height'],
                          'weight': userData['weight'],
                          'address': userData['address'],
                        },
                      ),
                    ),
                  );
                },
              ),
              AppBarMenuItem(
                value: 'Keluar akun',
                label: ' keluar akun',
                icon: FontAwesomeIcons.rightFromBracket,
                onSelected: (context) async {
                  await auth.logOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false,
                  );
                },
              ),
            ],
            iconColor: ColorsApp.black,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorsApp.hijau.withOpacity(0.6),
                        width: 3,
                      ),
                      shape: BoxShape.circle,
                      color: ColorsApp.hijau.withOpacity(0.2),
                      image: DecorationImage(
                        image: userData['photoUrl'] != null
                            ? AssetImage(userData['photoUrl'])
                            : AssetImage('assets/images/no_profile.jpg')
                                as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: ColorsApp.hijau.withOpacity(0.6)),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: ColorsApp.hijau.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.person,
                        color: ColorsApp.hijau,
                        size: 24,
                      ),
                      title: Text(
                        'Nama',
                        style: GoogleFonts.poppins(color: ColorsApp.text),
                      ),
                      subtitle: Text(
                        userData['name'],
                        style: GoogleFonts.poppins(color: ColorsApp.hijauTua),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.email,
                        color: ColorsApp.hijau,
                        size: 24,
                      ),
                      title: Text(
                        'Email',
                        style: GoogleFonts.poppins(color: ColorsApp.text),
                      ),
                      subtitle: Text(
                        userData['email'],
                        style: GoogleFonts.poppins(color: ColorsApp.hijauTua),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30),

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: ColorsApp.hijau.withOpacity(0.6)),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: ColorsApp.hijau.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Informasi Kehamilan & Kesehatan',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorsApp.hijauTua,
                      ),
                    ),
                    SizedBox(height: 12),
                    _buildInfoRow(
                      icon: Icons.cake,
                      label: 'Tanggal Lahir',
                      value: DateFormat('dd MMMM yyyy')
                          .format(userData['birthDate']),
                    ),
                    Divider(),
                    _buildInfoRow(
                      icon: Icons.child_friendly,
                      label: 'Tanggal Awal Kehamilan',
                      value: userData['pregnancyDate'] != null
                          ? DateFormat('dd MMMM yyyy')
                              .format(userData['pregnancyDate'])
                          : 'Belum diisi',
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoRow(
                            icon: Icons.height,
                            label: 'Tinggi Badan',
                            value: '${userData['height']} cm',
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: Colors.grey[300],
                        ),
                        Expanded(
                          child: _buildInfoRow(
                            icon: Icons.monitor_weight,
                            label: 'Berat Badan',
                            value: '${userData['weight']} kg',
                          ),
                        ),
                      ],
                    ),
                    if (userData['pregnancyDate'] != null) ...[
                      SizedBox(height: 16),
                      LinearProgressIndicator(
                        value: _calculatePregnancyProgress(),
                        backgroundColor: Colors.grey[350],
                        color: ColorsApp.hijau,
                        minHeight: 10,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Usia Kehamilan: ${_calculatePregnancyWeek()} minggu',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: ColorsApp.black,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: ColorsApp.hijau.withOpacity(0.6)),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: ColorsApp.hijau.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alamat',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorsApp.hijauTua,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      userData['address'] ?? 'Belum diisi',
                      style: TextStyle(fontSize: 14, color: ColorsApp.text),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: ColorsApp.hijau),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: ColorsApp.black,
                ),
              ),
              SizedBox(height: 2),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ColorsApp.hijauTua,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper Functions
  double _calculatePregnancyProgress() {
    final startDate = userData['pregnancyDate'];
    final totalDays = DateTime.now().difference(startDate).inDays;
    return (totalDays / 280).clamp(0.0, 1.0); // 280 hari = 40 minggu
  }

  String _calculatePregnancyWeek() {
    final startDate = userData['pregnancyDate'];
    final weeks = DateTime.now().difference(startDate).inDays ~/ 7;
    return weeks.toString();
  }
}
