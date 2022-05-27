import 'package:educational_app/services/api_request_service/group_service.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';
import '../screens/screens.dart';

class GetUserWidget extends StatelessWidget {
  const GetUserWidget({
    Key? key,
    required this.futureGetUser,
  }) : super(key: key);

  final Future<UserModel>? futureGetUser;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: futureGetUser,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                strokeWidth: 3.0,
              ),
            );
          case ConnectionState.none:
            return const LoginScreen();
          default:
            if (snapshot.data != null) {
              return HomeScreen(
                user: snapshot.data!,
              );
            } else {
              return const LoginScreen();
            }
        }
      },
    );
  }
}
