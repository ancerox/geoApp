import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:geo_app/presentation/blocs/blocs.dart';

class BtnFollowUser extends StatelessWidget {
  const BtnFollowUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return CircleAvatar(
          backgroundColor: Colors.white,
          child: IconButton(
            onPressed: () {
              BlocProvider.of<MapBloc>(context).add(OnFollowingUserState());
            },
            color: Colors.white,
            icon: Icon(
                state.followUser ? Icons.directions_run_rounded : Icons.pin,
                color: Colors.black),
          ),
        );
      },
    );
  }
}
