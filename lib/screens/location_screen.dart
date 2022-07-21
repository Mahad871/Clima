import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  final locationData;

  LocationScreen(this.locationData);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late int temperature;
  String? cityName;
  late String weatherMessage, weatherIcon;
  late int condition;
  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.locationData);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherMessage = 'Error! \nSomething\ is broken, Like my heart 💔 ';
        weatherIcon = '';
        cityName = '';
        return;
      }

      double _temperature = weatherData['main']['temp'];

      temperature = _temperature.toInt();
      cityName = 'in ' + weatherData['name'];

      condition = weatherData['weather'][0]['id'];
      weatherMessage = weatherModel.getMessage(temperature, condition);
      weatherIcon = weatherModel.getWeatherIcon(condition);
    });
    // print(condition);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      setState(() async {
                        var weatherData = await WeatherModel().getWeatherData();
                        // weatherData = null;
                        updateUI(weatherData);
                      });
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CityScreen(),
                          ));
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      temperature.toString() + '°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  weatherMessage + '$cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
