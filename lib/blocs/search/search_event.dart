part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnShowMarkEvent extends SearchEvent {}

class OffShowMarkEvent extends SearchEvent {}

class OnLookForPlaces extends SearchEvent {
  final List<PlaceFeature> places;

  const OnLookForPlaces(this.places);
}

class OnSavePlaces extends SearchEvent {
  final PlaceFeature place;

  const OnSavePlaces(this.place);
}
