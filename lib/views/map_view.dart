import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_app/blocs/blocs.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatelessWidget {
  final LatLng initalLocation;
  final Set<Polyline> polylines;

  const MapView(
      {Key? key, required this.initalLocation, required this.polylines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cameraPositon = CameraPosition(target: initalLocation, zoom: 15);
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: Listener(
        onPointerMove: (onPointerMove) {
          mapBloc.add(OffFollowingUserState());
        },
        child: GoogleMap(
          polylines: polylines,
          onMapCreated: (controller) =>
              mapBloc.add(OnMapCreatedEvent(controller)),
          initialCameraPosition: cameraPositon,
          compassEnabled: false,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
        ),
      ),
    );
  }
}
