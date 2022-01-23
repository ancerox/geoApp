import 'package:geo_app/blocs/gps/gps_bloc.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setUp() {
  locator.registerLazySingleton(() => GpsBloc());
}
