import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_app/env.dart';

import 'package:provider/provider.dart';

import 'config_reader.dart';
import 'myapp.dart';

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

  runApp(Provider.value(
    value: primaryColor,
    child: const MyApp(),
  ));
}
