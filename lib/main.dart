import 'package:flutter/material.dart';
import 'package:sorting/screens/home_screen.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Lato-Medium'),
      title: 'AlgoVisual',
      home: SplashScreen(
        seconds: 3,
        navigateAfterSeconds: new HomeScreen(),
        image: new Image.asset('assets/images/logo.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.blue,
      ),
    );
  }
}
