import 'package:flutter/material.dart';
import 'package:media_booster/splacescreen.dart';

void main()
{
  runApp(MyApp());
}
class MyApp extends StatefulWidget {

  @override

  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
