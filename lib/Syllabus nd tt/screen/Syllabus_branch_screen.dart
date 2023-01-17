import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pictira/DocumentViewer/documentViewer.dart';

class SyllabusBranchScreen extends StatelessWidget {
  static final routeName = '/SyllabusBranchScreen';

  @override
  Widget build(BuildContext context) {
    String year = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(year + " Syllabus"),
        backgroundColor: Colors.indigo,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Syllabus_sh')
              .doc('LIhoZrYv7S41xaxoXB7A')
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
                        // viewDocument(url: branch[index]['url'], context);
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
          }),
    );
  }
}
