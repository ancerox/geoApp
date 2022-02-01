part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapEnabled;
  final bool followUser;

  const MapState({this.isMapEnabled = false, this.followUser = true});

  MapState copyWith({bool? isMapEnabled, bool? followUser}) => MapState(
        isMapEnabled: isMapEnabled ?? this.isMapEnabled,
        followUser: followUser ?? this.followUser,
      );

  @override
  List<Object> get props => [];
}
