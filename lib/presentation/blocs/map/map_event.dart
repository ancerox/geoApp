part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapCreatedEvent extends MapEvent {
  final GoogleMapController? mapController;

  const OnMapCreatedEvent(this.mapController);
}

class OnFollowingUserState extends MapEvent {}

class OffFollowingUserState extends MapEvent {}

class OnNewPolyLines extends MapEvent {
  final List<LatLng> userLocations;
  const OnNewPolyLines(this.userLocations);
}

class OnTogglePolylines extends MapEvent {}

class OnDrawnewPolylines extends MapEvent {
  final Map<String, Polyline>? polylines;
  final Map<String, Marker>? markers;

  const OnDrawnewPolylines({this.markers, this.polylines});
}

class OnEmitGpsIcon extends MapEvent {
  final BitmapDescriptor gpsIcon;

  const OnEmitGpsIcon(this.gpsIcon);
}
