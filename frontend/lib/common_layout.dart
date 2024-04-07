import 'package:flutter/material.dart';
import 'package:frontend/discussion_home_screen.dart';
import 'package:frontend/discussion_post_screen.dart';
import 'package:frontend/trivia_screen_v2.dart';
import 'package:frontend/utils.dart';

import 'home_screen.dart';

class CommonLayout extends StatefulWidget {
  final int pageIndex;

  const CommonLayout({this.pageIndex = 2, super.key});

  @override
  State<StatefulWidget> createState() => _CommonLayoutState();
}

class _CommonLayoutState extends State<CommonLayout> {
  int _selectedIndex = 0;

  final List<Widget> _pageList = [
    const TriviaScreen(),
    const DiscussionHomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen()
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.pageIndex;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: CustomColor.grey,
        appBar: AppBar(
          backgroundColor: CustomColor.purple,
          title: const Text('MindQuest', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              print("Profile image clicked");
            },
            child: const Icon(
              Icons.account_circle,
              size: 30,
              color: Colors.white,
            ),
          ),
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
    setState(() {
      _selectedIndex = index;
    });
  }
}
