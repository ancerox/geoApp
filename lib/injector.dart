import 'package:geo_app/blocs/blocs.dart';

import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setUp() {
  locator.registerLazySingleton(() => GpsBloc());
  // locator.registerLazySingleton(() => MapBloc());
}
