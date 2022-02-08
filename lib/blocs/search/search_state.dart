part of 'search_bloc.dart';

class SearchState extends Equatable {
  final bool displayMarker;

  const SearchState({this.displayMarker = false});

  SearchState copyWith({bool? displayMarker}) => SearchState(
        displayMarker: displayMarker ?? this.displayMarker,
      );

  @override
  List<Object?> get props => [displayMarker];
}
