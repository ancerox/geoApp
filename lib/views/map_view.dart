import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_app/blocs/blocs.dart';
import 'package:geo_app/helpers/bitmark.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final size = MediaQuery.of(context).size;

    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, locationState) {
        if (locationState.lastKnownLocation == null) {
          return const Center(child: Text('Espere por favor...'));
        }
        final cameraPositon =
            CameraPosition(target: locationState.lastKnownLocation!, zoom: 15);

        return BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            // final marker = Marker(
            //     anchor: const Offset(0, 0),
            //     rotation: (0.1),
            //     markerId: const MarkerId('gps'),
            //     icon: mapBloc.state.gpsIcon!,
            //     position: LatLng(locationState.lastKnownLocation!.latitude,
            //         locationState.lastKnownLocation!.longitude));

            // final markers = Map<String, Marker>.from(mapBloc.state.markers);
            // markers['gps'] = marker;
            // mapBloc.add(OnDrawnewPolylines(markers: markers));

            final Map<String, Polyline> polylines = Map.from(state.polylines);

            if (!state.showPolylines) {
              polylines.removeWhere((key, value) => key == 'myRoute');
            }

            return SizedBox(
              height: size.height,
              width: size.width,
              child: Listener(
                onPointerMove: (onPointerMove) {
                  mapBloc.add(OffFollowingUserState());
                },
                child: GoogleMap(
                  polylines: polylines.values.toSet(),
                  markers: state.markers.values.toSet(),
                  onMapCreated: (controller) =>
                      mapBloc.add(OnMapCreatedEvent(controller)),
                  initialCameraPosition: cameraPositon,
                  compassEnabled: false,
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  onCameraMove: (position) =>
                      mapBloc.mapCenter = position.target,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
