import 'package:geo_app/domain/entities/maps_coating_entity.dart';
import 'package:geo_app/domain/entities/place_feature.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class NearPlacesresponse {
  NearPlacesresponse({
    required this.type,
    // required this.query,
    required this.features,
    required this.attribution,
  });

  final String type;
  // final List<String> query;
  final List<Feature> features;
  final String attribution;

  factory NearPlacesresponse.fromJson(String str) =>
      NearPlacesresponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NearPlacesresponse.fromMap(Map<String, dynamic> json) =>
      NearPlacesresponse(
        type: json["type"],
        // query: List<String>.from(json["query"].map((x) => x)),
        features:
            List<Feature>.from(json["features"].map((x) => Feature.fromMap(x))),
        attribution: json["attribution"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        // "query": List<dynamic>.from(query.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toMap())),
        "attribution": attribution,
      };
}

class Feature extends PlaceFeature {
  const Feature({
    required String id,
    required String type,
    required List<String> placeType,
    required dynamic? relevance,
    required this.properties,
    required String text,
    required String placeName,
    required List<double> center,
    required this.geometry,
    required this.context,
  }) : super(
          id: id,
          center: center,
          type: type,
          placeType: placeType,
          relevance: relevance,
          text: text,
          placeName: placeName,
        );

  final Properties properties;

  final Geometry geometry;
  final List<Context> context;

  factory Feature.fromJson(String str) => Feature.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Feature.fromMap(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        relevance: json["relevance"],
        properties: Properties.fromMap(json["properties"]),
        text: json["text"],
        placeName: json["place_name"],
        center: List<double>.from(json["center"].map((x) => x.toDouble())),
        geometry: Geometry.fromMap(json["geometry"]),
        context:
            List<Context>.from(json["context"].map((x) => Context.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        // "place_type": List<dynamic>.from(placeType.map((x) => x)),
        "relevance": relevance,
        "properties": properties.toMap(),
        "text": text,
        "place_name": placeName,
        // "center": List<dynamic>.from(center.map((x) => x)),
        "geometry": geometry.toMap(),
        "context": List<dynamic>.from(context.map((x) => x.toMap())),
      };
}

class Context {
  Context({
    required this.id,
    required this.text,
    required this.wikidata,
    required this.shortCode,
  });

  final String id;
  final String text;
  final String? wikidata;
  final String? shortCode;

  factory Context.fromJson(String str) => Context.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Context.fromMap(Map<String, dynamic> json) => Context(
        id: json["id"],
        text: json["text"],
        wikidata: json["wikidata"],
        shortCode: json["short_code"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "text": text,
        "wikidata": wikidata,
        "short_code": shortCode,
      };
}

enum ShortCode { DO_01, DO }

final shortCodeValues =
    EnumValues({"do": ShortCode.DO, "DO-01": ShortCode.DO_01});

enum Wikidata { Q34820, Q2499228, Q786 }

final wikidataValues = EnumValues({
  "Q2499228": Wikidata.Q2499228,
  "Q34820": Wikidata.Q34820,
  "Q786": Wikidata.Q786
});

class Geometry {
  Geometry({
    required this.coordinates,
    required this.type,
  });

  final List<double> coordinates;
  final String type;

  factory Geometry.fromJson(String str) => Geometry.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Geometry.fromMap(Map<String, dynamic> json) => Geometry(
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "type": type,
      };
}

class Properties {
  Properties({
    required this.foursquare,
    required this.landmark,
    required this.address,
    required this.category,
  });

  final String? foursquare;
  final bool? landmark;
  final String? address;
  final String? category;

  factory Properties.fromJson(String str) =>
      Properties.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Properties.fromMap(Map<String, dynamic> json) => Properties(
        foursquare: json["foursquare"],
        landmark: json["landmark"],
        address: json["address"],
        category: json["category"],
      );

  Map<String, dynamic> toMap() => {
        "foursquare": foursquare,
        "landmark": landmark,
        "address": address,
        "category": category,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));

    return reverseMap!;
  }
}
