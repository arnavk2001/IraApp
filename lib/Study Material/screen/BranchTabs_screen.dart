import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pictira/SidePanel.dart';
import '../widget/SubjectList.dart';

class BranchTabs extends StatefulWidget {
  String yearS, yearN;
  DateTime currentDate;
  BranchTabs(
      {required this.currentDate, required this.yearS, required this.yearN});
  static final routeName = '/BranchTabs';
  Map<String, String> year = {};
  @override
  _BranchTabsState createState() => _BranchTabsState();
}

class _BranchTabsState extends State<BranchTabs> {
  bool isSem1 = true;
  void toggleSem() {
    setState(() {
      isSem1 = !isSem1;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Have a look
    // widget.year = ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 239, 252, 251),
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          // title: Text("${widget.yearS} Year"),
          title: Text(isSem1
              ? "${widget.yearS} Year \n(Sem 2)"
              : "${widget.yearS} Year \n(Sem 1)"),
          bottom: TabBar(tabs: [
            Tab(
              text: "CSE",
            ),
            Tab(
              text: "IT",
            ),
            Tab(
              text: "EnTC",
            ),
          ]),
          actions: [
            Container(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // shape: const CircleBorder(),
                  primary: Color.fromARGB(255, 243, 86, 86),
                ),
                onPressed: toggleSem,
                child: Text(
                  // isSem1 ? "SEM 2" : "SEM 1",
                  "Switch Sem",
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                ),
                // color: Colors.indigoAccent,
              ),
            ),
          ],
        ),
        drawer: SidePanel(
          currentDate: widget.currentDate,
        ),
        body: TabBarView(
          children: [
            SubjectsList(
              currentDate: DateTime(2001, 6, 15, 17, 13),
              branch: "Computer " + widget.yearN,
              sem: isSem1 ? "sem 1" : "sem 2",
            ),
            SubjectsList(
              currentDate: DateTime(2001, 6, 15, 17, 13),
              branch: "IT " + widget.yearN,
              sem: isSem1 ? "sem 1" : "sem 2",
            ),
            SubjectsList(
              currentDate: DateTime(2001, 6, 15, 17, 13),
              branch: "EnTC " + widget.yearN,
              sem: isSem1 ? "sem 1" : "sem 2",
            ),
          ],
        ),
      ),
    );
  }
}
