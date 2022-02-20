part of 'search_bloc.dart';

class SearchState extends Equatable {
  final bool displayMarker;
  final List<PlaceFeature> places;
  final List<PlaceFeature> history;

  const SearchState(
      {this.history = const [],
      this.places = const [],
      this.displayMarker = false});

  SearchState copyWith(
          {bool? displayMarker,
          List<PlaceFeature>? places,
          List<PlaceFeature>? history}) =>
      SearchState(
        displayMarker: displayMarker ?? this.displayMarker,
        places: places ?? this.places,
        history: history ?? this.history,
      );

  @override
  List<Object?> get props => [displayMarker, places, history];
}
