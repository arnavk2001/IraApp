import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NoticesList extends StatefulWidget {


  String path, typeOfContent;
  NoticesList({required this.path,required this.typeOfContent});
  @override
  _NoticesListState createState() => _NoticesListState();
}

class _NoticesListState extends State<NoticesList> {
  @override
  Widget build(BuildContext context) {

    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    final controller=PageController();

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(widget.path)
            .doc(widget.typeOfContent)
            .snapshots(),
        builder: (BuildContext ctx, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                "No Notices Available :)",
                style: TextStyle(fontSize: 25),
              ),
            );
          } else {
            try {
              List rd = snapshot.data!['Materials'];
              Map m = {};
              List d = rd.reversed.toList();
              return Center(
                child: ListView(
                  children: [
                    Container(
                      height: height*0.72,
                      child: PageView.builder(
                        controller: controller,
                        itemCount: d.length,
                        itemBuilder: (BuildContext ctx,int index){
                          m=d[index];
                          // print(m['dateTime'].runtimeType);
                          // print(m['dateTime']);
                          // Timestamp t=m['dateTime'];
                          // DateTime dt=t.toDate();
                          // print(dt);
                          // print(DateTime.now().difference(dt).inDays.toInt());
                          return Container(
                            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                            child: Card(
                              child: ListView(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                children: [
                                  Text(
                                    m['title'],
                                    style: TextStyle(fontSize: 32),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    m['subTitle'],
                                    style: TextStyle(fontSize: 28),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.70,
                                      ),
                                      Text(m['date']),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    m['contentText'],
                                    style: TextStyle(fontSize: 21),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  m['isImg']
                                      ? Image.network(m['imgUrl'])
                                      : SizedBox(
                                    height: 1,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  m['isPdf']
                                      ? ListTile(
                                    tileColor: Colors.blueGrey,
                                    title: Text(m['title'] + '.pdf'),
                                    onTap: () {
                                      PdftronFlutter.openDocument(m['pdfUrl']);
                                    },
                                  )
                                      : SizedBox(
                                    height: 2,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: height*0.02,),
                    Container(
                      child: Center(
                        child: SmoothPageIndicator(
                          controller: controller,
                          count: d.length,
                          effect: ScrollingDotsEffect(dotHeight: height*0.007),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } catch (e) {
              return Center(
                child: Text(
                  "No Notices Available :)",
                  style: TextStyle(fontSize: 25),
                ),
              );
            }
          }
        });
  }
}

