part of 'location_bloc.dart';

class LocationState extends Equatable {
  final bool followUser;
  final LatLng? lastKnownLocation;
  final List<LatLng> locationHistory;

  const LocationState({
    this.followUser = false,
    this.lastKnownLocation,
    locationHistory,
  }) : locationHistory = locationHistory ?? const [];

  LocationState copyWith({
    bool? followUser,
    LatLng? lastKnownLocation,
    List<LatLng>? locationHistory,
  }) =>
      LocationState(
        locationHistory: locationHistory ?? this.locationHistory,
        lastKnownLocation: lastKnownLocation ?? this.lastKnownLocation,
        followUser: followUser ?? this.followUser,
      );
  @override
  List<Object?> get props => [followUser, lastKnownLocation, locationHistory];
}
