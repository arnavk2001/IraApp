import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pictira/Authentication/Authentication.dart';
import 'package:pictira/Authentication/VerifySubscription.dart';
import 'package:pictira/payment_module/payment_gateway.dart';

class VerifyEmail extends StatefulWidget {
  DateTime currentDate;
  VerifyEmail({required this.currentDate});
  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final _auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState() {
    user = _auth.currentUser as User;
    user.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "PICTIRA - Verify your email",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.indigo,
        ),
        body: ListView(children: [
          Padding(
            padding: EdgeInsets.all(height * 0.07),
            child: Center(
                child: Text(
                    "An email has been sent to ${_auth.currentUser!.email} for verification")),
          ),
          SizedBox(
            height: height * 0.07,
          ),
          Center(
            child: Text("Verify your email and head back here"),
          ),
          SizedBox(
            height: height * 0.1,
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => Authenticate(
                                currentDate: widget.currentDate,
                              )));
                },
                child: Text("Go back")),
          ),
        ]));
  }

  Future<void> checkEmailVerified() async {
    user = _auth.currentUser as User;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get()
          .then((value) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (ctx) => VerifySubscription(
                      currentDate: widget.currentDate,
                    )));
      });
    }
  }
}
