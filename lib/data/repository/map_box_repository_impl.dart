import 'package:geo_app/core/exeptions/server_exeptions.dart';
import 'package:geo_app/data/datasources/remote/map_coating_datasoruce.dart';
import 'package:geo_app/data/models/palces_by_query.dart';
import 'package:geo_app/data/models/search_responde_model.dart';
import 'package:geo_app/domain/entities/maps_coating_entity.dart';
import 'package:geo_app/core/erros/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:geo_app/domain/entities/place_feature.dart';
import 'package:geo_app/domain/repository/maps_coating_repository.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';

class MapBoxRepositoryImpl extends MapBoxRepository {
  final MapCoatingRemoteDataSource mapCoatingRemoteDataSource;

  MapBoxRepositoryImpl(this.mapCoatingRemoteDataSource);

  @override
  Future<Either<Failure, MapsCoating>> getCoorsStartToEnd(
      LatLng start, LatLng end) async {
    try {
      TrafficResponse mapsCoating =
          await mapCoatingRemoteDataSource.requestMapCoating(start, end);

      return Right(mapsCoating);
    } on ServerException {
      return const Left(ServerFailure(
        message: 'Ha ocurrido un error al obtener los datos del sevidor',
      ));
    }
  }

  @override
  Future<Either<Failure, List<PlaceFeature>>> getPlacesByQuery(
      LatLng proximity, String query) async {
    try {
      List<Feature> mapCoating = await mapCoatingRemoteDataSource
          .requestPlacesbyQuery(proximity, query);
      return Right(mapCoating);
    } on ServerException {
      return const Left(ServerFailure(
          message: 'Ha ocurrido un error al obtener los datos del sevidor'));
    }
  }

  @override
  Future<Either<Failure, PlaceFeature>> getPlacesByCoors(LatLng coors) async {
    try {
      Feature placeFeature =
          await mapCoatingRemoteDataSource.requrestPlaceByCoors(coors);
      return Right(placeFeature);
    } on ServerException {
      return const Left(ServerFailure(
          message: 'Ha ocurrido un error al obtener los datos del sevidor'));
    }
  }
}
