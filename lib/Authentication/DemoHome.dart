import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pictira/Authentication/Authentication.dart';
import 'package:pictira/payment_module/payment_gateway.dart';

class DemoHome extends StatefulWidget {
  @override
  _DemoHomeState createState() => _DemoHomeState();
}

class _DemoHomeState extends State<DemoHome> {
  var auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Column(
      children:[ Center(
        child: ElevatedButton(
          child: Text("Logout"),
          onPressed: ()async{

            await auth.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>Authenticate(currentDate: DateTime(2001,6,15,17,30))));
          },
        ),
      ),
        ElevatedButton(
          //Have a look
            onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (ctx)=>PaymentGateway(currentDate: DateTime(2001,6,15,17,30),userName: "Shuanak",email:auth.currentUser!.email as String,mobileNo:'8600410985')));},
            child: Text("Recharge")),
      ]
    );
  }
}
