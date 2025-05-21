import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generation_stars/screens/authentication/login_screen.dart';
import 'package:generation_stars/screens/profiles/edit_profile_screen.dart';
import 'package:generation_stars/services/authentication_service.dart';
import 'package:generation_stars/services/profile_service.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:generation_stars/shared/shared_appbar.dart';
import 'package:generation_stars/theme/effect_shimer/profile_shimer.dart';
import 'package:generation_stars/widgets/widget_custom_appBar_menu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Pastikan import AppColors

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final auth = AuthService();
  final supabase = Supabase.instance.client;
  Map<String, dynamic>?
      _profileData; // Tidak perlu lagi untuk menyimpan data secara terpisah
  late Future<Map<String, dynamic>?> _profileFture;

  @override
  void initState() {
    super.initState();
    _profileFture = UserService.getCurrentUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.white,
      appBar: SharedAppbar(
        title: 'Profil Saya',
        actions: [
          _appBarMenu(),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: FutureBuilder<Map<String, dynamic>?>(
          future: _profileFture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: ProfileShimer());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Gagal memuat profil: ${snapshot.error}'));
            } else if (snapshot.hasData && snapshot.data != null) {
              _profileData =
                  snapshot.data!; // Simpan data yang sudah ada di snapshot
              return Column(
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
                            shape: BoxShape.circle,
                            color: ColorsApp.hijau.withOpacity(0.2),
                            image: DecorationImage(
                              image: _profileData?['foto_profile'] != null
                                  ? NetworkImage(_profileData?['foto_profile'])
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
                      border:
                          Border.all(color: ColorsApp.hijau.withOpacity(0.6)),
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
                              _profileData!['nama'] ?? "Tidak ada nama",
                              style: GoogleFonts.poppins(
                                  color: ColorsApp.hijauTua),
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
                              supabase.auth.currentUser?.email ??
                                  "Tidak ada email",
                              style: GoogleFonts.poppins(
                                  color: ColorsApp.hijauTua),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: ColorsApp.hijau.withOpacity(0.6)),
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
                            value: _profileData?['tanggal_lahir'] != null
                                ? DateFormat('dd MMMM yyyy').format(
                                    DateTime.parse(
                                        _profileData?['tanggal_lahir']))
                                : 'Tidak ada data',
                          ),
                          Divider(),
                          _buildInfoRow(
                            icon: Icons.child_friendly,
                            label: 'Tanggal Awal Kehamilan',
                            value: _profileData?['tanggal_kehamilan'] != null
                                ? DateFormat('dd MMMM yyyy').format(
                                    DateTime.parse(
                                        _profileData?['tanggal_kehamilan']))
                                : 'Tidak ada data',
                          ),
                          Divider(),
                          Row(
                            children: [
                              Expanded(
                                child: _buildInfoRow(
                                  icon: Icons.height,
                                  label: 'Tinggi Badan',
                                  value: _profileData?['tinggi_badan'] != null
                                      ? '${_profileData?['tinggi_badan']} cm'
                                      : 'Tidak ada data',
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
                                  value: _profileData?['berat_badan'] != null
                                      ? '${_profileData?['berat_badan']} kg'
                                      : 'Tidak ada data',
                                ),
                              ),
                            ],
                          ),
                          if (_profileData?['tanggal_kehamilan'] != null) ...[
                            SizedBox(height: 16),
                            LinearProgressIndicator(
                              value: _hitungKemajuanKehamilan(),
                              backgroundColor: Colors.grey[350],
                              color: ColorsApp.hijau,
                              minHeight: 10,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Usia Kehamilan: ${_hitungKehamilanPerminggu()} minggu',
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
                      border:
                          Border.all(color: ColorsApp.hijau.withOpacity(0.6)),
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
                            _profileData?['alamat'] ?? 'Tidak ada data',
                            style:
                                TextStyle(fontSize: 14, color: ColorsApp.text),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              // Kondisi jika tidak ada data (mungkin terjadi jika UserService.getCurrentUserProfile() mengembalikan null)
              return const Center(child: Text('Data profil tidak ditemukan'));
            }
          },
        ),
      ),
    );
  }

  Widget _appBarMenu() {
    return CustomAppBarMenu(
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
                  initialData: _profileData != null
                      ? {
                          'nama': _profileData!['nama'],
                          'foto_profile': _profileData!['foto_profile'],
                          'tanggal_lahir': _profileData!['tanggal_lahir'],
                          'tanggal_kehamilan':
                              _profileData!['tanggal_kehamilan'],
                          'tinggi_badan': _profileData!['tinggi_badan'],
                          'berat_badan': _profileData!['berat_badan'],
                          'alamat': _profileData!['alamat'],
                        }
                      : {},
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
  double _hitungKemajuanKehamilan() {
    final startDate = DateTime.parse(_profileData!['tanggal_kehamilan']);
    final totalDays = DateTime.now().difference(startDate).inDays;
    return (totalDays / 280).clamp(0.0, 1.0); // 280 hari = 40 minggu
  }

  String _hitungKehamilanPerminggu() {
    final startDate = DateTime.parse(_profileData!['tanggal_kehamilan']);
    final weeks = DateTime.now().difference(startDate).inDays ~/ 7;
    return weeks.toString();
  }
}
