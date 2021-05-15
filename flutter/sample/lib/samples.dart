import 'package:flutter/material.dart';
import 'package:sample/startup_name/app.dart' as startupName;
import 'package:sample/layout_tutorial/app.dart' as layoutTutorial;

List<Sample> samples() {
  return [
    Sample('Startup Name', startupName.App()),
    Sample('Layout Tutorial', layoutTutorial.App()),
  ];
}

class Sample {
  final String name;
  final Widget app;

  Sample(this.name, this.app);
}
