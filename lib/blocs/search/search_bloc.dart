import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchState()) {
    on<OnShowMarkEvent>(
        (event, emit) => emit(state.copyWith(displayMarker: true)));
    on<OffShowMarkEvent>(
        (event, emit) => emit(state.copyWith(displayMarker: false)));
  }
}
