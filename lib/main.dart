import 'package:educational_app/models/user_model.dart';
import 'package:educational_app/screens/home/home_screen.dart';
import 'package:educational_app/screens/login_screen.dart';
import 'package:educational_app/services/login_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<UserModel> futureUserModel;

  @override
  void initState() {
    super.initState();
    futureUserModel = LoginService().getUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Educational App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          bodyLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          displayMedium: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      home: FutureBuilder<UserModel>(
        // initstate Future<UserModel>.LoginService().getUser() to call it only once per frame
        // futureUserModel is equal to LoginService().getUser()
        future: futureUserModel,
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
      ),
    );
  }
}
