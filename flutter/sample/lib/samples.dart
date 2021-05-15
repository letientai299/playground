import 'package:flutter/material.dart';
import 'package:sample/bluetooth/app.dart' as bluetooth;
import 'package:sample/layout_tutorial/app.dart' as layoutTutorial;
import 'package:sample/startup_name/app.dart' as startupName;
import 'package:sample/webview/app.dart' as webview;

List<Sample> samples() {
  return [
    Sample('Startup Name', startupName.App()),
    Sample('Webview', webview.App()),
    Sample('Layout Tutorial', layoutTutorial.App()),
    Sample('Bluetooth', bluetooth.App()),
  ];
}

class Sample {
  final String name;
  final Widget app;

  Sample(this.name, this.app);
}
