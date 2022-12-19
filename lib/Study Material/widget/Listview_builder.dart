import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pictira/SidePanel.dart';
import 'package:pictira/DocumentViewer/documentViewer.dart';

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
                                  )));
                      // TODO Check why context was required
                      // viewDocument(url: material[index]['url'], context);
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(material[index]['name']),
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
