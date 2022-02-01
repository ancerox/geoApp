import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geo_app/themes/themes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  GoogleMapController? mapController;

  MapBloc() : super(const MapState()) {
    on<OnMapCreatedEvent>(_mapInit);
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
}
