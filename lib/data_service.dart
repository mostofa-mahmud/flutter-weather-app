
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models.dart';

class DataService{
  Future<WeatherResponse> getWeather(String city) async {
    // api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

    final queryParameters= {'q': city, 'appid': '26a8534458a4c27cf801048160d5ae5f','units': 'metric'};

    final uri = Uri.https(
        'api.openweathermap.org',
        'data/2.5/weather',queryParameters);

    final response = await http.get(uri);
    //print(response.body);
    final json = jsonDecode(response.body);
    return WeatherResponse.fromJson(json);

  }
}