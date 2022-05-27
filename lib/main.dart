import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'blocs/blocs.dart';
import 'constants/constants.dart';
import 'models/models.dart';
import 'services/services.dart';
import 'widgets/widgets.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<UserModel> futureGetUser;

  @override
  void initState() {
    futureGetUser = GetUserService().getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SubjectAdditionModelBloc(
            ConnectivityService(),
            SubjectService(),
          )..add(LoadSubjectAdditionModelEvent()),
        ),
        BlocProvider(
          create: (context) => CurrentGroupBloc(
            ConnectivityService(),
            GroupService(),
          )..add(LoadCurrentGroupEvent()),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Educational App',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 20,
              color: kPrimaryColor,
              fontWeight: FontWeight.w500,
            ),
            titleSmall: TextStyle(
              fontSize: 14,
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
        home: GetUserWidget(futureGetUser: futureGetUser),
      ),
    );
  }
}
