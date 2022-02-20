import 'package:geo_app/core/erros/failure.dart';
import 'package:geo_app/domain/entities/place_feature.dart';
import 'package:geo_app/domain/repository/maps_coating_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dartz/dartz.dart';

class GetPlacesByCoors {
  final MapBoxRepository mapBoxRepository;

  GetPlacesByCoors(this.mapBoxRepository);

  Future<Either<Failure, PlaceFeature>> call(LatLng coors) {
    return mapBoxRepository.getPlacesByCoors(coors);
  }
}
