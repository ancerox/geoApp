import 'package:geo_app/data/models/palces_by_query.dart';
import 'package:geo_app/data/models/search_responde_model.dart';
import 'package:dio/dio.dart';
import 'package:geo_app/intersertors/places_interceptor.dart';
import 'package:geo_app/intersertors/trafic_interceotor.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapCoatingRemoteDataSource {
  Future<TrafficResponse> requestMapCoating(LatLng start, LatLng end);
  Future requestPlacesbyQuery(LatLng proximity, String query);
  Future requrestPlaceByCoors(LatLng coors);
}

class MapCoatingRemoteDataSourceImpl extends MapCoatingRemoteDataSource {
  final Dio _dioTraffic;
  final Dio _dioPlaces;

  final String _baseTraficUrl = 'https://api.mapbox.com/directions/v5/mapbox';
  final String _basePlacesUrl =
      'https://api.mapbox.com/geocoding/v5/mapbox.places';

  MapCoatingRemoteDataSourceImpl()
      : _dioTraffic = Dio()..interceptors.add(TrafficInterceptor()),
        _dioPlaces = Dio()..interceptors.add(PlacesInterceptor());

  @override
  Future<TrafficResponse> requestMapCoating(LatLng start, LatLng end) async {
    final coorsString =
        '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';
    final url = '$_baseTraficUrl/driving/$coorsString';
    final resp = await _dioTraffic.get(url);
    final data = TrafficResponse.fromMap(resp.data);

    return data;
  }

  @override
  Future<List<Feature>> requestPlacesbyQuery(
      LatLng proximity, String query) async {
    final url = '$_basePlacesUrl/$query.json';

    final resp = await _dioPlaces.get(url, queryParameters: {
      'proximity': '${proximity.longitude},${proximity.latitude}',
      'limit': 10,
    });

    final placesResponse = NearPlacesresponse.fromJson(resp.data);

    return placesResponse.features;
  }

  @override
  Future<Feature> requrestPlaceByCoors(LatLng coors) async {
    final url = '$_basePlacesUrl/${coors.longitude},${coors.latitude}.json';
    final response = await _dioPlaces.get(url, queryParameters: {'limit': 1});

    final nearPlacesresponse = NearPlacesresponse.fromJson(response.data);

    return nearPlacesresponse.features[0];
  }
}
