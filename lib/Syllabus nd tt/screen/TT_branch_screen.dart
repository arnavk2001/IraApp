import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pictira/DocumentViewer/documentViewer.dart';

class TtBranchScreen extends StatelessWidget {
  static final routeName = '/TtBranchScreen';

  @override
  Widget build(BuildContext context) {
    String year = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(year + ' Time Table'),
        backgroundColor: Colors.indigo,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('TimeTable')
            .doc('YHMjBIcBsblS7rLEuMek')
            .snapshots(),
        builder: (ctx, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  Text("Loading... Please Wait"),
                ],
              ),
            );
          } else {
            try {
              List branch = snapshot.data![year];
              return ListView.builder(
                itemCount: branch.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => viewDocument(
                                    url: branch[index]['url'],
                                    docName: branch[index]['name'],
                                  )));
                      // TODO Check why context was required
                      // viewDocument(branch[index]['url'], context);
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(branch[index]['name']),
                      ),
                    ),
                  );
                },
              );
            } catch (e) {
              return Center(
                child: Text('Sorry No Data Available :)'),
              );
            }
          }
        },
      ),
    );
  }
}
