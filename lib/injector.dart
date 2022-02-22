import 'package:get_it/get_it.dart';

import 'data/datasources/remote/map_coating_datasoruce.dart';
import 'data/repository/map_box_repository_impl.dart';
import 'domain/repository/maps_coating_repository.dart';
import 'domain/usecases/get_coors_start_end.dart';
import 'package:dio/dio.dart';

import 'domain/usecases/get_places_by_cors.dart';
import 'domain/usecases/get_places_by_places.dart';
import 'presentation/blocs/blocs.dart';

final locator = GetIt.instance;

void setUp() {
  locator.registerLazySingleton(() => GpsBloc());

  // LocationBloc

  locator.registerFactory(() => LocationBloc());

  // MapBloc
  locator.registerFactory(() => MapBloc(
        locationBloc: locator(),
        getPlacesByCoors: locator(),
      ));

  // SearchBloc
  locator.registerFactory(() => SearchBloc(
      getPlacesByQuery: locator(),
      getCoorsStartEnd: locator(),
      mapBloc: locator()));

  // Usecases
  locator.registerLazySingleton(() => GetCoorsStartEnd(locator()));
  locator.registerLazySingleton(() => GetPlacesByQuery(locator()));
  locator.registerLazySingleton(() => GetPlacesByCoors(locator()));

  // Repository
  locator.registerLazySingleton<MapBoxRepository>(
      () => MapBoxRepositoryImpl(locator()));

// Remote DataSource
  locator.registerLazySingleton<MapCoatingRemoteDataSource>(
      () => MapCoatingRemoteDataSourceImpl());

  // Liberias Externas
  locator.registerLazySingleton(() => Dio());
}
