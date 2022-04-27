import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/custom_error.dart';
import '../models/locations.dart';
import '../exceptions/weather_exception.dart';
import '../services/weather_api_services.dart';
import '../models/weather.dart';

class WeatherRepository {
  final WeatherApiServices weatherApiServices;
  WeatherRepository({
    required this.weatherApiServices,
  });

  Future<Weather> fetchWeather([String? city, int? woeidByLocation]) async {
    try {
      int woeid;
      if (city != null) {
        woeid = await weatherApiServices.getWoeid(city);
      } else {
        woeid = woeidByLocation!;
      }
      final Weather weather = await weatherApiServices.getWeather(woeid);
      return weather;
    } on WeatherException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }

  Future<List<Locations>> fetchWoeidsByLocation(LatLng location) async {
    try {
      final List<Locations> weather =
          await weatherApiServices.getWoeidsByLocation(location);
      return weather;
    } on WeatherException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}
