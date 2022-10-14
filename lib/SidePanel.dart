import 'package:flutter/material.dart';
import 'package:pictira/Authentication/VerifySubscription.dart';
import 'package:pictira/webViewer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Notices/screen/Notices.dart';
import 'Syllabus nd tt/screen/SyllabusNTt.dart';

class SidePanel extends StatefulWidget {

  DateTime currentDate;
  SidePanel({required this.currentDate});

  static final routeName = '/SidePanel';

  @override
  _SidePanelState createState() => _SidePanelState();

  void Launch(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not Launch $url';
  }
}

class _SidePanelState extends State<SidePanel> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          AppBar(
            backgroundColor: Colors.indigo,
            title: Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          Container(
            height: 20,
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>VerifySubscription(currentDate:widget.currentDate,)));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.school),
            title: Text("Syllabus & TimeTable"),
            onTap: () {
              Navigator
                  .pushReplacement(context,MaterialPageRoute(builder: (ctx)=>OtherInfoScreen(currentDate: widget.currentDate,)));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.notification_important),
            title: Text("Notices"),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>Notices(currentDate: widget.currentDate,)));
            }
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.contact_support),
            title: Text("Contact Us"),
            onTap: () {
              widget.Launch('https://forms.gle/FqdFv7kYkCeJVj3d7');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.file_upload),
            title: Text("Upload File"),
            onTap: () {
            widget.Launch('https://forms.gle/i9kELafA98phwGpy6');
              //Navigator.push(context, MaterialPageRoute(builder: (ctx)=>WebViewer(url:'https://meet.google.com/owp-xjwj-vii' ,)));
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
