import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geo_app/blocs/location/location_bloc.dart';
import 'package:geo_app/themes/themes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;

  GoogleMapController? mapController;

  StreamSubscription<LocationBloc>? streamSubscriptionBloc;

  MapBloc({required this.locationBloc}) : super(const MapState()) {
    on<OnMapCreatedEvent>(_mapInit);
    on<OnFollowingUserState>(
        (event, emit) => emit(state.copyWith(followUser: true)));
    on<OffFollowingUserState>(
        (event, emit) => emit(state.copyWith(followUser: false)));

    on<OnNewPolyLines>(_onNewPolyLines);

    on<OnTogglePolylines>((event, emit) {
      emit(state.copyWith(showPolylines: !state.showPolylines));
    });

    locationBloc.stream.listen((locationState) {
      if (locationState.lastKnownLocation == null) return;
      add(OnNewPolyLines(locationState.locationHistory));

      if (state.followUser == false) return;
      centerMap(locationState.lastKnownLocation!);
    });
  }

  void _onNewPolyLines(OnNewPolyLines event, Emitter<MapState> emit) {
    final myRoute = Polyline(
        polylineId: const PolylineId('myRoute'),
        endCap: Cap.roundCap,
        startCap: Cap.roundCap,
        color: Colors.black,
        width: 9,
        points: event.userLocations);

    final currentPolylines = Map<String, Polyline>.from(state.polylines);

    currentPolylines['myRoute'] = myRoute;

    emit(state.copyWith(polylines: currentPolylines));
  }

  void _mapInit(OnMapCreatedEvent event, Emitter<MapState> emit) {
    mapController = event.mapController;
    mapController!.setMapStyle(jsonEncode(grayscaleStyle));
    emit(state.copyWith(isMapEnabled: true));
  }

  void centerMap(LatLng cameraUpdateLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(cameraUpdateLocation);

    mapController?.moveCamera(cameraUpdate);
  }

  @override
  Future<void> close() {
    streamSubscriptionBloc?.cancel();
    return super.close();
  }
}
