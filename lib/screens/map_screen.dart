import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_app/blocs/blocs.dart';
import 'package:geo_app/views/views.dart';
import 'package:geo_app/widgets/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.startFollowUser();
  }

  @override
  void dispose() {
    locationBloc.stopFollowUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: const BtnLocation(),
        body: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            if (state.lastKnownLocation == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Stack(
                children: [
                  MapView(initalLocation: state.lastKnownLocation!),
                ],
              ),
            );
          },
        ));
  }
}
