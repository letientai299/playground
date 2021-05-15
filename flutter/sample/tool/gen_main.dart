import 'dart:io';

import 'package:recase/recase.dart';
import 'package:sprintf/sprintf.dart';

const out = 'lib/samples.dart';
const template = """
import 'package:flutter/material.dart';
%s

List<Sample> samples() {
  return [
    %s
  ];
}

class Sample {
  final String name;
  final Widget app;

  Sample(this.name, this.app);
}
""";

void main() {
  var dirs = Directory('lib')
      .listSync()
      .where((d) => d.statSync().type == FileSystemEntityType.directory);
  render(dirs);
}

void render(Iterable<FileSystemEntity> dirs) {
  var imports = dirs.map((d) => toImport(d.path)).join("\n");
  var apps = dirs.map((d) => toApp(d.path)).join("\n");
  var code = sprintf(template, [imports, apps]);
  File(out).writeAsString(code);
  Process.run("dart", ["format", out]);
}

String toImport(String p) {
  var pkg = p.replaceFirst('lib', 'sample');
  var alias = ReCase(p.replaceFirst('lib/', '')).camelCase;
  return "import 'package:$pkg/app.dart' as $alias;";
}

String toApp(String p) {
  var folder = p.replaceFirst('lib/', '');
  var alias = ReCase(folder).camelCase;
  var name = folder.split('_').map((e) => ReCase(e).titleCase).join(" ");
  return "Sample('$name', $alias.App()),";
}
