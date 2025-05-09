import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generation_stars/screens/history_screen.dart';
import 'package:generation_stars/screens/home_screen.dart';
import 'package:generation_stars/screens/profile_screen.dart';
import 'package:generation_stars/screens/trimester_screen.dart';
import 'package:generation_stars/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainNavigationScreen extends StatefulWidget {
  MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = <Widget>[
    HomeScreen(),
    TrimesterScreen(),
    HistoryScreen(),
    ProfilePage()
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _pages[_currentIndex],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: AppColors.button,
          ),
          child: SalomonBottomBar(
            margin: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            // backgroundColor: Colors.transparent,
            currentIndex: _currentIndex,
            selectedItemColor: Color(0xff6200ee),
            unselectedItemColor: AppColors.background,

            onTap: _onTabTapped,
            items: _navBarItems,
          ),
        ),
      ),
    );
  }
}

final _navBarItems = [
  SalomonBottomBarItem(
    icon: Icon(FontAwesomeIcons.house, size: 19),
    title: Text(
      "Beranda",
      style: GoogleFonts.poppins(fontSize: 15),
    ),
    selectedColor: AppColors.background,
  ),
  SalomonBottomBarItem(
    icon: Icon(FontAwesomeIcons.chartColumn, size: 20),
    title: Text(
      "Trimester",
      style: GoogleFonts.poppins(fontSize: 15),
    ),
    selectedColor: AppColors.background,
  ),
  SalomonBottomBarItem(
    icon: Icon(FontAwesomeIcons.clockRotateLeft, size: 20),
    title: Text(
      "Riwayat",
      style: GoogleFonts.poppins(fontSize: 15),
    ),
    selectedColor: AppColors.background,
  ),
  SalomonBottomBarItem(
    icon: Icon(FontAwesomeIcons.solidCircleUser, size: 22),
    title: Text(
      "Profil",
      style: GoogleFonts.poppins(fontSize: 15),
    ),
    selectedColor: AppColors.background,
  ),
];

// Enhanced Page Views
