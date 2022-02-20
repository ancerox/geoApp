import 'package:geo_app/core/erros/failure.dart';

import 'package:geo_app/domain/entities/place_feature.dart';
import 'package:geo_app/domain/repository/maps_coating_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dartz/dartz.dart';

class GetPlacesByQuery {
  final MapBoxRepository mapBoxRepository;

  const GetPlacesByQuery(this.mapBoxRepository);

  Future<Either<Failure, List<PlaceFeature>>> call(
      LatLng proximity, String query) async {
    return await mapBoxRepository.getPlacesByQuery(proximity, query);
  }
}
