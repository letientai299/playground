import 'package:flutter/material.dart';
import 'package:sample/app_1/app.dart' as app1;
import 'package:sample/app_2/app.dart' as app2;
import 'package:sample/startup_name/app.dart' as startupName;

List<Sample> samples() {
  return [
    Sample("Startup Name", startupName.App()),
    Sample("App 1", app1.App()),
    Sample("App 2", app2.App()),
  ];
}

class Sample {
  final String name;
  final Widget app;

  Sample(this.name, this.app);
}
