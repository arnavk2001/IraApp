import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pictira/Authentication/Authentication.dart';
import './Study Material/screen/BranchTabs_screen.dart';
import './Study Material/screen/FirstYear_screen.dart';
import './Study Material/widget/image_slider.dart';
import './SidePanel.dart';

class HomeScreen extends StatefulWidget {
  DateTime currentDate;
  HomeScreen({required this.currentDate});

  static final routeName = '/HomeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    try {
      return Container(
        color: Color.fromARGB(255, 239, 252, 251),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          // backgroundColor: Color(0xfff2f3f7),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.indigo,
            title: Text("PICTIRA"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.person),
                // onPressed: () async{
                //   var auth=FirebaseAuth.instance;
                //   await auth.signOut();
                //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>Authenticate()));
                // })
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext ctx) {
                        return StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .snapshots(),
                          builder: (ctx, snapshots) {
                            if (!snapshots.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              try {
                                dynamic m = snapshots.data;
                                Timestamp ts = m['rechargeDate'];

                                DateTime rechargeDate = ts.toDate();
                                DateTime expiryDate =
                                    rechargeDate.add(Duration(days: 30));
                                print(expiryDate);
                                int daysLeft = expiryDate
                                    .difference(widget.currentDate)
                                    .inDays
                                    .toInt();
                                print(daysLeft);

                                return Container(
                                  color: Color(0xfff2f3f7),
                                  height: screenSize.height * 0.25,
                                  padding:
                                      EdgeInsets.all(screenSize.width * 0.05),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          //CircleAvatar(radius: screenSize.height*0.05,backgroundColor: Colors.white70,),
                                          SizedBox(
                                            width: screenSize.width * 0.05,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                m['username'],
                                                style: TextStyle(
                                                    fontSize:
                                                        screenSize.height *
                                                            0.042,
                                                    color: Color(0xff2e91a0)),
                                              ),
                                              Text(
                                                "${m['email']}",
                                                style: TextStyle(
                                                    fontSize:
                                                        screenSize.height *
                                                            0.02,
                                                    color: Color(0xff2e91a0)),
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                              child: IconButton(
                                            icon: Icon(
                                              Icons.logout,
                                              color: Color(0xff2e91a0),
                                            ),
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (ctx) {
                                                    return AlertDialog(
                                                      content: Text(
                                                          "Are you sure you want to logout?"),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    ctx),
                                                            child: Text("No")),
                                                        TextButton(
                                                            onPressed:
                                                                () async {
                                                              await FirebaseAuth
                                                                  .instance
                                                                  .signOut();

                                                              Navigator.pop(
                                                                  ctx);
                                                              // while(Navigator.canPop(context)){ // Navigator.canPop return true if can pop
                                                              //   Navigator.pop(context);
                                                              // }
                                                              Navigator.popUntil(
                                                                  context,
                                                                  (Route<dynamic>
                                                                          route) =>
                                                                      route
                                                                          .isFirst);
                                                              //Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=>Authenticate(currentDate: widget.currentDate,)));
                                                            },
                                                            child: Text("Yes"))
                                                      ],
                                                    );
                                                  });
                                            },
                                          )),
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.indigo,
                                      ),
                                      SizedBox(
                                        height: screenSize.height * 0.05,
                                      ),
                                      // SizedBox(
                                      //   height: screenSize.height*0.05,
                                      // ),
                                      Center(
                                          child: Text(
                                        "Subscription will end in  $daysLeft days",
                                        style:
                                            TextStyle(color: Color(0xff2e91a0)),
                                      )),
                                    ],
                                  ),
                                );
                              } catch (e) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }
                          },
                        );
                      });
                },
              )
            ],
          ),
          body: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ImageSlider(),
              ),
              SizedBox(
                height: screenSize.height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  child: Text(
                    'Happy Mugging!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      // color: Colors.white,
                      color: Color(0xff2e91a0),
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.04,
              ),

              // First Year Button

              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      elevation: 10,
                      child: Container(
                        width: screenSize.width / 2.5,
                        height: 100,
                        child: ElevatedButton(
                          // color: Colors.orange,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => FirstYear(
                                          currentDate: widget.currentDate,
                                        )));
                          },
                          child: Text(
                            'First Year',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),

                    // Second Year Button

                    Card(
                      elevation: 10,
                      child: Container(
                        width: screenSize.width / 2.5,
                        height: 100,
                        child: ElevatedButton(
                          // color: Colors.green[300],
                          onPressed: () {
                            // Navigator.of(context).pushNamed(
                            //     BranchTabs.routeName,
                            //     arguments: {'yearS': "Second", 'yearN': "2"});

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => BranchTabs(
                                          currentDate: widget.currentDate,
                                          yearS: 'Second',
                                          yearN: '2',
                                        )));
                          },
                          child: Text(
                            'Second Year',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      elevation: 10,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        width: screenSize.width / 2.5,
                        height: 100,
                        child: ElevatedButton(
                          // color: Colors.green,
                          onPressed: () {
                            // Navigator.pushNamed(context, BranchTabs.routeName,
                            //     arguments: {'yearS': "Third", 'yearN': "3"});
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => BranchTabs(
                                          currentDate: widget.currentDate,
                                          yearS: 'Third',
                                          yearN: '3',
                                        )));
                          },
                          child: Text(
                            'Third Year',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Card(
                      elevation: 10,
                      child: Container(
                        width: screenSize.width / 2.5,
                        height: 100,
                        child: ElevatedButton(
                          // color: Colors.yellow,
                          onPressed: () {
                            // Navigator.pushNamed(context, BranchTabs.routeName,
                            //     arguments: {'yearS': "Fourth", 'yearN': "4"});

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => BranchTabs(
                                          currentDate: widget.currentDate,
                                          yearS: 'Fourth',
                                          yearN: '4',
                                        )));
                          },
                          child: Text(
                            'Fourth Year',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          drawer: SidePanel(
            currentDate: widget.currentDate,
          ),
        ),
      );
    } catch (e) {
      return CircularProgressIndicator();
    }
  }
}
