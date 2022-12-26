import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pictira/SidePanel.dart';
import 'package:pictira/DocumentViewer/documentViewer.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../DocumentViewer/DocumentViewer_Screen.dart';

class ListViewBuilderScreen extends StatelessWidget {
  DateTime currentDate;
  //static const routeName = '/ListViewBuilderScreen';
  String path;
  String teacherName;
  String url;
  String title;

  ListViewBuilderScreen(
      {required this.currentDate,
      required this.path,
      required this.teacherName,
      required this.url,
      required this.title});
  // Future<void> downloadPdf(url) async {
  //   if (await canLaunch(url)) {
  //     final bool nativeAppLaunchSucceeded = await launch(
  //       url,
  //       forceSafariVC: true,
  //       universalLinksOnly: false,
  //     );
  //     if (!nativeAppLaunchSucceeded) {
  //       await launch(url, forceSafariVC: true);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // Map a = ModalRoute.of(context).settings.arguments;
    // path = a['path'];
    // teacherName = a['subName'];
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection(path)
          .doc(teacherName)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
              backgroundColor: Colors.indigo,
            ),

            //drawer: SidePanel(currentDate: currentDate,),
            body: Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  Text("Loading... Please Wait"),
                ],
              ),
            ),
          );
        } else {
          try {
            List material = snapshot.data!['Material'];
            return Scaffold(
                appBar: AppBar(
                  title: Text(title),
                  backgroundColor: Colors.indigo,
                ),
                //drawer: SidePanel(currentDate: currentDate,),
                body: ListView.builder(
                  itemCount: material.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return GestureDetector(
                      onTap: () {
                        // TODO Check why context was required
                        // viewDocument(url: material[index]['url'], context);
                        // DocViewScrn(url: material[index]['url']);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => viewDocument(
                                    url: material[index]['url'],
                                    docName: material[index]['name'])));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
                            tileColor: Color.fromARGB(255, 0, 115, 147),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            title: Text(
                              material[index]['name'],
                              // textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.headline4,
                                color: Color.fromARGB(255, 196, 223, 21),
                                // color: Colors.blueAccent,
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic,
                              ),
                            )
                            // Text(material[index]['name']),
                            // trailing: TextButton(
                            //   child: Icon(Icons.download_rounded),
                            //   onPressed: () async {
                            //     //await downloadPdf(material[index]['url']);
                            //   },
                            // ),
                            ),
                      ),
                    );
                  },
                ));
          } catch (e) {
            return Scaffold(
              appBar: AppBar(
                title: Text(title),
                backgroundColor: Colors.indigo,
              ),

              //drawer: SidePanel(currentDate: currentDate,),
              body: Center(
                child: Text('Sorry No Data Available :)'),
              ),
            );
          }
        }
      },
    );
  }
}
