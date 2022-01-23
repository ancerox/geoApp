import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_app/blocs/blocs.dart';
import 'package:geo_app/injector.dart';
import 'package:geo_app/screens/map_screen.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          if (state is GpsIsOn) {
            return const _AccessButton();
          } else if (state is GpsPermissionIsGranted) {
            return const MapScreen();
          }
          return const _EnableGpsMessage();
        },
      ),
    ));
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Gps is necessary'),
        MaterialButton(
            color: Colors.black,
            child: const Text('Ask For Access',
                style: TextStyle(color: Colors.white)),
            onPressed: () {
              // BlocProvider.of<GpsBloc>(context).askGpsAccess();
              locator.get<GpsBloc>().askGpsAccess();
            })
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('You must initialize your Location'));
  }
}
