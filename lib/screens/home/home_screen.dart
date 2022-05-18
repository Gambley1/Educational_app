import 'package:educational_app/models/user_model.dart';
import 'package:educational_app/screens/settings_screen.dart';
import 'package:educational_app/screens/wish_list_screen.dart';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/icon.dart';
import '../../constants/size.dart';
import '../../models/subjects_model.dart';
import '../subject_screen.dart';
import '../my_learnings_screen.dart';
import 'nav_bar.dart';

class HomeScreen extends StatefulWidget {
  final UserModel user;
  final Subject? subject;

  const HomeScreen({
    Key? key,
    this.subject,
    required this.user,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    const List<Widget> _widgetOptions = [
      SubjectScreen(),
      MyLearningsScreen(),
      WishListScreen(),
      SettingsScreen(),
    ];
    return Scaffold(
      drawer: NavBar(
        user: widget.user,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kPrimaryColor,
        backgroundColor: Colors.white,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              icFeatured,
              height: kBottomNavigationBarItemSize,
            ),
            icon: Image.asset(
              icFeaturedOutlined,
              height: kBottomNavigationBarItemSize,
            ),
            label: "Уроки",
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              icLearning,
              height: kBottomNavigationBarItemSize,
            ),
            icon: Image.asset(
              icLearningOutlined,
              height: kBottomNavigationBarItemSize,
            ),
            label: "Задания",
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              icWishlist,
              height: kBottomNavigationBarItemSize,
            ),
            icon: Image.asset(
              icWishlistOutlined,
              height: kBottomNavigationBarItemSize,
            ),
            label: "Успеваемость",
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              icSetting,
              height: kBottomNavigationBarItemSize,
            ),
            icon: Image.asset(
              icSettingOutlined,
              height: kBottomNavigationBarItemSize,
            ),
            label: "Настройки",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(
            () {
              _selectedIndex = index;
            },
          );
        },
      ),
    );
  }
}
