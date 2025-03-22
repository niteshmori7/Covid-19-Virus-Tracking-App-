import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> with TickerProviderStateMixin {

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();

    Timer(const Duration(seconds: 4), () {
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

  final colorlist =[
    const Color(0xFF2196F3),
    const Color(0xFF00FF00),
    const Color(0xFFFF0000),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             PieChart(dataMap: {
               'total': 20,
               'recovered': 15,
               'deaths':5
             },
               chartRadius: MediaQuery.of(context).size.width/3,
               colorList: colorlist,
               chartType: ChartType.ring,
               animationDuration: Duration(milliseconds: 1200),
               legendOptions: LegendOptions(legendPosition: LegendPosition.left),

             ),
            Card(margin: EdgeInsets.only(top: 50,left: 20,right: 20),
              child: Column(
                children: [
                  roww(title: 'Total', value: '200'),
                  roww(title: 'Total', value: '200'),
                  roww(title: 'Total', value: '200'),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50,right: 20,left: 20),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue
              ),
              child: Center(child: Text('Track Countires')),
            )
          ],
        ),
      ),
    );
  }
}
class roww extends StatelessWidget {

  String title,value;
  roww({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 10,),
          Divider()
        ],
      ),
    );
  }
}
