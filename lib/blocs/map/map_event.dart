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
