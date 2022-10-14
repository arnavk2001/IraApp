import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import '../widget/SubjectCard.dart';

class SubjectsList extends StatefulWidget {
  DateTime currentDate;
  String sem, branch;
  SubjectsList({required this.branch, required this.sem,required this.currentDate});
  @override
  _SubjectsListState createState() => _SubjectsListState();
}

class _SubjectsListState extends State<SubjectsList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection(widget.sem)
          .doc(widget.branch)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          try {
            List subjects = snapshot.data!['Subjects'];
            return GridView.builder(
              itemCount: subjects.length,
              itemBuilder: (BuildContext ctx, int index) {
                return SubjectCard(
                  currentDate: widget.currentDate,
                  name: subjects[index],
                  branch: widget.branch,
                  sem: widget.sem,
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
