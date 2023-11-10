import 'package:flutter/material.dart';
import 'tabbar.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3),() {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => tabbarscreen()));
      }
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff151515),
        body: Container(
          child: Center(
            child: Image(image: AssetImage('assets/Image/Screenshot 2023-11-11 015048.png') )
          ),
        ),
    );
  }
}
