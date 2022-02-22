import 'package:geo_app/env.dart';

import 'main_cmmon.dart';

Future<void> main() async {
  await mainCommon(Environments.prod);
}
