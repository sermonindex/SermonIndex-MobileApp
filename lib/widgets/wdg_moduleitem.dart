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
        width: MediaQuery.of(context).size.width * .75,
        height: 150,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppSettings.SI_BGCOLOR.withAlpha(200),
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          children: [
            modules[index].moduleIcon,
            Text(
              modules[index].moduleName,
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),
            ),
            Text(
              modules[index].moduleDescription,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black45),
            )
          ],
        ),
      ),
    );
  }
}
