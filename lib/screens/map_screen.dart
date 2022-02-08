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
        // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            BtnLocation(),
            SizedBox(height: 10),
            BtnFollowUser(),
            SizedBox(height: 10),
            TogglePolylines(),
          ],
        ),
        body: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, locationState) {
            if (locationState.lastKnownLocation == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return BlocBuilder<MapBloc, MapState>(
              builder: (context, mapState) {
                final Map<String, Polyline> polylines =
                    Map.from(mapState.polylines);
                if (!mapState.showPolylines) {
                  polylines.removeWhere((key, value) => key == 'myRoute');
                }

                return SingleChildScrollView(
                  child: Stack(
                    children: [
                      MapView(
                          polylines: polylines.values.toSet(),
                          initalLocation: locationState.lastKnownLocation!),
                      const SearchBar(),
                      const LocationMark(),
                    ],
                  ),
                );
              },
            );
          },
        ));
  }
}
