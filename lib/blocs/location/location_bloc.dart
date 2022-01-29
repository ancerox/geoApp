import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription? locationStream;

  LocationBloc() : super(const LocationState()) {
    on<OnFollowingUser>((event, emit) {
      emit(state.copyWith(followUser: true));
    });
    on<OffFollowingUser>((event, emit) {
      emit(state.copyWith(followUser: false));
    });

    on<OnNewUserLocationEvent>((event, emit) {
      emit(state.copyWith(
          lastKnownLocation: event.newLocation,
          locationHistory: [...state.locationHistory, event.newLocation]));
    });
  }

  Future getCurrentLocation() async {
    final location = await Geolocator.getCurrentPosition();
    add(
      OnNewUserLocationEvent(
        LatLng(location.latitude, location.longitude),
      ),
    );
  }

  void startFollowUser() {
    Geolocator.getPositionStream().listen((event) {
      final position = event;
      add(
        OnNewUserLocationEvent(
          LatLng(position.latitude, position.longitude),
        ),
      );
    });
  }

  void stopFollowUser() {
    locationStream?.cancel();
    print('User is not Follow anymore');
  }

  @override
  Future<void> close() {
    stopFollowUser();
    return super.close();
  }
}
