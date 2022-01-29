part of 'gps_bloc.dart';

abstract class GpsEvent extends Equatable {
  const GpsEvent();

  @override
  List<Object> get props => [];
}

class ChangeGpsState extends GpsEvent {
  final bool? gpsState;

  const ChangeGpsState({this.gpsState});
}

class ChangeGpsAccess extends GpsEvent {
  final bool? isGranted;

  const ChangeGpsAccess({this.isGranted}) : super();
}
