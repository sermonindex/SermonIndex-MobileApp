import 'package:flutter/material.dart';

class SermonIndexModule {
  final String moduleName;
  final Icon moduleIcon;
  final String moduleDescription;
  final bool activeModule;

  SermonIndexModule(
      {this.activeModule,
      this.moduleName,
      this.moduleIcon,
      this.moduleDescription});
}

List<SermonIndexModule> sermonIndexModules() {
  List<SermonIndexModule> modules = [];
  modules.add(new SermonIndexModule(
      activeModule: true,
      moduleName: "Speakers",
      moduleIcon: Icon(
        Icons.person,
        size: 60,
        color: Colors.white30,
      ),
      moduleDescription: "List the sermons by Speaker"));
  modules.add(new SermonIndexModule(
      activeModule: false,
      moduleName: "Topics",
      moduleIcon: Icon(
        Icons.list,
        size: 60,
        color: Colors.white30,
      ),
      moduleDescription: "List the sermons by Topic"));
  modules.add(new SermonIndexModule(
      activeModule: false,
      moduleName: "Scripture",
      moduleIcon: Icon(
        Icons.book,
        size: 60,
        color: Colors.white30,
      ),
      moduleDescription: "List the sermons by Scripture"));
  return modules;
}
