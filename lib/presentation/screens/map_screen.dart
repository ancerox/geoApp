import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:geo_app/presentation/blocs/blocs.dart';
import 'package:geo_app/presentation/views/map_view.dart';
import 'package:geo_app/presentation/widgets/btn_follow_user.dart';
import 'package:geo_app/presentation/widgets/btn_location.dart';
import 'package:geo_app/presentation/widgets/location_mark.dart';
import 'package:geo_app/presentation/widgets/search_bar.dart';
import 'package:geo_app/presentation/widgets/toggle_polylines.dart';

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
        body: Stack(children: [
          MapView(),
          const SearchBar(),
          const LocationMark(),
        ]));
  }
}
