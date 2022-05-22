import 'package:educational_app/bloc/group_model_bloc.dart';
import 'package:educational_app/bloc/subject_addition_model_bloc.dart';
import 'package:educational_app/constants/colors.dart';
import 'package:educational_app/models/subject_additional_model.dart';
import 'package:educational_app/models/user_model.dart';
import 'package:educational_app/screens/home/home_screen.dart';
import 'package:educational_app/screens/login_screen.dart';
import 'package:educational_app/services/api_request_service/get_user_service.dart';
import 'package:educational_app/services/api_request_service/group_service.dart';
import 'package:educational_app/services/api_request_service/subject_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<SubjectAdditionModelBloc>(
        create: (context) => SubjectAdditionModelBloc(SubjectService()),
      ),
      BlocProvider<GroupModelBloc>(
        create: (context) => GroupModelBloc(GroupService()),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<UserModel>? futureGetUser;
  List<MySubjectOverall>? subjectOverall;

  @override
  void initState() {
    futureGetUser = GetUserService().getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Educational App',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 20,
            color: kPrimaryColor,
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
      ),
    );
  }
}
