import 'package:flutter/material.dart';
import '../widget/notices_widgets.dart';

class NoticesTabs extends StatefulWidget {
  static final routeName = "/NoticesTabs";

  @override
  _NoticesTabsState createState() => _NoticesTabsState();
}

class _NoticesTabsState extends State<NoticesTabs> {
  @override
  Widget build(BuildContext context) {
    // Have a look at
    String year = ModalRoute.of(context)!.settings.arguments as String;

    return (year == "FE")
        ? Scaffold(
            appBar: AppBar(
              title: Text("FE Notices"),
              backgroundColor: Colors.indigo,
            ),
            body: NoticesList(
              path: '/Notices/FE/firstyear',
              typeOfContent: 'notices',
            ),
          )
        : DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: Text(year + " Notices"),
                backgroundColor: Colors.indigo,
                bottom: TabBar(
                  tabs: [
                    Tab(
                      child: Text("Computer"),
                    ),
                    Tab(
                      child: Text("IT"),
                    ),
                    Tab(
                      child: Text("EnTC"),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  NoticesList(
                    path: "/Notices/" + year + "/Computer",
                    typeOfContent: 'notices',
                  ),
                  NoticesList(
                    path: "/Notices/" + year + "/IT",
                    typeOfContent: 'notices',
                  ),
                  NoticesList(
                    path: "/Notices/" + year + "/EnTC",
                    typeOfContent: 'notices',
                  ),
                ],
              ),
            ));
  }
}
