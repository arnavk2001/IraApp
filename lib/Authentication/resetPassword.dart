import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pictira/Authentication/Authentication.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  var resetPasswordFormKey=GlobalKey<FormState>();
  late String _email;
  final _auth=FirebaseAuth.instance;
  var _emailController=TextEditingController();

  @override
  Widget build(BuildContext context) {

    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;

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
      body: Form(
      key: resetPasswordFormKey,
      child: Container(
        child: ListView(
          children: [
            SizedBox(height: height*0.05,),

            Center(child: Text("Reset your password",style: TextStyle(fontSize: height*0.05),),),

            SizedBox(height: height*0.007,),

            Padding(
              padding: EdgeInsets.fromLTRB(height*0.05,height*0.0007,height*0.05,height*0.0009),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  icon:Icon(Icons.email),
                ),
                onChanged: (val){
                  setState(() {_email=val;});
                },
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
            ),

            Center(
              child: ElevatedButton(
                  child: Text("Send Request"),
                  onPressed: () async{
                    try{
                      if(resetPasswordFormKey.currentState!.validate()){
                      await _auth.sendPasswordResetEmail(email: _email);
                      Fluttertoast.showToast(
                          msg:"An email with password reset link has been sent to $_email}\nPlease reset your password and sign in again :)", toastLength: Toast.LENGTH_SHORT,backgroundColor: Colors.white70,textColor: Colors.black);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>Authenticate(currentDate: DateTime(2001,6,15,17,30),)));
                      }
                    }
                      catch(e){
                        Fluttertoast.showToast(
                        msg: e.toString(), toastLength: Toast.LENGTH_SHORT,backgroundColor: Colors.red);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>Authenticate(currentDate: DateTime(2001,6,15,17,30))));
                      }
                    }
              ),
            ),
          ],
        ),
      ),
    )
    );
  }
}
