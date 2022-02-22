import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:geo_app/models/search_delegate_model.dart';
import 'package:animate_do/animate_do.dart';
import 'package:geo_app/presentation/blocs/blocs.dart';
import 'package:geo_app/presentation/delegate/search_delegate.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.displayMarker ? const SizedBox() : _SearchBarBody();
      },
    );
  }
}

class _SearchBarBody extends StatelessWidget {
  const _SearchBarBody({Key? key}) : super(key: key);

  showMark(BuildContext context, SearchDelegateModel result) async {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);

    if (result.manual == true) {
      searchBloc.add(OnShowMarkEvent());
    }

    if (result.proximity != null) {
      final response = await searchBloc.getCoorsStartEnd(
          locationBloc.state.lastKnownLocation!, result.proximity);
      response.fold((l) => print(l),
          (rmapCoating) async => await mapBloc.drawPolylines(rmapCoating));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      animate: true,
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: 50,
          width: double.infinity,
          child: GestureDetector(
            onTap: () async {
              final result = await showSearch(
                  context: context, delegate: SeachLocationDelegate());
              if (result == null) return;

              showMark(context, result);
            },
            child: Container(
              padding: EdgeInsets.all(15),
              child: const Text(
                'Donde quieres ir?',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 5))
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
