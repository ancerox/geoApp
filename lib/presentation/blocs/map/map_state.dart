part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapEnabled;
  final bool followUser;
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;
  final bool showPolylines;
  final BitmapDescriptor? gpsIcon;

  const MapState(
      {this.gpsIcon,
      this.isMapEnabled = false,
      this.followUser = false,
      this.showPolylines = true,
      Map<String, Marker>? markers,
      Map<String, Polyline>? polylines})
      : polylines = polylines ?? const {},
        markers = markers ?? const {};

  MapState copyWith(
          {BitmapDescriptor? gpsIcon,
          bool? isMapEnabled,
          bool? followUser,
          Map<String, Polyline>? polylines,
          Map<String, Marker>? markers,
          bool? showPolylines}) =>
      MapState(
        isMapEnabled: isMapEnabled ?? this.isMapEnabled,
        followUser: followUser ?? this.followUser,
        polylines: polylines ?? this.polylines,
        showPolylines: showPolylines ?? this.showPolylines,
        markers: markers ?? this.markers,
        gpsIcon: gpsIcon ?? this.gpsIcon,
      );

  @override
  List<Object?> get props =>
      [isMapEnabled, followUser, polylines, showPolylines, markers, gpsIcon];
}
