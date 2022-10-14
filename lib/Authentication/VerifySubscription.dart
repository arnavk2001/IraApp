import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pictira/Home_screen.dart';
import 'package:pictira/payment_module/payment_gateway.dart';

class VerifySubscription extends StatefulWidget {

  DateTime currentDate;

  VerifySubscription({required this.currentDate});
  @override
  _VerifySubscriptionState createState() => _VerifySubscriptionState();
}

class _VerifySubscriptionState extends State<VerifySubscription> {

  final _auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid).snapshots(),
          builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot>snapshots){
            if(!snapshots.hasData){
              return Scaffold(
                  appBar: AppBar(
                    title: Text(
                      "PICTIRA",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    ),
                    centerTitle: true,
                    backgroundColor: Colors.indigo,
                  ),
                  body: Center(child: CircularProgressIndicator(),));
            }
            else
              {
                try{
                  Timestamp ts=snapshots.data!['rechargeDate'];
                  DateTime rechargeDate=ts.toDate();
                  if(widget.currentDate.difference(rechargeDate).inDays.toInt()<=30){
                    return HomeScreen(currentDate: widget.currentDate,);
                    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>HomeScreen()));
                  }
                  else{
                    return PaymentGateway(currentDate:widget.currentDate,email: _auth.currentUser!.email as String,mobileNo: snapshots.data!['mobile'],userName: snapshots.data!['username'],);
                  }
                }
                catch(e){
                  return Scaffold(
                      appBar: AppBar(
                        title: Text(
                          "PICTIRA",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        ),
                        centerTitle: true,
                        backgroundColor: Colors.indigo,
                      ),
                      body: Center(child: CircularProgressIndicator(),));
                }
              }
          }
      ),
    );
  }
}
