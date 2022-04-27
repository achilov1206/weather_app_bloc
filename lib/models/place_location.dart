import 'package:equatable/equatable.dart';

class PlaceLocation extends Equatable {
  final double latitude;
  final double longitude;
  const PlaceLocation({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [latitude, longitude];

  @override
  String toString() =>
      'PlaceLocation(latitude: $latitude, longitude: $longitude)';
}
