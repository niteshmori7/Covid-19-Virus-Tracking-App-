import 'package:flutter/material.dart';

class CountryDetailPage extends StatelessWidget {
  final Map countryData;

  const CountryDetailPage({super.key, required this.countryData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(countryData['country'])),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: 684,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30,),
                    Center(
                      child: Column(
                        children: [
                          Image.network(countryData['countryInfo']['flag'], height: 80, width: 120),
                          SizedBox(height: 10),
                          Text(countryData['country'], style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Divider(), // A line to separate sections
        
                    buildInfoRow("Total Cases:", countryData['cases'].toString(), Colors.black),
                    buildInfoRow("Total Deaths:", countryData['deaths'].toString(), Colors.red),
                    buildInfoRow("Total Recovered:", countryData['recovered'].toString(), Colors.green),
        
                    Divider(),
                    buildInfoRow("Today's Cases:", countryData['todayCases'].toString(), Colors.black),
                    buildInfoRow("Today's Deaths:", countryData['todayDeaths'].toString(), Colors.red),
                    buildInfoRow("Today's Recovered:", countryData['todayRecovered'].toString(), Colors.green),
        
                    Divider(),
                    buildInfoRow("Active Cases:", countryData['active'].toString(), Colors.orange),
                    buildInfoRow("Critical Cases:", countryData['critical'].toString(), Colors.redAccent),
        
                    Divider(),
                    buildInfoRow("Population:", countryData['population'].toString(), Colors.blue),
                    buildInfoRow("One Case Per People:", countryData['oneCasePerPeople'].toString(), Colors.black),
                    buildInfoRow("One Death Per People:", countryData['oneDeathPerPeople'].toString(), Colors.black),
                    buildInfoRow("One Test Per People:", countryData['oneTestPerPeople'].toString(), Colors.black),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(String title, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(value, style: TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
