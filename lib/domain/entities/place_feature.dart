import 'package:equatable/equatable.dart';

class PlaceFeature extends Equatable {
  const PlaceFeature({
    required this.id,
    required this.type,
    required this.placeType,
    required this.relevance,
    required this.text,
    required this.placeName,
    required this.center,
  });

  final String id;
  final String type;
  final List<String> placeType;
  final dynamic? relevance;

  final String text;
  final String placeName;
  final List<double> center;

  @override
  List<Object?> get props =>
      [id, type, placeType, relevance, text, placeName, center];
}
