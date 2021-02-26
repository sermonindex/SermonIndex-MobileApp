import 'package:flutter/material.dart';
import 'package:sermonindex/config/appsettings.dart';
import 'package:sermonindex/models/mdl_modules.dart';

class SIModule extends StatelessWidget {
  final int index;
  final List<SermonIndexModule> modules;
  final onTap;

  SIModule({this.index, this.modules, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        width: MediaQuery.of(context).size.width * .65,
        // height: MediaQuery.of(context).size.height * .22,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppSettings.SI_BGCOLOR.withAlpha(200),
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: modules[index].moduleIcon,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                modules[index].moduleName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black45),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                modules[index].moduleDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45),
              ),
            )
          ],
        ),
      ),
    );
  }
}
