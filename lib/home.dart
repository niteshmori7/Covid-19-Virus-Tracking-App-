import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:corona/Controller/covidcontroller.dart';
import 'package:corona/country_data.dart';
import 'package:corona/covidmodel/model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late final AnimationController _controller;
  final colorList = [
    Colors.blueAccent,
    Colors.green,
    Colors.redAccent,
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StateService stateService = StateService();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "COVID-19 Global Stats",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: stateService.fatchWorldRecord(),
          builder: (context, AsyncSnapshot<CovidModel> snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return Center( // Centering the entire content
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Center align vertically
                  children: [
                    // Pie Chart
                    PieChart(
                      dataMap: {
                        'Total': double.parse(snapshot.data!.cases.toString()),
                        'Recovered': double.parse(snapshot.data!.recovered.toString()),
                        'Deaths': double.parse(snapshot.data!.deaths.toString()),
                      },
                      chartValuesOptions: const ChartValuesOptions(showChartValuesInPercentage: true),
                      chartRadius: MediaQuery.of(context).size.width / 3,
                      colorList: colorList,
                      chartType: ChartType.ring,
                      animationDuration: const Duration(milliseconds: 1200),
                      legendOptions: const LegendOptions(legendPosition: LegendPosition.left),
                    ),

                    const SizedBox(height: 30),

                    // Stats Card
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      shadowColor: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                        child: Column(
                          children: [
                            DataRowWidget(title: 'Total Cases', value: snapshot.data!.cases.toString()),
                            DataRowWidget(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                            DataRowWidget(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                            DataRowWidget(title: 'Active Cases', value: snapshot.data!.active.toString()),
                            DataRowWidget(title: 'Critical', value: snapshot.data!.critical.toString()),
                            DataRowWidget(title: 'Today Cases', value: snapshot.data!.todayCases.toString()),
                            DataRowWidget(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                            DataRowWidget(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Track Countries Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const CountryData()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text(
                        'Track Countries',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Data Row Widget without text color
class DataRowWidget extends StatelessWidget {
  final String title, value;

  const DataRowWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
