import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

Future<Uint8List> getGpsAssetImage() async {
  // return BitmapDescriptor.fromAssetImage(
  //     const ImageConfiguration(size: Size(20, 50)), 'assets/pointer.png');

  ByteData data = await rootBundle.load('assets/pointer.png');
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: 65, targetHeight: 80);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}
