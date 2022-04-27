import 'dart:convert';

import 'package:equatable/equatable.dart';

class Locations extends Equatable {
  final int distance;
  final String title;
  final String locationType;
  final int woeid;
  final String lattLong;
  const Locations({
    required this.distance,
    required this.title,
    required this.locationType,
    required this.woeid,
    required this.lattLong,
  });

  @override
  List<Object?> get props => [distance, title, locationType, woeid, lattLong];

  @override
  String toString() {
    return 'Locations(distance: $distance, title: $title, locationType: $locationType, woeid: $woeid, lattLong: $lattLong)';
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'distance': distance});
    result.addAll({'title': title});
    result.addAll({'location_type': locationType});
    result.addAll({'woeid': woeid});
    result.addAll({'latt_long': lattLong});

    return result;
  }

  factory Locations.fromMap(Map<String, dynamic> map) {
    return Locations(
      distance: map['distance']?.toInt() ?? 0,
      title: map['title'] ?? '',
      locationType: map['location_type'] ?? '',
      woeid: map['woeid']?.toInt() ?? 0,
      lattLong: map['latt_long'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Locations.fromJson(String source) =>
      Locations.fromMap(json.decode(source));
}
