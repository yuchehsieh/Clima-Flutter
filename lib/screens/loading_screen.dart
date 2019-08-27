import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../services/location.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();

    final http.Response response = await http.get(
        'https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22');

    int conditionNumber;
    double temperature;
    String cityName;

    if (response.statusCode == 200) {
      /// json.decode(source) == jsonDecode(source)

      final decodedData = jsonDecode(response.body);

      conditionNumber = decodedData['weather'][0]['id'];
      temperature = decodedData['main']['temp'];
      cityName = decodedData['name'];

      print(conditionNumber);
      print(temperature);
      print(cityName);
    } else {
      print(response.statusCode);
    }

//    print(location.latitude);
//    print(location.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            getLocation();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
