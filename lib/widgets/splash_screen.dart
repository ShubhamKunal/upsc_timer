import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:upsc_timer/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToMain();
  }

  Future<void> _navigateToMain() async {
    await Future.delayed(const Duration(seconds: 2));
    context.go("/home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#FFEF8A"),
      body: GestureDetector(
        onTap: () => context.go("/home"),
        child: Center(
          child: SvgPicture.asset(
            'assets/svg/emblem_of_India.svg',
            width: 300,
            height: 300,
          ),
        ),
      ),
    );
  }
}
