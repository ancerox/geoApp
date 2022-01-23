import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  StreamSubscription? streamSubscription;

  GpsBloc() : super(const GpsInitialState(gpsStatus: false)) {
    on<TurnOnGps>((event, emit) {
      emit(const GpsIsOn());
    });
    on<TurnOffGps>((event, emit) {
      emit(const GpsIsOff());
    });
    on<AllowGpsAccessEvent>((event, emit) {
      emit(const GpsPermissionIsGranted());
    });

    init();
  }

  Future<void> init() async {
    _gpsStatus().then((_) => _gpsPermissionStatus());
  }

  Future<void> askGpsAccess() async {
    final permissionStatus = await Permission.location.request();

    switch (permissionStatus) {
      case PermissionStatus.granted:
        add(AllowGpsAccessEvent());
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
    }
  }

  Future<void> _gpsStatus() async {
    streamSubscription = Geolocator.getServiceStatusStream().listen((event) {
      event.index == 1 ? add(const TurnOnGps()) : add(const TurnOffGps());
    });

    final isEnabled = await Geolocator.isLocationServiceEnabled();

    if (isEnabled == true) {
      add(const TurnOnGps());
    } else {
      add(const TurnOffGps());
    }
  }

  Future<void> _gpsPermissionStatus() async {
    final statusIsGranted = await Permission.location.isGranted;

    if (statusIsGranted) {
      add(AllowGpsAccessEvent());
    }
  }

  @override
  Future<void> close() async {
    streamSubscription?.cancel();
    return super.close();
  }
}
