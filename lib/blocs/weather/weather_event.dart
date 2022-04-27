part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchWeatherEvent extends WeatherEvent {
  final String city;
  const FetchWeatherEvent({
    required this.city,
  });
}

class FetchWoeidsByLocationEvent extends WeatherEvent {
  final LatLng location;
  const FetchWoeidsByLocationEvent({
    required this.location,
  });
}
