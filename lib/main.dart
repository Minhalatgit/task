import 'package:flutter/material.dart';
import 'package:task/app_preferences.dart';
import 'package:task/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppPreferences.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.getRoutes,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0, boldText: false),
          child: child!,
        );
      },
    );
  }
}
