import 'package:flutter/material.dart';
import 'package:generation_stars/utils/colors.dart';
import 'package:generation_stars/shared/shared_appbar.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:url_launcher/url_launcher.dart';

class TentangAplikasiScreen extends StatelessWidget {
  const TentangAplikasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: SharedAppbar(
        title: 'Tentang Aplikasi',
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Info Card
                  _buildAppInfoCard(),
                  const SizedBox(height: 24),

                  // Features Section
                  Text(
                    'Fitur Unggulan',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 24),

                  // Team Section
                  Text(
                    'Tim Kami',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 24),

                  // Contact Section
                  _buildContactCard(),
                  const SizedBox(height: 24),

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
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset(
              'assets/images/icons.png',
              height: 80,
            ),
            const SizedBox(height: 16),
            Text(
              'Bunda Sehat',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Aplikasi pendamping kehamilan untuk memantau kesehatan ibu dan janin',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            Divider(color: Colors.grey[300]),
            const SizedBox(height: 12),
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
            color: Colors.blue[800],
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.grey[600],
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
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.blue[800]),
          ),
          const SizedBox(width: 16),
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
      margin: const EdgeInsets.only(right: 16),
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
          const SizedBox(height: 8),
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
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hubungi Kami',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
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
      leading: Icon(icon, color: Colors.blue[800]),
      title: Text(
        label,
        style: GoogleFonts.poppins(),
      ),
      onTap: onTap,
    );
  }
}
//   Future<void> _launchEmail() async {
//     final Uri emailLaunchUri = Uri(
//       scheme: 'mailto',
//       path: 'support@bundasehat.com',
//     );
//     if (await canLaunchUrl(emailLaunchUri)) {
//       await launchUrl(emailLaunchUri);
//     }
//   }

//   Future<void> _launchPhone() async {
//     final Uri phoneLaunchUri = Uri(
//       scheme: 'tel',
//       path: '+6281234567890',
//     );
//     if (await canLaunchUrl(phoneLaunchUri)) {
//       await launchUrl(phoneLaunchUri);
//     }
//   }

//   Future<void> _launchWebsite() async {
//     final Uri websiteLaunchUri = Uri.parse('https://www.bundasehat.com');
//     if (await canLaunchUrl(websiteLaunchUri)) {
//       await launchUrl(websiteLaunchUri);
//     }
//   }

//   Future<void> _launchSocial(String platform) async {
//     String url = '';
//     switch (platform) {
//       case 'facebook':
//         url = 'https://facebook.com/bundasehat';
//         break;
//       case 'instagram':
//         url = 'https://instagram.com/bundasehat';
//         break;
//       case 'twitter':
//         url = 'https://twitter.com/bundasehat';
//         break;
//     }
//     final Uri socialLaunchUri = Uri.parse(url);
//     if (await canLaunchUrl(socialLaunchUri)) {
//       await launchUrl(socialLaunchUri);
//     }
//   }
// }