import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pictira/Authentication/Authentication.dart';
import './Study Material/screen/BranchTabs_screen.dart';
import './Study Material/screen/FirstYear_screen.dart';
import './Study Material/widget/image_slider.dart';
import './SidePanel.dart';
import 'package:google_fonts/google_fonts.dart';

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
        // color: Color.fromARGB(255, 239, 252, 251),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/rm347-porpla-02-a-01.jpg'),
            fit: BoxFit.cover,
          ),
        ),
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
                padding: const EdgeInsets.only(top: 30),
                child: ImageSlider(),
              ),
              // TODO dyanamic wapas lao
              // SizedBox(
              //   height: screenSize.height * 0.05,
              // ),
              // TODO dyanamic karrna hai ise
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                // child: FittedBox(
                child: Container(
                  height: screenSize.height * 0.06,
                  width: screenSize.width * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: Color.fromARGB(255, 64, 164, 192),
                  ),
                  // child: FittedBox(
                  // child: Text(
                  //   'Happy Mugging!',
                  //   textAlign: TextAlign.center,
                  //   style: GoogleFonts.lato(
                  //     textStyle: Theme.of(context).textTheme.headline4,
                  //     color: Color.fromARGB(255, 56, 240, 66),
                  //     // color: Colors.,
                  //     fontSize: 38,
                  //     fontWeight: FontWeight.w700,
                  //     fontStyle: FontStyle.italic,
                  //   ),
                  //   // TextStyle(
                  //   //   color: Colors.black,
                  //   //   fontWeight: FontWeight.bold,
                  //   //   fontSize: 40,
                  //   // ),
                  // ),
                  // ),
                ),
                // ),
              ),
              SizedBox(
                height: screenSize.height * 0.1,
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
                        height: 130,
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
                            style: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.headline4,
                              color: Color.fromARGB(255, 196, 223, 21),
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                            ),
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
                        height: 130,
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
                            style: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.headline4,
                              color: Color.fromARGB(255, 196, 223, 21),
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                            ),
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
                        height: 130,
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
                            style: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.headline4,
                              color: Color.fromARGB(255, 196, 223, 21),
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                            ),
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
                        height: 130,
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
                            style: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.headline4,
                              color: Color.fromARGB(255, 196, 223, 21),
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                            ),
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
