part of 'weather_bloc.dart';

enum WeatherStatus {
  initial,
  loading,
  loaded,
  error,
}

class WeatherState extends Equatable {
  final WeatherStatus status;
  final Weather weather;
  final List<Locations> locations;
  final CustomError error;
  const WeatherState({
    required this.status,
    required this.weather,
    required this.error,
    required this.locations,
  });

  factory WeatherState.initial() {
    return WeatherState(
      status: WeatherStatus.initial,
      weather: Weather.initial(),
      error: CustomError(),
      locations: const [],
    );
  }

  @override
  List<Object?> get props => [status, weather, error, locations];
  @override
  bool get stringify => true;

  WeatherState copyWith({
    WeatherStatus? status,
    Weather? weather,
    CustomError? error,
    List<Locations>? locations,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
      error: error ?? this.error,
      locations: locations ?? this.locations,
    );
  }
}
