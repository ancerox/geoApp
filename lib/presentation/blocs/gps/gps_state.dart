part of 'gps_bloc.dart';

class GpsState extends Equatable {
  final bool? gpsStates;
  final bool? isPermitionGranted;

  const GpsState({this.gpsStates, this.isPermitionGranted});

  GpsState copyWith({bool? gpsStates, bool? isPermitionGranted}) => GpsState(
        gpsStates: gpsStates ?? this.gpsStates,
        isPermitionGranted: isPermitionGranted ?? this.isPermitionGranted,
      );

  @override
  List<Object?> get props => [gpsStates, isPermitionGranted];
}
