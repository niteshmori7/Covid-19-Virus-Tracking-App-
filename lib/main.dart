import 'package:corona/country_data.dart';
import 'package:corona/home.dart';
import 'package:corona/splesh%20screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SpleshScreen()
    );
  }
}
