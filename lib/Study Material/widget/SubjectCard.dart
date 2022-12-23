import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screen/Material_reading.dart';

class SubjectCard extends StatefulWidget {
  DateTime currentDate;
  static final routeName = '/SubjectCard';
  String name;
  String sem;
  String branch;
  SubjectCard(
      {required this.currentDate,
      required this.name,
      required this.branch,
      required this.sem});
  late String path;

  @override
  _SubjectCardState createState() => _SubjectCardState();
}

class _SubjectCardState extends State<SubjectCard> {
  @override
  Widget build(BuildContext context) {
    widget.path = "/" + widget.sem + "/" + widget.branch + "/" + widget.name;
    return Card(
      elevation: 10,
      // color: Color.fromARGB(255, 239, 252, 251),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
      child: Center(
        child: ListTile(
          title: Text(
            widget.name,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 30,
            ),
            textAlign: TextAlign.center,
          ),
          onTap: () {
            // Navigator.of(context).pushNamed(SubjectTabs.routeName,
            //     arguments: {'path': widget.path, 'subName': widget.name});
            // Navigator.of(context).pushNamed(MaterialReading.routeName,
            //     arguments: {'path': widget.path, 'subName': widget.name});
            // Navigator.pushReplacement(
            //  ! Check kar ki back challra hai kya
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (ctx) => MaterialReading(
                          currentDate: widget.currentDate,
                          path: widget.path,
                          subName: widget.name,
                          title: widget.name,
                        )));
          },
        ),
      ),
    );
  }
}
