import 'dart:convert';

import 'package:corona/app_url.dart';

import '../covidmodel/model.dart';
import 'package:http/http.dart' as http;
class StateService {

  Future<CovidModel> fatchWorldRecord() async {
    final response = await http.get(Uri.parse('https://disease.sh/v3/covid-19/all'));

    print("API Response: ${response.body}"); // Debugging

    if (response.statusCode == 200) {
      return CovidModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<dynamic>> fatchcountryRecord() async {

    var data;
    final response = await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));

    if (response.statusCode == 200) {
      data= jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Future<CovidModel> fatchWorldRecord() async{
  //   final respo = await http.get(Uri.parse(AppUrl.WorldStateApi));
  //   if(respo.statusCode==200){
  //     var data = jsonDecode(respo.body);
  //     return CovidModel.fromJson(data);
  //   }
  //   else
  //     {
  //       throw Exception('error');
  //     }
  // }
}