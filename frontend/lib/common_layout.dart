import 'package:flutter/material.dart';
import 'package:frontend/breathing.dart';
import 'package:frontend/discussion_home_screen.dart';
import 'package:frontend/discussion_post_details.dart';
import 'package:frontend/discussion_post_screen.dart';
import 'package:frontend/settings.dart';
import 'package:frontend/trivia_screen_v2.dart';
import 'package:frontend/utils.dart';

import 'home_screen.dart';
import 'globals.dart' as globals;

class CommonLayout extends StatefulWidget {
  final int pageIndex;

  const CommonLayout({this.pageIndex = 2, super.key});

  @override
  State<StatefulWidget> createState() => _CommonLayoutState();
}

class _CommonLayoutState extends State<CommonLayout> {
  int _selectedIndex = 0;
  bool _showBackIcon = false;

  late List<Widget> _pageList;
  int disabledIndex = 4;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.pageIndex;
    _pageList = [
      const TriviaScreen(),
      DiscussionHomeScreen(replacePage: _replacePage),
      const HomeScreen(),
      const BreathingScreen(),
      const HomeScreen()
    ];
  }

  Widget? _buildLeadingIcon() {
    if (_showBackIcon) {
      return IconButton(
        onPressed: () {
          // Navigate back to the previous screen
          _replacePage(1, DiscussionHomeScreen(replacePage: _replacePage));
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: (globals.darkTheme)
            ? globals.dark_background
            : globals.light_background,
        appBar: AppBar(
          backgroundColor: CustomColor.purple,
          title: const Text('MindQuest', style: TextStyle(color: Colors.white)),
          leading: _buildLeadingIcon(),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                print("Profile image clicked");
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const SettingsScreen()));
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.account_circle,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        // TODO:
        body: _pageList.elementAt(_selectedIndex),
        bottomNavigationBar: Stack(
          children: [
            BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: CustomColor.purple,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.quiz), label: 'Trivia'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.groups), label: 'Forum'),
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.circle), label: 'Breathing'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.notifications), label: 'Notification'),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.deepPurple,
              unselectedItemColor: Colors.white,
              onTap: _onItemTapped, // Call _onItemTapped function
            ),
          ],
        ));
  }

  void _onItemTapped(int index) {
    print("Index: $index");
    if (index == disabledIndex) return;
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      _replacePage(1, DiscussionHomeScreen(replacePage: _replacePage));
    }
  }

  void _replacePage(int index, Widget widget) {
    _pageList[index] = widget;
    setState(() {
      _selectedIndex = index;
    });

    if (widget is DiscussionPostScreen || widget is DiscussionPostDetails) {
      setState(() {
        _showBackIcon = true;
      });
    } else {
      setState(() {
        _showBackIcon = false;
      });
    }
  }
}
