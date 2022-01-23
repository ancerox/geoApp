part of 'gps_bloc.dart';

abstract class GpsEvent extends Equatable {
  const GpsEvent();

  @override
  List<Object> get props => [];
}

class TurnOnGps extends GpsEvent {
  final bool? gpsState;

  const TurnOnGps({this.gpsState});
}

class TurnOffGps extends GpsEvent {
  const TurnOffGps();
}

class AllowGpsAccessEvent extends GpsEvent {}
