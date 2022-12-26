import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pictira/SidePanel.dart';
import 'package:pictira/DocumentViewer/documentViewer.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../DocumentViewer/DocumentViewer_Screen.dart';

class ListViewBuilder extends StatelessWidget {
  DateTime currentDate;
  static const routeName = '/ListViewBuilder';
  String path;
  String teacherName;
  late String url;
  ListViewBuilder(
      {required this.currentDate,
      required this.path,
      required this.teacherName});

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
              title: Text(teacherName),
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
            return ListView.builder(
                itemCount: material.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => viewDocument(
                                    url: material[index]['url'],
                                    docName: material[index]['name'],
                                  )));
                      // TODO Check why context was required
                      // viewDocument(url: material[index]['url'], context);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ClipPath(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                  color: Colors.greenAccent, width: 5),
                            ),
                          ),
                          child: ListTile(
                            // tileColor: Color.fromARGB(255, 0, 115, 147),
                            // shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(10.0)),
                            title: Text(
                              material[index]['name'],
                              style: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.headline4,
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          } catch (e) {
            return Center(
              child: Text('Sorry No Data Available :)'),
            );
          }
        }
      },
    );
  }
}
