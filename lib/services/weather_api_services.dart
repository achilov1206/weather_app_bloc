import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import './http_error_handler.dart';
import '../models/weather.dart';
import '../models/locations.dart';
import '../exceptions/weather_exception.dart';
import '../constants/constants.dart';

class WeatherApiServices {
  final http.Client httpClient;
  WeatherApiServices({
    required this.httpClient,
  });

  Future<int> getWoeid(String city) async {
    final Uri uri = Uri(
      scheme: kScheme,
      host: kHost,
      path: kGetWoeidPath,
      queryParameters: {'query': city},
    );
    try {
      final http.Response response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }
      final responseBody = json.decode(response.body);
      if (responseBody.isEmpty) {
        throw WeatherException('Cannot get the woeid of $city');
      }
      if (responseBody.length > 1) {
        throw WeatherException(
            'There are multiple candidates for $city\nPlease specify further');
      }
      return responseBody[0]['woeid'];
    } catch (e) {
      rethrow;
    }
  }

  Future<Weather> getWeather(int woeid) async {
    final Uri uri = Uri(
      scheme: kScheme,
      host: kHost,
      path: '/api/location/$woeid',
    );

    try {
      final http.Response response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }
      final weatherJson = json.decode(response.body);
      final Weather weather = Weather.fromJson(weatherJson);

      return weather;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Locations>> getWoeidsByLocation(LatLng location) async {
    double lat = location.latitude;
    double lon = location.longitude;
    final Uri uri = Uri(
      scheme: kScheme,
      host: kHost,
      path: '/api/location/search',
      queryParameters: {'lattlong': '$lat,$lon'},
    );

    try {
      final http.Response response = await http.get(uri);
      List<Locations> locations = [];
      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }
      List jsonData = json.decode(response.body);
      for (Map<String, dynamic> data in jsonData) {
        final Locations loc = Locations.fromMap(data);
        locations.add(loc);
      }
      return locations;
    } catch (e) {
      rethrow;
    }
  }
}
