import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pictira/SidePanel.dart';
import '../screen/NoticesTabs.dart';

class Notices extends StatefulWidget {
  DateTime currentDate;
  Notices({required this.currentDate});
  static final routeName = '/Notices';

  @override
  _NoticesState createState() => _NoticesState();
}

class _NoticesState extends State<Notices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notices",
          style: TextStyle(fontSize: 25),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Notices')
              .doc('Years')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              try {
                List d = snapshot.data!['Years'];
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: d.length,
                    itemBuilder: (ctx, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: ElevatedButton(
                            // shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(15)),
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  NoticesTabs.routeName,
                                  arguments: d[index]);
                            },
                            child: Text(
                              d[index],
                              style: TextStyle(fontSize: 25),
                            )),
                      );
                    });
              } catch (e) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          }),
      drawer: SidePanel(
        currentDate: widget.currentDate,
      ),
    );
  }
}
