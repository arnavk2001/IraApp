import 'package:flutter/material.dart';
import 'package:pictira/SidePanel.dart';
import '../widget/SubjectList.dart';

class FirstYear extends StatelessWidget {
  DateTime currentDate;
  FirstYear({required this.currentDate});
  static final routeName = '/FirstYear';
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 239, 252, 251),
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text("First Year"),
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Physics",
              ),
              Tab(
                text: 'Common',
              ),
              Tab(
                text: "Chemistry",
              ),
            ],
          ),
        ),
        drawer: SidePanel(
          currentDate: currentDate,
        ),
        body: TabBarView(children: [
          SubjectsList(
            currentDate: DateTime(2001, 6, 15, 17, 13),
            branch: 'Physics',
            sem: 'FE',
          ),
          SubjectsList(
            currentDate: DateTime(2001, 6, 15, 17, 13),
            branch: 'Common',
            sem: 'FE',
          ),
          SubjectsList(
            currentDate: DateTime(2001, 6, 15, 17, 13),
            branch: 'Chemistry',
            sem: 'FE',
          ),
        ]),
      ),
    );
  }
}
