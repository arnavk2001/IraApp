import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screen/Material_reading.dart';
import 'package:random_color/random_color.dart';

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
  RandomColor _randomColor = RandomColor();
  @override
  Widget build(BuildContext context) {
    widget.path = "/" + widget.sem + "/" + widget.branch + "/" + widget.name;
    return Card(
      elevation: 10,
      // color: Color.fromARGB(255, 239, 252, 251),
      shape: RoundedRectangleBorder(
        // side: BorderSide(
        //   color: Colors.black,
        // ),
        borderRadius: BorderRadius.circular(10),
      ),
      // color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
      color: _randomColor.randomColor(
        colorHue: ColorHue.multiple(colorHues: [ColorHue.green, ColorHue.red]),
        colorBrightness: ColorBrightness.light,
        colorSaturation: ColorSaturation.highSaturation,
      ),
      child: Center(
        child: ListTile(
          title: Text(
            widget.name,
            style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.headline4,
              color: Colors.black87,
              fontSize: 25,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
            ),
            //  TextStyle(
            //   fontWeight: FontWeight.w400,
            //   fontSize: 30,
            // ),
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
