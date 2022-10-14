import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import '../screen/TT_branch_screen.dart';
import '../screen/Syllabus_branch_screen.dart';

class Syllabus_TT_List extends StatelessWidget {
  String ttOrSyllabus;
  Syllabus_TT_List( this.ttOrSyllabus);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Syllabus_sh')
          .doc('LIhoZrYv7S41xaxoXB7A')
          .snapshots(),
      builder: (ctx, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          try {
            List years = snapshot.data!['Years'];
            return GridView.builder(
              itemCount: years.length,
              itemBuilder: (BuildContext ctx, int index) {
                return Card(
                  elevation: 10,
                  color: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)],
                  child: Center(
                    child: ListTile(
                      title: Text(
                        years[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 30,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        if (ttOrSyllabus == 'Syllabus')
                          Navigator.of(context).pushNamed(
                              SyllabusBranchScreen.routeName,
                              arguments: years[index]);
                        else
                          Navigator.of(context).pushNamed(
                              TtBranchScreen.routeName,
                              arguments: years[index]);
                      },
                    ),
                  ),
                );
              },
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            );
          } catch (e) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      },
    );
  }
}
