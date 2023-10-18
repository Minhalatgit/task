import 'dart:async';
import 'package:flutter/material.dart';
import 'package:task/app_preferences.dart';
import 'package:task/app_routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      _nextScreenNavigation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Text("Task"),
        ),
      ),
    );
  }

  void _nextScreenNavigation() async {
    var isLoggedIn = AppPreferences.getIsLoggedIn();

    ///Check if user is logged in
    if (isLoggedIn) {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.productsView, (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.signInView, (route) => false);
    }
  }
}
