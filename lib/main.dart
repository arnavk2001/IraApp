import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:http/http.dart' as http;
import 'package:pictira/Authentication/Authentication.dart';
import 'package:pictira/Authentication/VerifyEmail.dart';
import 'package:pictira/Authentication/VerifySubscription.dart';
import 'package:pictira/Home_screen.dart';
import './Study Material/screen/Material_reading.dart';
import 'Notices/screen/Notices.dart';
import 'Notices/screen/NoticesTabs.dart';
import 'package:pictira/SidePanel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Syllabus nd tt/screen/Syllabus_branch_screen.dart';
import 'Syllabus nd tt/screen/TT_branch_screen.dart';
import 'Syllabus nd tt/screen/SyllabusNTt.dart';
import './Study Material/screen/BranchTabs_screen.dart';
import './Study Material/screen/FirstYear_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var url = Uri.parse('http://worldtimeapi.org/api/timezone/Asia/Kolkata');
  var response = await http.get(url);
  // Response response = await get('https://iratime.herokuapp.com/' as Uri);

  Map m = jsonDecode(response.body);
  String datetime = m['datetime'];
  DateTime currentDate = DateTime.parse(datetime);
  currentDate = currentDate.add(Duration(hours: 5, minutes: 30));
  print("main exe");
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PICTIRA(
      currentDate: currentDate,
    ),
  ));
}

class PICTIRA extends StatelessWidget {
  DateTime currentDate;
  PICTIRA({required this.currentDate});
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Color(0xfff2f3f7),
      ),
      home: StreamBuilder(
          stream: _auth.authStateChanges(),
          builder: (ctx, userSnapShot) {
            if (userSnapShot.hasData) {
              if (FirebaseAuth.instance.currentUser!.emailVerified) {
                return VerifySubscription(
                  currentDate: currentDate,
                );
              }
              return VerifyEmail(
                currentDate: currentDate,
              );
            }
            return Authenticate(
              currentDate: currentDate,
            );
          }),
      routes: {
        BranchTabs.routeName: (context) => BranchTabs(
              currentDate: DateTime(2001, 6, 15, 17, 30),
              yearN: 'yoN',
              yearS: "yoS",
            ),

        SidePanel.routeName: (context) => SidePanel(
              currentDate: currentDate,
            ),

        FirstYear.routeName: (context) =>
            FirstYear(currentDate: DateTime(2001, 6, 15, 17, 30)),

        HomeScreen.routeName: (context) => HomeScreen(
              currentDate: currentDate,
            ),
        OtherInfoScreen.routeName: (context) =>
            OtherInfoScreen(currentDate: DateTime(2001, 6, 15, 17, 30)),
        SyllabusBranchScreen.routeName: (context) => SyllabusBranchScreen(),
        TtBranchScreen.routeName: (context) => TtBranchScreen(),
        Notices.routeName: (context) =>
            Notices(currentDate: DateTime(2001, 6, 15, 17, 30)),
        NoticesTabs.routeName: (context) => NoticesTabs(),
        //ResetPasswordScreen.routeName: (context) => ResetPasswordScreen(),
        MaterialReading.routeName: (context) => MaterialReading(
            currentDate: DateTime(2001, 6, 15, 17, 30),
            path: "yopath",
            subName: "yosubname",
            title: "yotitle"),
        //ListViewBuilderScreen.routeName: (context) => ListViewBuilderScreen(),
        //ProfilePage.routeName:(context)=>ProfilePage(),
      },
    );
  }
}

/*
Profile(Recharge Option, Days left, Update info)
 */