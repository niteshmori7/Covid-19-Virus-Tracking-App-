import 'dart:async';
import 'dart:math' as math; // Import math for pi

import 'package:corona/home.dart';
import 'package:flutter/material.dart';

class SpleshScreen extends StatefulWidget {
  const SpleshScreen({super.key});

  @override
  State<SpleshScreen> createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();

    Timer(const Duration(seconds: 5), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => home()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              return Transform.rotate(
                angle: _controller.value * math.pi * 2,
                child: Image.asset('assets/corona.png'),
              );
            },
          ),
          SizedBox(height:  MediaQuery.of(context).size.height * .04),
          Align(
            alignment: Alignment.center,
            child: Text('Covid-19 \n Tracking App',textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          )
        ],
      ),
    );
  }
}
