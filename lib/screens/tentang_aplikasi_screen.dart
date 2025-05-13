import 'package:flutter/material.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:generation_stars/shared/shared_appbar.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:url_launcher/url_launcher.dart';

class TentangAplikasiScreen extends StatelessWidget {
  TentangAplikasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.white,
      appBar: SharedAppbar(
        title: 'Tentang Aplikasi',
        ipmlayLeadingFalse: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Info Card
                  _buildAppInfoCard(),
                  SizedBox(height: 24),

                  Text(
                    'Fitur Unggulan',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildFeatureItem(
                    icon: Icons.monitor_heart,
                    title: 'Pemantauan Nutrisi',
                    description:
                        'Pantau asupan gizi harian untuk kesehatan ibu dan janin',
                  ),
                  _buildFeatureItem(
                    icon: Icons.calendar_today,
                    title: 'Kalender Kehamilan',
                    description: 'Lacak perkembangan janin mingguan',
                  ),
                  _buildFeatureItem(
                    icon: Icons.article,
                    title: 'Artikel Terpercaya',
                    description: 'Informasi kesehatan dari sumber terpercaya',
                  ),
                  SizedBox(height: 24),

                  // Team Section
                  Text(
                    'Tim Kami',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildTeamMember(
                          name: 'Dr. Sarah',
                          role: 'Dokter Kandungan',
                          image: 'assets/images/ibu_hamil.png',
                        ),
                        _buildTeamMember(
                          name: 'Dr. Michael',
                          role: 'Ahli Gizi',
                          image: 'assets/images/ibu_hamil.png',
                        ),
                        _buildTeamMember(
                          name: 'Dr. Michael',
                          role: 'Ahli Gizi',
                          image: 'assets/images/ibu_hamil.png',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),

                  // Contact Section
                  _buildContactCard(),
                  SizedBox(height: 24),

                  // Version Info
                  Center(
                    child: Text(
                      'Versi 1.0.0',
                      style: GoogleFonts.poppins(
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppInfoCard() {
    return Card(
      color: ColorsApp.biruMuda,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset(
              'assets/images/icons.png',
              height: 100,
            ),
            SizedBox(height: 14),
            Text(
              'Bunda Sehat',
              style: GoogleFonts.poppins(
                color: ColorsApp.text,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Aplikasi pendamping kehamilan untuk memantau kesehatan ibu dan janin',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: ColorsApp.black.withOpacity(0.9),
              ),
            ),
            SizedBox(height: 16),
            Divider(color: ColorsApp.grey),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem('10K+', 'Pengguna'),
                _buildStatItem('4.9', 'Rating'),
                _buildStatItem('2023', 'Tahun Rilis'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorsApp.biru,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: ColorsApp.black.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.blue[800]),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMember({
    required String name,
    required String role,
    required String image,
  }) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: 16),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              image,
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            role,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard() {
    return Card(
      color: ColorsApp.biruMuda,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hubungi Kami',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorsApp.text,
              ),
            ),
            SizedBox(height: 12),
            _buildContactItem(
              icon: Icons.email,
              label: 'support@bundasehat.com',
              onTap: () => (),
            ),
            _buildContactItem(
              icon: Icons.phone,
              label: '+62 812-3456-7890',
              onTap: () => (),
            ),
            _buildContactItem(
              icon: Icons.language,
              label: 'www.bundasehat.com',
              onTap: () => (),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: ColorsApp.biru),
      title: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: ColorsApp.black.withOpacity(0.8),
        ),
      ),
      onTap: onTap,
    );
  }
}
