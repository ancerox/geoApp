import 'package:geo_app/domain/entities/place_feature.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsCoating {
  final String? geometry;
  final double? distance;
  final double? duration;
  final PlaceFeature? endDestination;

  MapsCoating({
    this.endDestination,
    this.geometry,
    this.distance,
    this.duration,
  });
}
