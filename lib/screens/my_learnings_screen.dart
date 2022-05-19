import 'package:educational_app/screens/home/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:educational_app/models/user_model.dart';

import 'login_screen.dart';
class MyLearningsScreen extends StatelessWidget {
  const MyLearningsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginScreen(),
    );
  }
}
