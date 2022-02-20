import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_app/blocs/blocs.dart';

import 'package:geo_app/injector.dart';
import 'package:geo_app/screens/screens.dart';

import 'domain/usecases/get_coors_start_end.dart';

void main() {
  setUp();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => locator<SearchBloc>()),
    BlocProvider(create: (_) => GpsBloc()),
    BlocProvider(create: (_) => LocationBloc()),
    BlocProvider(
        create: (context) => MapBloc(
            locationBloc: BlocProvider.of<LocationBloc>(context),
            getPlacesByCoors: locator()))
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const GpsAccessScreen());
  }
}
