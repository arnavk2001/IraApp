import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pictira/SidePanel.dart';
import 'package:pictira/documentViewer.dart';


class ListViewBuilderScreen extends StatelessWidget {
  DateTime currentDate;
  //static const routeName = '/ListViewBuilderScreen';
  String path;
  String teacherName;
  String url;
  String title;

  ListViewBuilderScreen({required this.currentDate,required this.path,required this.teacherName,required this.url,required this.title});
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
      stream:
          FirebaseFirestore.instance.collection(path).doc(teacherName).snapshots(),
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
                      onTap: (){viewDocument(material[index]['url'], context);},
                      child: Card(
                        child: ListTile(
                          title: Text(material[index]['name']),
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
