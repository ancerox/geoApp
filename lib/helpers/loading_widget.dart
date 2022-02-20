import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showLoadingMessage(BuildContext context) {
  // Android
  if (Platform.isAndroid) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: const Text('Wait a second please'),
              content: Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  children: const [
                    Text('Getting route'),
                    SizedBox(height: 15),
                    CircularProgressIndicator(
                        strokeWidth: 3, color: Colors.black)
                  ],
                ),
              ),
            ));
    return;
  }

  showCupertinoDialog(
      context: context,
      builder: (context) => const CupertinoAlertDialog(
            title: Text('Wait a second please'),
            content: CupertinoActivityIndicator(),
          ));
}
