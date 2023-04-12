import 'package:flutter/material.dart';
import 'package:random_colors_challenge/pages/dvd_logo.dart';
import 'package:random_colors_challenge/pages/gradient_colors.dart';
import 'package:random_colors_challenge/pages/home_page.dart';
import 'package:random_colors_challenge/pages/rainbow.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/gradient': (_) => const GradientColors(),
        '/dvd': (_) => const DvdLogo(),
        '/rainbow': (_) => const Rainbow(),
      },
      home: const HomePage(),
    );
  }
}
