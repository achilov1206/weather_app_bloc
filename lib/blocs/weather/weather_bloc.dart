import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import '../../models/weather.dart';
import '../../models/custom_error.dart';
import '../../repositories/weather_repository.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepository weatherRepository;
  WeatherBloc({required this.weatherRepository})
      : super(WeatherState.initial()) {
    on<FetchWeatherEvent>(_fetchWeather);
    on<FetchWeatherByLocationEvent>(_fetchWeatherByLocation);
  }

  Future<void> _fetchWeather(
    FetchWeatherEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(state.copyWith(status: WeatherStatus.loading));
    try {
      final Weather weather = await weatherRepository.fetchWeather(event.city);
      emit(state.copyWith(
        status: WeatherStatus.loaded,
        weather: weather,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(status: WeatherStatus.error, error: e));
    }
  }

  Future<void> _fetchWeatherByLocation(
    FetchWeatherByLocationEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(state.copyWith(status: WeatherStatus.loading));
    try {
      final Weather weather =
          await weatherRepository.fetchWeatherByLocation(event.location);
      emit(state.copyWith(
        status: WeatherStatus.loaded,
        weather: weather,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(status: WeatherStatus.error, error: e));
    }
  }
}
