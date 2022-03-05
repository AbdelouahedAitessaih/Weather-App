import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather_app/model/weathermodel.dart';

class WeatherRepo {
  Future<WeatherModel> getWeather(String city) async{
    final result = await http.Client().get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$city&appid=4321fa2ca520af425fb7efc52dc1a61e"));

    if(result.statusCode != 200){
      throw Exception();
    }

    return parseJson(result.body);
  }

  WeatherModel parseJson(String response){
    final jsonDecoded = json.decode(response);
    final jsonMain = jsonDecoded["main"];

    return WeatherModel.fromJson(jsonMain);
  }
}
