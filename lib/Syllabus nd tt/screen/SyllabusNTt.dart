import 'package:flutter/material.dart';
import 'package:pictira/SidePanel.dart';
import '../widget/Syllabus_tt_list.dart';

class OtherInfoScreen extends StatelessWidget {
  DateTime currentDate;
  OtherInfoScreen({required this.currentDate});

  static final routeName = '/OtherInfoScreen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.grey[1000],
            appBar: AppBar(
              backgroundColor: Colors.indigo,
              title: Text("Select Year"),
              bottom: TabBar(tabs: [
                Tab(
                  text: "Syllabus",
                ),
                Tab(
                  text: "Time Table",
                ),
              ]),
            ),
            drawer: SidePanel(currentDate: currentDate,),
            body: TabBarView(
              children: [
                Syllabus_TT_List('Syllabus'),
                Syllabus_TT_List('TT'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
