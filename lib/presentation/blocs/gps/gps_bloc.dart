import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  StreamSubscription? streamSubscription;

  GpsBloc()
      : super(const GpsState(gpsStates: false, isPermitionGranted: false)) {
    on<ChangeGpsState>((event, emit) {
      emit(state.copyWith(gpsStates: event.gpsState));
    });

    on<ChangeGpsAccess>((event, emit) {
      emit(state.copyWith(isPermitionGranted: event.isGranted));
    });

    init();
  }

  Future<void> init() async {
    await _gpsStatus().then((_) => _gpsPermissionStatus());
  }

  Future<void> askGpsAccess() async {
    final permissionStatus = await Permission.location.request();

    switch (permissionStatus) {
      case PermissionStatus.granted:
        add(const ChangeGpsAccess(isGranted: true));
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        add(const ChangeGpsAccess(isGranted: false));
        openAppSettings();
    }
  }

  Future<void> _gpsStatus() async {
    streamSubscription = Geolocator.getServiceStatusStream().listen((event) {
      event.index == 1
          ? add(const ChangeGpsState(gpsState: true))
          : add(const ChangeGpsState(gpsState: false));
    });

    final isEnabled = await Geolocator.isLocationServiceEnabled();

    if (isEnabled == true) {
      add(const ChangeGpsState(gpsState: true));
    } else {
      add(const ChangeGpsState(gpsState: false));
    }
  }

  Future<void> _gpsPermissionStatus() async {
    final statusIsGranted = await Permission.location.isGranted;

    if (statusIsGranted) {
      // add(const ChangeGpsState(gpsState: false));
      // print('test');
      add(const ChangeGpsAccess(isGranted: true));
    }
  }

  @override
  Future<void> close() async {
    streamSubscription?.cancel();
    return super.close();
  }
}
