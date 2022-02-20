import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_app/blocs/blocs.dart';
import 'package:geo_app/domain/entities/place_feature.dart';
import 'package:geo_app/models/models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SeachLocationDelegate extends SearchDelegate<SearchDelegateModel> {
  SeachLocationDelegate() : super(searchFieldLabel: 'Buscar...');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          close(context, SearchDelegateModel(cancel: true));
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locatinBloc = BlocProvider.of<LocationBloc>(context);

    searchBloc.getNewsPlacesByQuery(
        locatinBloc.state.lastKnownLocation!, query);

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        final places = state.places;
        return ListView.separated(
            itemBuilder: (context, i) {
              final place = places[i];
              return ListTile(
                leading: const Icon(Icons.place_sharp),
                subtitle: Text(place.placeName),
                title: Text(place.text),
                onTap: () {
                  close(
                      context,
                      SearchDelegateModel(
                          cancel: false,
                          manual: false,
                          proximity: LatLng(place.center[1], place.center[0])));

                  searchBloc.add(OnSavePlaces(place));
                },
              );
            },
            separatorBuilder: (context, i) => const Divider(),
            itemCount: places.length);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final history = BlocProvider.of<SearchBloc>(context).state.history;
    return ListView(children: [
      ListTile(
        onTap: () {
          close(
              context, const SearchDelegateModel(cancel: false, manual: true));
        },
        title: const Text('Search for location in map'),
        leading: const Icon(Icons.location_pin),
      ),
      ...history.map((e) => ListTile(
            leading: const Icon(Icons.place_sharp),
            subtitle: Text(e.placeName),
            title: Text(e.text),
            onTap: () {
              close(
                  context,
                  SearchDelegateModel(
                      cancel: false,
                      manual: false,
                      proximity: LatLng(e.center[1], e.center[0])));
            },
          ))
    ]);
  }
}
