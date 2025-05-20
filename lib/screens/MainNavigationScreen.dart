import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generation_stars/screens/history_screen.dart';
import 'package:generation_stars/screens/home_screen.dart';
import 'package:generation_stars/screens/profile_screen.dart';
import 'package:generation_stars/screens/trimester_screen.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainNavigationScreen extends StatefulWidget {
  final int initialPage;
  MainNavigationScreen({Key? key, this.initialPage = 0}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialPage;
  }

  final List<Widget> _pages = <Widget>[
    HomeScreen(),
    TrimesterScreen(),
    HistoryScreen(),
    ProfileScreen()
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.white,
      body: _pages[_currentIndex],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: ColorsApp.hijau,
          ),
          child: SalomonBottomBar(
            margin: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            backgroundColor: Colors.transparent,
            currentIndex: _currentIndex,
            selectedItemColor: Color(0xff6200ee),
            unselectedItemColor: ColorsApp.white,
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
    selectedColor: ColorsApp.white,
  ),
  SalomonBottomBarItem(
    icon: Icon(FontAwesomeIcons.chartColumn, size: 20),
    title: Text(
      "Trimester",
      style: GoogleFonts.poppins(fontSize: 15),
    ),
    selectedColor: ColorsApp.white,
  ),
  SalomonBottomBarItem(
    icon: Icon(FontAwesomeIcons.clockRotateLeft, size: 20),
    title: Text(
      "Riwayat",
      style: GoogleFonts.poppins(fontSize: 15),
    ),
    selectedColor: ColorsApp.white,
  ),
  SalomonBottomBarItem(
    icon: Icon(FontAwesomeIcons.solidCircleUser, size: 22),
    title: Text(
      "Profil",
      style: GoogleFonts.poppins(fontSize: 15),
    ),
    selectedColor: ColorsApp.white,
  ),
];

// Enhanced Page Views
