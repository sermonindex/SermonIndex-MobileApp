import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sermonindex/config/appsettings.dart';

class SermonIndexModule {
  final String moduleName;
  final FaIcon moduleIcon;
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
      moduleIcon: FaIcon(
        AppSettings.speakerIcon,
        size: 50,
        color: Colors.white30,
      ),
      moduleDescription: "List the sermons by Speaker"));
  modules.add(new SermonIndexModule(
      activeModule: false,
      moduleName: "Topics",
      moduleIcon: FaIcon(
        AppSettings.topicIcon,
        size: 50,
        color: Colors.white30,
      ),
      moduleDescription: "List the sermons by Topic"));
  modules.add(new SermonIndexModule(
      activeModule: false,
      moduleName: "Scripture",
      moduleIcon: FaIcon(
        AppSettings.bibleIcon,
        size: 50,
        color: Colors.white30,
      ),
      moduleDescription: "List the sermons by Scripture"));
  return modules;
}
