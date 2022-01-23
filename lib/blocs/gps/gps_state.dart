part of 'gps_bloc.dart';

abstract class GpsState extends Equatable {
  final bool? gpsStates;

  const GpsState({this.gpsStates});

  @override
  List<Object> get props => [];
}

class GpsInitialState extends GpsState {
  final bool? gpsStatus;

  const GpsInitialState({this.gpsStatus});
}

class GpsIsOn extends GpsState {
  const GpsIsOn() : super();
}

class GpsIsOff extends GpsState {
  const GpsIsOff() : super();
}

class GpsPermissionIsGranted extends GpsState {
  const GpsPermissionIsGranted() : super();
}
