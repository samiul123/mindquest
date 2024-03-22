import 'package:flutter/material.dart';

import 'common_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CommonLayout(
      body: Center(
        child: Text('Home Screen Content'),
      ),
    );
  }
}