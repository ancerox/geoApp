import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class SearchDelegateModel {
  final bool cancel;
  final bool manual;
  final LatLng? proximity;

  const SearchDelegateModel(
      {this.proximity, required this.cancel, this.manual = false});
}
