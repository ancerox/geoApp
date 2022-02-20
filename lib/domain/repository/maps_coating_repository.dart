import 'package:geo_app/core/erros/failure.dart';
import 'package:dartz/dartz.dart';

import 'package:geo_app/domain/entities/maps_coating_entity.dart';
import 'package:geo_app/domain/entities/place_feature.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapBoxRepository {
  Future<Either<Failure, MapsCoating>> getCoorsStartToEnd(
      LatLng start, LatLng end);

  Future<Either<Failure, List<PlaceFeature>>> getPlacesByQuery(
      LatLng proximity, String query);

  Future<Either<Failure, PlaceFeature>> getPlacesByCoors(LatLng coors);
}
