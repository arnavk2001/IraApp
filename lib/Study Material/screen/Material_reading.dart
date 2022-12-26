import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:pictira/SidePanel.dart';
import '../widget/documentReader.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widget/Listview_builder.dart';

class MaterialReading extends StatelessWidget {
  DateTime currentDate;
  String path, subName;
  String title;
  MaterialReading(
      {required this.currentDate,
      required this.path,
      required this.subName,
      required this.title});
  static const routeName = '/MaterialReading';

  @override
  Widget build(BuildContext context) {
    String document;
    if (path.contains('Material')) if (!path.contains(subName)) path += subName;
    if (!path.contains('Material'))
      document = 'Material';
    else
      document = subName;

    return StreamBuilder<DocumentSnapshot>(
      stream:
          FirebaseFirestore.instance.collection(path).doc(document).snapshots(),
      builder: (ctx, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
              backgroundColor: Color.fromARGB(255, 71, 74, 91),
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
        } else if (snapshot.data!['Material'] == null) {
          return Scaffold(
            //drawer: SidePanel(currentDate: currentDate,),
            appBar: AppBar(
              title: Text(title),
              backgroundColor: Colors.indigo,
            ),
            body: Center(
              child: Text('Sorry No Data Available :)'),
            ),
          );
        } else {
          try {
            List subjects = snapshot.data!['Material'];
            if (subjects[0].runtimeType.toString() == 'String') {
              return Scaffold(
                backgroundColor: Color.fromARGB(255, 239, 252, 251),
                appBar: AppBar(
                  title: Text(title),
                  backgroundColor: Colors.indigo,
                ),
                //drawer: SidePanel(currentDate: currentDate,),
                body: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/Shinchan.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: GridView.builder(
                      itemCount: subjects.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        return DocumentReader(
                          currentDate: currentDate,
                          name: subjects[index],
                          branch: document,
                          sem: path,
                          title: title,
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              (subjects[0].runtimeType.toString() == 'String')
                                  ? 2
                                  : 1)),
                ),
              );
            } else
              return Scaffold(
                appBar: AppBar(
                  title: Text(title),
                  backgroundColor: Colors.indigo,
                ),
                backgroundColor: Color.fromARGB(255, 239, 252, 251),
                //drawer: SidePanel(currentDate: currentDate,),
                body: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/Happy_cow.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ListViewBuilder(
                    currentDate: currentDate,
                    path: path,
                    teacherName: document,
                  ),
                ),
              );
          } catch (e) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  subName,
                  style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.headline4,
                    color: Color.fromARGB(255, 196, 223, 21),
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                backgroundColor: Colors.indigo,
              ),

              //drawer: SidePanel(currentDate: currentDate,),
              body: Center(
                child: Text(e as String),
              ),
            );
          }
        }
      },
    );
  }
}
