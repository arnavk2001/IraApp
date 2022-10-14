import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pictira/Authentication/VerifyEmail.dart';
import 'package:pictira/Authentication/VerifySubscription.dart';
import 'package:pictira/Authentication/resetPassword.dart';

class Authenticate extends StatefulWidget {
  DateTime currentDate;
  Authenticate({required this.currentDate});

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool isSignin = false;
  bool isLoading = false;
  void toggle() {
    setState(() {
      isSignin = !isSignin;
    });
  }

  late String _email;
  late String _password;
  late String _confirmpassword;
  late String _username;
  late String _mobileNo;
  late String _deviceID;

  Timestamp ts = Timestamp.fromDate(DateTime.utc(2002, 3, 9));

  var registerFormKey = GlobalKey<FormState>();
  var signInFormKey = GlobalKey<FormState>();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _confirmPasswordController = TextEditingController();
  var _usernameController = TextEditingController();
  var _mobileController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  Widget RegisterForm(BuildContext ctx) {
    var height = MediaQuery.of(ctx).size.height;
    var width = MediaQuery.of(ctx).size.width;

    return isLoading
        ? Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Center(child: Text("Registering...Please Wait")),
              SizedBox(
                width: width * 0.07,
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
            ]),
          )
        : Form(
            key: registerFormKey,
            child: Container(
              child: ListView(
                children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Center(
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/pictira.png'),
                      radius: height * 0.11,
                      backgroundColor: Colors.black12,
                    ),
                  ),
                  Center(
                    child: Text(
                      "Register",
                      style: TextStyle(fontSize: height * 0.05),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.007,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(height * 0.05, height * 0.0007,
                        height * 0.05, height * 0.0009),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                        icon: Icon(Icons.email),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _email = val.replaceAll(' ', '');
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(height * 0.05, height * 0.0007,
                        height * 0.05, height * 0.0009),
                    child: TextFormField(
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Enter your mobile number",
                        icon: Icon(Icons.phone),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _mobileNo = val;
                        });
                      },
                      validator: (value) {
                        if (value!.length != 10) {
                          return "Please enter valid 10 digit mobile number";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(height * 0.05, height * 0.0007,
                        height * 0.05, height * 0.0009),
                    child: TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        hintText: "Enter username",
                        icon: Icon(Icons.person),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _username = val;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty ||
                            value.length < 5 ||
                            value.length > 10) {
                          return "Username should be of 5-10 characters";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(height * 0.05, height * 0.0007,
                        height * 0.05, height * 0.0009),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password should be 6-10 characters long",
                        icon: Icon(Icons.vpn_key_sharp),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _password = val;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty ||
                            value.length < 6 ||
                            value.length > 10) {
                          return "Password should be 6-10 characters long";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(height * 0.05, height * 0.0007,
                        height * 0.05, height * 0.0009),
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Confirm your password",
                        icon: Icon(Icons.vpn_key_sharp),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _confirmpassword = val;
                        });
                      },
                      validator: (value) {
                        if (value != _password) {
                          return "Password and Confirm Password doesn't match";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: height * 0.009,
                  ),
                  Center(
                    child: ElevatedButton(
                      child: Text("Sign Up"),
                      onPressed: () async {
                        try {
                          if (registerFormKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            AndroidDeviceInfo androidInfo =
                                await deviceInfoPlugin.androidInfo;
                            setState(() {
                              _deviceID = androidInfo.androidId;
                            });
                            dynamic result = await _auth
                                .createUserWithEmailAndPassword(
                                    email: _email.replaceAll(' ', ''),
                                    password: _password)
                                .then((_) {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(_auth.currentUser!.uid)
                                  .set({
                                'username': _username,
                                'email': _email,
                                'mobile': _mobileNo,
                                'rechargeDate': ts,
                                'deviceID': _deviceID,
                              });
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (ctx) => VerifyEmail(
                                            currentDate: widget.currentDate,
                                          )));
                            });
                          }
                        } catch (e) {
                          setState(() {
                            isLoading = false;
                          });
                          Fluttertoast.showToast(
                              msg: e.toString(),
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Colors.red);
                        }
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: toggle,
                    child: Text(
                      "Have an account? Sign in",
                      style: TextStyle(color: Colors.indigo),
                    ),
                  )
                ],
              ),
            ),
          );
  }

  Widget SignInForm(BuildContext ctx) {
    var height = MediaQuery.of(ctx).size.height;
    var width = MediaQuery.of(ctx).size.width;

    return isLoading
        ? Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Center(child: Text("Signing in...Please Wait")),
              SizedBox(
                width: width * 0.07,
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
            ]),
          )
        : Form(
            key: signInFormKey,
            child: Container(
              child: ListView(
                children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Center(
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/pictira.png'),
                      radius: height * 0.11,
                      backgroundColor: Colors.black12,
                    ),
                  ),
                  Center(
                    child: Text(
                      "Welcome back!",
                      style: TextStyle(fontSize: height * 0.05),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.007,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(height * 0.05, height * 0.0007,
                        height * 0.05, height * 0.0009),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                        icon: Icon(Icons.email),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _email = val;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(height * 0.05, height * 0.0007,
                        height * 0.05, height * 0.0009),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password should be 6-10 characters long",
                        icon: Icon(Icons.vpn_key_sharp),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _password = val;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty ||
                            value.length < 6 ||
                            value.length > 10) {
                          return "Password should be 6-10 characters long";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: height * 0.009,
                  ),
                  Center(
                    child: ElevatedButton(
                        child: Text("Sign In"),
                        onPressed: () async {
                          try {
                            AndroidDeviceInfo androidInfo =
                                await deviceInfoPlugin.androidInfo;
                            if (signInFormKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(
                                      email: _email, password: _password)
                                  .then((_) {
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(_auth.currentUser!.uid)
                                    .get()
                                    .then((value) async {
                                  Map<String, dynamic>? m = value.data();
                                  if (androidInfo.androidId == m!['deviceID']) {
                                    if (!_auth.currentUser!.emailVerified) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (ctx) => VerifyEmail(
                                                    currentDate:
                                                        widget.currentDate,
                                                  )));
                                    } else {
                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(_auth.currentUser!.uid)
                                          .get()
                                          .then((value) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    VerifySubscription(
                                                      currentDate:
                                                          widget.currentDate,
                                                    )));
                                      });
                                    }
                                  } else {
                                    await _auth.signOut();
                                    Fluttertoast.showToast(
                                      msg:
                                          "Can't Sign in! This Account is already been used on another device",
                                      toastLength: Toast.LENGTH_SHORT,
                                      backgroundColor: Colors.red,
                                    );
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) => Authenticate(
                                                  currentDate:
                                                      widget.currentDate,
                                                )));
                                  }
                                });
                              });
                            }
                          } catch (e) {
                            setState(() {
                              isLoading = false;
                            });
                            Fluttertoast.showToast(
                                msg: e.toString(),
                                toastLength: Toast.LENGTH_SHORT,
                                backgroundColor: Colors.red);
                          }
                        }),
                  ),
                  TextButton(
                    onPressed: toggle,
                    child: Text("New User? Register now",
                        style: TextStyle(color: Colors.indigo)),
                  ),
                  SizedBox(
                    height: height * 0.007,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (ctx) => ResetPassword()));
                    },
                    child: Text("Forgot Password?",
                        style: TextStyle(color: Colors.indigo)),
                  )
                ],
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PICTIRA",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: isSignin ? SignInForm(context) : RegisterForm(context),
    );
  }
}
/*
  keytool -genkey -v -keystore c:\Users\mr09p\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload

 */