import 'package:colors/screen/splash.dart';
import 'package:flutter/material.dart';
import 'screen/device.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Colors',
      theme: ThemeData(primarySwatch: Colors.green),
      home: Splash(),
    );
  }
}
