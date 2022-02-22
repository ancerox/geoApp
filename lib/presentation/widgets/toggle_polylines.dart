import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:geo_app/presentation/blocs/blocs.dart';

class TogglePolylines extends StatelessWidget {
  const TogglePolylines({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      child: IconButton(
        onPressed: () {
          BlocProvider.of<MapBloc>(context).add(OnTogglePolylines());
        },
        color: Colors.white,
        icon: const Icon(Icons.line_weight, color: Colors.black),
      ),
    );
  }
}
