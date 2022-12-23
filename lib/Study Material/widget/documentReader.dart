import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pictira/Study%20Material/screen/ListView_builder_screen.dart';
import '../screen/Material_reading.dart';

class DocumentReader extends StatelessWidget {
  DateTime currentDate;
  var name;
  String sem;
  String branch;
  String title;
  late String path;
  DocumentReader(
      {required this.currentDate,
      required this.name,
      required this.branch,
      required this.sem,
      required this.title});

  @override
  Widget build(BuildContext context) {
    path = sem + "/" + branch + "/" + name;

    return Card(
      color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: ListTile(
          title: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 30,
            ),
            textAlign: TextAlign.center,
          ),
          onTap: () {
            if (path.contains(branch + '/' + branch)) {
              // Navigator.of(context).pushNamed(ListViewBuilderScreen.routeName,
              //     arguments: {'path': path, 'subName': name});
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => ListViewBuilderScreen(
                            //Have a look
                            url: "hi",
                            currentDate: currentDate,
                            path: path,
                            teacherName: name,
                            title: title + " " + name,
                          )));
            } else
              // Navigator.of(context).pushNamed(MaterialReading.routeName,
              //     arguments: {'path': path, 'subName': name});
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>MaterialReading(
              // ! Check kar ki back challra hai kya
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => MaterialReading(
                            currentDate: currentDate,
                            path: path,
                            subName: name,
                            title: title + " " + name,
                          )));
          },
        ),
      ),
    );
  }
}
