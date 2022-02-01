import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_app/blocs/blocs.dart';
import 'package:geo_app/ui/custom_snack.dart';

class BtnLocation extends StatelessWidget {
  const BtnLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        final lastKnownLocation =
            BlocProvider.of<LocationBloc>(context).state.lastKnownLocation;

        if (lastKnownLocation == null) {
          ScaffoldMessenger.of(context).showSnackBar(CustomSnack());
          return;
        }

        BlocProvider.of<MapBloc>(context).centerMap(lastKnownLocation);
      },
      backgroundColor: Colors.white,
      child: const Icon(Icons.person, color: Colors.black),
    );
  }
}
