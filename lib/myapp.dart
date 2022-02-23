import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:geo_app/injector.dart';
import 'package:geo_app/presentation/screens/gps_screen.dart';

import 'domain/usecases/get_coors_start_end.dart';
import 'presentation/blocs/blocs.dart';

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
