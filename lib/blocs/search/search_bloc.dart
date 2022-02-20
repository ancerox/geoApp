import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geo_app/blocs/map/map_bloc.dart';
import 'package:geo_app/core/erros/failure.dart';
import 'package:geo_app/domain/entities/maps_coating_entity.dart';
import 'package:geo_app/domain/entities/place_feature.dart';
import 'package:geo_app/domain/usecases/get_coors_start_end.dart';
import 'package:geo_app/domain/usecases/get_places_by_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dartz/dartz.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetCoorsStartEnd getCoorsStartEnd;
  final GetPlacesByQuery getPlacesByQuery;
  final MapBloc mapBloc;

  SearchBloc(
      {required this.getPlacesByQuery,
      required this.getCoorsStartEnd,
      required this.mapBloc})
      : super(const SearchState()) {
    on<OnShowMarkEvent>(
        (event, emit) => emit(state.copyWith(displayMarker: true)));
    on<OffShowMarkEvent>(
        (event, emit) => emit(state.copyWith(displayMarker: false)));

    on<OnLookForPlaces>(
        (event, emit) => emit(state.copyWith(places: event.places)));
    on<OnSavePlaces>((event, emit) => {
          emit(state.copyWith(history: [event.place, ...state.history]))
        });
  }
  Future getNewsCorsStartEnd(LatLng? start, LatLng? end) async {
    Either<Failure, MapsCoating> data = await getCoorsStartEnd(start, end);

    return data.fold((l) => null, (mapsCoating) => mapsCoating);
  }

  Future getNewsPlacesByQuery(LatLng proximity, String query) async {
    final Either<Failure, List<PlaceFeature>> data =
        await getPlacesByQuery(proximity, query);

    return data.fold(
        (l) => print(l), (plaseFeature) => add(OnLookForPlaces(plaseFeature)));
  }
}
