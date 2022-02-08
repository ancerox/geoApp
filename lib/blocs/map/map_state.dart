part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapEnabled;
  final bool followUser;
  final Map<String, Polyline> polylines;
  final bool showPolylines;

  const MapState(
      {this.isMapEnabled = false,
      this.followUser = false,
      this.showPolylines = true,
      Map<String, Polyline>? polylines})
      : polylines = polylines ?? const {};

  MapState copyWith(
          {bool? isMapEnabled,
          bool? followUser,
          Map<String, Polyline>? polylines,
          bool? showPolylines}) =>
      MapState(
          isMapEnabled: isMapEnabled ?? this.isMapEnabled,
          followUser: followUser ?? this.followUser,
          polylines: polylines ?? this.polylines,
          showPolylines: showPolylines ?? this.showPolylines);

  @override
  List<Object> get props =>
      [isMapEnabled, followUser, polylines, showPolylines];
}
