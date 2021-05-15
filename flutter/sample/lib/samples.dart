import 'package:flutter/material.dart';
import 'package:sample/startup_name/app.dart' as startupName;
import 'package:sample/app_1/app.dart' as app1;

List<Sample> samples() {
  return [
    Sample('Startup Name', startupName.App()),
    Sample('App 1', app1.App()),
  ];
}

class Sample {
  final String name;
  final Widget app;

  Sample(this.name, this.app);
}
