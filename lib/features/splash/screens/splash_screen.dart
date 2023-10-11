import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String? token;

  checkAuth() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString("token");
    // pref.remove("token");
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushNamedAndRemoveUntil(token != null ? '/bottom-bar' : '/login', (route) => false);
    });
  }

  @override
  void initState() {
    checkAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
