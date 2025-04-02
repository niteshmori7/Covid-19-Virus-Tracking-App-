import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'countries_detail.dart';
import 'home.dart';
import 'package:corona/Controller/covidcontroller.dart';

class CountryData extends StatefulWidget {
  const CountryData({super.key});

  @override
  State<CountryData> createState() => _CountryDataState();
}

class _CountryDataState extends State<CountryData> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StateService stateService = StateService();

    return Scaffold(
      appBar: AppBar(
        title: Text("COVID-19 Country Stats", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5, spreadRadius: 2)],
              ),
              child: TextField(
                controller: textController,
                onChanged: (value) {
                  setState(() {}); // Update UI on text change
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search by country name...',
                  prefixIcon: Icon(Icons.search, color: Colors.blueAccent),
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
            SizedBox(height: 15),

            // Data List
            Expanded(
              child: FutureBuilder(
                future: stateService.fatchcountryRecord(),
                builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: ListTile(
                            leading: Container(height: 50, width: 50, color: Colors.white),
                            title: Container(height: 15, width: 100, color: Colors.white),
                            subtitle: Container(height: 15, width: 50, color: Colors.white),
                          ),
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];
                        if (textController.text.isEmpty || name.toLowerCase().contains(textController.text.toLowerCase())) {
                          return ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(snapshot.data![index]['countryInfo']['flag'], height: 50, width: 50, fit: BoxFit.cover),
                            ),
                            title: Text(snapshot.data![index]['country'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            subtitle: Text("Cases: ${snapshot.data![index]['cases']}", style: TextStyle(fontSize: 16, color: Colors.black54)),
                            trailing: Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CountryDetailPage(countryData: snapshot.data![index]),
                                ),
                              );
                            },
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
