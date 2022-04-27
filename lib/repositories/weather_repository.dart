import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/custom_error.dart';

import '../exceptions/weather_exception.dart';
import '../services/weather_api_services.dart';
import '../models/weather.dart';

class WeatherRepository {
  final WeatherApiServices weatherApiServices;
  WeatherRepository({
    required this.weatherApiServices,
  });

  Future<Weather> fetchWeather(String city) async {
    try {
      final int woeid = await weatherApiServices.getWoeid(city);
      final Weather weather = await weatherApiServices.getWeather(woeid);
      return weather;
    } on WeatherException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }

  Future<Weather> fetchWeatherByLocation(LatLng location) async {
    try {
      final Weather weather =
          await weatherApiServices.getWeatherByLocation(location);
      return weather;
    } on WeatherException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}
