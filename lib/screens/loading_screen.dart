import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'location_screen.dart';

const appkey = 'b9a45db1756190fe85a9c139bdbce501';

double? latitude;
double? longitude;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getLocationData() async {
    Location position = Location();
    await position.getCurrentPosition();
    latitude = position.latitude;
    longitude = position.longitude;

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$appkey&units=metric');

    var weatherData = await networkHelper.getData();

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LocationScreen(weatherData),
        ));
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SpinKitDoubleBounce(
        color: Colors.white,
      ),
    );
  }
}
