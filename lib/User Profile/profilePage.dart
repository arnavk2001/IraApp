import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ProfilePage extends StatefulWidget {
  static final routeName='/ProfilePage';
  String uid;
  ProfilePage( this.uid);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  @override
  Widget build(BuildContext context) {

    print("Uid is    asddsd");
    print(widget.uid);

    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').doc(widget.uid).snapshots(),
      builder: (ctx,snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }
        else{
          try{
            dynamic a=snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: Text("Profile Page"),
              ),
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  CircleAvatar(radius: height*0.07,),
                  Center(child: Text("${a['username']}",style: TextStyle(color: Colors.purple),),)
                ],
              ),
            );
          }
          catch(e){
            print(e);
            return Center(child: CircularProgressIndicator(),);
          }
        }
      },
    );
  }
}