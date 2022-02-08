import 'package:flutter/material.dart';
import 'package:geo_app/models/models.dart';

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
    return Text('testat');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(children: [
      ListTile(
        onTap: () {
          close(context, SearchDelegateModel(cancel: false, manual: true));
        },
        title: Text('Search for location in map'),
        leading: Icon(Icons.location_pin),
      ),
    ]);
  }
}
