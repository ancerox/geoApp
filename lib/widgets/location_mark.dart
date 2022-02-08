import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_app/blocs/blocs.dart';

class LocationMark extends StatelessWidget {
  const LocationMark({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.displayMarker ? _LocationMarkBody() : const SizedBox();
      },
    );
  }
}

class _LocationMarkBody extends StatelessWidget {
  const _LocationMarkBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            // Location Market
            BounceInDown(
              child: Center(
                child: Transform.translate(
                  offset: const Offset(0, -22),
                  child: Icon(Icons.location_on_rounded, size: 50),
                ),
              ),
            ),

            // Back button
            const _BackBtn(),

            // Confirm Location button
            const _ConfirmButton()
          ],
        ));
  }
}

class _ConfirmButton extends StatelessWidget {
  const _ConfirmButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50,
      right: 50,
      child: SizedBox(
        height: 50,
        width: 300,
        child: MaterialButton(
            shape: StadiumBorder(),
            onPressed: () {},
            color: Colors.black,
            child: Text(
              'Confirm Location',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
            )),
      ),
    );
  }
}

class _BackBtn extends StatelessWidget {
  const _BackBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10,
      top: 50,
      child: CircleAvatar(
          maxRadius: 25,
          backgroundColor: Colors.white,
          child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.black,
              onPressed: () {
                BlocProvider.of<SearchBloc>(context).add(OffShowMarkEvent());
              })),
    );
  }
}
