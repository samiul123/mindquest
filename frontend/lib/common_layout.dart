import 'package:flutter/material.dart';
import 'package:frontend/utils.dart';

class CommonLayout extends StatefulWidget {
  final Widget body;

  const CommonLayout({super.key, required this.body});

  @override
  State<StatefulWidget> createState() => _CommonLayoutState();
}

class _CommonLayoutState extends State<CommonLayout> {
  late Widget body;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    body = widget.body;
    _selectedIndex = 2;
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
        body: body,
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
    setState(() {
      _selectedIndex = index;
    });
  }
}
