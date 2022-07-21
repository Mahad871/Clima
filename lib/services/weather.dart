import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const appkey = 'b9a45db1756190fe85a9c139bdbce501';

double? latitude;
double? longitude;
bool isfirst = true;

class WeatherModel {
  Future<dynamic> getWeatherData() async {
    Location position = Location();
    await position.getCurrentPosition();
    latitude = position.latitude;
    longitude = position.longitude;

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$appkey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp, int condition) {
    if (temp > 25 && condition >= 800) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
