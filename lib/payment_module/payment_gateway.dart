import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pictira/Authentication/Authentication.dart';
import 'package:pictira/Home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:fluttertoast/fluttertoast.dart';

class PaymentGateway extends StatefulWidget {
  DateTime currentDate;
  String email;
  String mobileNo;
  String userName;

  PaymentGateway(
      {required this.currentDate,
      required this.email,
      required this.mobileNo,
      required this.userName});
  @override
  _PaymentGatewayState createState() => _PaymentGatewayState();
}

class _PaymentGatewayState extends State<PaymentGateway> {
  static const platform = const MethodChannel("razorpay_flutter");

  late Razorpay _razorpay;

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PICTIRA - Subscription",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: Color(0xfff2f3f7),
      body: Padding(
        padding: EdgeInsets.all(height * 0.02),
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('images/pictira.png'),
                radius: height * 0.11,
                backgroundColor: Colors.black12,
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Center(
              child: Text(
                "Together We Study",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: height * 0.03,
                    color: Color(0xff2e91a0)),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Center(
              // TODO make it look appeleaing
              child: Text(
                "Hey ${widget.userName},\n\n"
                "Perks of Subscribing* - \n"
                "\t >	Textbooks & Reference Books\n"
                "\t >	Study Notes\n"
                "\t >	Previous Question Papers and MCQs\n"
                "\t >	Notices\n"
                "Of all divisions at one place ",
                style: TextStyle(
                    fontSize: height * 0.025, color: Color(0xff31394c)),
              ),
            ),
            SizedBox(
              height: height * 0.007,
            ),
            Text(
              "*Contents are subject to availability",
              style: TextStyle(fontSize: height * 0.02, color: Colors.black),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Center(
              // child: ElevatedButton(
              //     onPressed: openCheckout,
              //     child: Text("Pay ₹9/-")
              // )
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('paymentPrice')
                      .doc('price')
                      .snapshots(),
                  builder: (ctx, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          ElevatedButton(
                            child: Text(
                                "Pay ₹${snapshot.data!['price'].toString()}/-"),
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xff2e91a0),
                            ),
                            onPressed: () {
                              openCheckout(snapshot.data!['priceRazopay']);
                            },
                          ),
                          SizedBox(
                            height: height * 0.005,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.logout,
                              color: Color(0xff2e91a0),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    content: Text(
                                        "Are you sure you want to logout?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () => Navigator.pop(ctx),
                                          child: Text("No")),
                                      TextButton(
                                          onPressed: () async {
                                            await FirebaseAuth.instance
                                                .signOut();

                                            Navigator.pop(ctx);
                                            // while(Navigator.canPop(context)){ // Navigator.canPop return true if can pop
                                            //   Navigator.pop(context);
                                            // }
                                            //Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (c) =>
                                                        Authenticate(
                                                          currentDate: widget
                                                              .currentDate,
                                                        )));
                                          },
                                          child: Text("Yes"))
                                    ],
                                  );
                                },
                              );
                            },
                          )
                        ],
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout(int price) async {
    var options = {
      'key': 'rzp_live_8xjvEaCGrxdB3t',
      'amount': price,
      'name': 'PICTIRA',
      'description': 'Monthly Subscription',
      'prefill': {'contact': widget.mobileNo, 'email': widget.email},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Timestamp ts = Timestamp.fromDate(widget.currentDate);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .update({'rechargeDate': ts, 'paymentID': response.paymentId});
    Fluttertoast.showToast(
        msg: "Payment Successful! Thank You " + "Shaunak here",
        // msg: "Payment Successful! Thank You " + response.paymentId,
        toastLength: Toast.LENGTH_SHORT);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(
                  currentDate: widget.currentDate,
                )));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // TODO make
    //Have a look
    // var message,walletName;
    // Object responseHere=response ?? {message:"hi",walletName:"Yo"};

    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - Message",
        toastLength: Toast.LENGTH_SHORT);

    // Fluttertoast.showToast(
    //     msg: "ERROR: " + response.code.toString() + " - " + response.message,
    //     toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Fluttertoast.showToast(
    //     msg: "EXTERNAL_WALLET: " + response.walletName,
    //     toastLength: Toast.LENGTH_SHORT);

    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: Wallet Name", toastLength: Toast.LENGTH_SHORT);
  }
}
