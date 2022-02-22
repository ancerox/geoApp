import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:geo_app/core/erros/failure.dart';
import 'package:geo_app/domain/entities/maps_coating_entity.dart';
import 'package:geo_app/domain/entities/place_feature.dart';
import 'package:geo_app/helpers/bitmark.dart';
import 'package:geo_app/helpers/widget_to_,marker.dart';
import 'package:geo_app/presentation/blocs/blocs.dart';
import 'package:geo_app/themes_map/themes.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:dartz/dartz.dart';
import 'package:geo_app/domain/usecases/get_places_by_cors.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;
  LatLng? mapCenter;
  GoogleMapController? mapController;
  final GetPlacesByCoors getPlacesByCoors;
  StreamSubscription<LocationState>? streamSubscriptionBloc;

  MapBloc({required this.getPlacesByCoors, required this.locationBloc})
      : super(const MapState()) {
    _initGpsImage();
    on<OnEmitGpsIcon>(
        (event, emit) => emit(state.copyWith(gpsIcon: event.gpsIcon)));
    on<OnMapCreatedEvent>(_mapInit);
    on<OnFollowingUserState>(
        (event, emit) => emit(state.copyWith(followUser: true)));
    on<OffFollowingUserState>(
        (event, emit) => emit(state.copyWith(followUser: false)));

    on<OnNewPolyLines>(_onNewPolyLines);

    on<OnDrawnewPolylines>((event, emit) => {
          emit(state.copyWith(
              polylines: event.polylines, markers: event.markers))
        });

    on<OnTogglePolylines>((event, emit) {
      emit(state.copyWith(showPolylines: !state.showPolylines));
    });

    locationBloc.stream.listen((locationState) {
      if (!state.followUser) return;
      if (locationState.lastKnownLocation == null) return;
      add(OnNewPolyLines(locationState.locationHistory));
      centerMap(locationState.lastKnownLocation!);
    });
  }

  Future<void> drawPolylines(MapsCoating mapCoating) async {
    final points = decodePolyline(mapCoating.geometry!, accuracyExponent: 6);
    final polylinesList = points
        .map((coor) => LatLng(coor[0].toDouble(), coor[1].toDouble()))
        .toList();
    final Either<Failure, PlaceFeature> placeResponse =
        await getPlacesByCoors(polylinesList.last);

    double kms = mapCoating.distance! / 1000;
    kms = (kms * 100).floorToDouble();
    kms /= 100;

    int tripDuration = (mapCoating.duration! / 60).floorToDouble().toInt();

    final place = placeResponse.fold((l) => null, (r) => r);
    final startMarker = await getStartCustomMarker(tripDuration, 'My Location');
    final endMarker = await getEndCustomMarker(kms.toInt(), place!.text);

    final initialmarker = Marker(
      anchor: const Offset(0.1, 1),
      icon: startMarker,
      markerId: const MarkerId('start'),
      position: polylinesList.first,
    );
    final lastmarker = Marker(
        icon: endMarker,
        markerId: const MarkerId('end'),
        position: polylinesList.last,
        infoWindow: InfoWindow(title: place.text, snippet: place.placeName));

    final myRoute = Polyline(
        polylineId: const PolylineId('route'),
        color: Colors.black,
        endCap: Cap.roundCap,
        startCap: Cap.roundCap,
        width: 5,
        points: polylinesList);

    final polylines = Map<String, Polyline>.from(state.polylines);
    final markers = Map<String, Marker>.from(state.markers);
    markers['start'] = initialmarker;
    markers['end'] = lastmarker;

    polylines['route'] = myRoute;
    add(OnDrawnewPolylines(polylines: polylines, markers: markers));
  }

  void _onNewPolyLines(OnNewPolyLines event, Emitter<MapState> emit) {
    final myRoute = Polyline(
        polylineId: const PolylineId('myRoute'),
        endCap: Cap.roundCap,
        startCap: Cap.roundCap,
        color: Colors.black,
        width: 5,
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

  void _initGpsImage() async {
    final icondata = await getGpsAssetImage();
    final bitdescriptor = BitmapDescriptor.fromBytes(icondata);

    add(OnEmitGpsIcon(bitdescriptor));
  }

  @override
  Future<void> close() {
    streamSubscriptionBloc?.cancel();
    return super.close();
  }
}
