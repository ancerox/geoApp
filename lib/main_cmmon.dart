import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_app/env.dart';
import 'package:geo_app/injector.dart';

// import 'package:provider/provider.dart';

import 'config_reader.dart';
import 'myapp.dart';
import 'presentation/blocs/blocs.dart';

Future<void> mainCommon(String env) async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigReader.init();

  late Color primaryColor;

  switch (env) {
    case Environments.dev:
      primaryColor = Colors.blue;
      break;
    case Environments.prod:
      primaryColor = Colors.red;
      break;
    default:
  }

  setUp();

  runApp((MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => locator<SearchBloc>()),
      BlocProvider(create: (_) => GpsBloc()),
      BlocProvider(create: (_) => LocationBloc()),
      BlocProvider(
        create: (context) => MapBloc(
          locationBloc: BlocProvider.of<LocationBloc>(context),
          getPlacesByCoors: locator(),
        ),
      )
    ],
    child: const MyApp(),
  )));
}
