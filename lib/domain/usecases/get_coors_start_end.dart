import 'package:geo_app/core/erros/failure.dart';
import 'package:geo_app/data/models/search_responde_model.dart';
import 'package:geo_app/domain/entities/maps_coating_entity.dart';
import 'package:geo_app/domain/repository/maps_coating_repository.dart';
import 'package:dartz/dartz.dart';

class GetCoorsStartEnd {
  final MapBoxRepository mapCoatingRepository;

  GetCoorsStartEnd(this.mapCoatingRepository);

  Future<Either<Failure, MapsCoating>> call(start, end) async {
    return mapCoatingRepository.getCoorsStartToEnd(start, end);
  }
}
