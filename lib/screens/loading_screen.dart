import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../services/location.dart';
import '../services/networking.dart';
import 'location_screen.dart';

const apiKey = 'ad2eb54e50437d2aab55a1cd9113f1e6';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  @override
  void initState() {
    super.initState();

    getLocationData();
  }

  Future<void> getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();

    longitude = location.longitude;
    latitude = location.latitude;

    NetworkHelper networkHelper = NetworkHelper(
      'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey',
    );

    final decodedData = await networkHelper.getData();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LocationScreen(),
      ),
    );

//    await whenPop;
//    getLocationData();

//    int conditionNumber = decodedData['weather'][0]['id'];
//    double temperature = decodedData['main']['temp'];
//    String cityName = decodedData['name'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
