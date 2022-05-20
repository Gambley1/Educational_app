import 'package:flutter/material.dart';

import 'login_screen.dart';
class MyLearningsScreen extends StatelessWidget {
  const MyLearningsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginScreen(),
    );
  }
}
