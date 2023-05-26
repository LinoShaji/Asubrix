import 'dart:async';
import 'package:asubrix/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';

class authenticationScreen extends StatefulWidget {
  authenticationScreen({Key? key}) : super(key: key);

  @override
  State<authenticationScreen> createState() => _authenticationScreenState();
}

class _authenticationScreenState extends State<authenticationScreen> {
  TextEditingController phoneText = TextEditingController();
  TextEditingController OTPText = TextEditingController();
  bool initRequestOTP = false;
  String verID = "";

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              height: maxHeight,
              width: maxWidth,
              child: Column(
                children: [
                  Container(
                    height: 300,
                    width: 300,
                    child: const Image(
                        image: AssetImage("lib/assets/images/logo -1.jpeg")),
                  ),
                  const SizedBox(height: 30),
                  const Text("Sign In using", style: TextStyle(fontSize: 20)),
                  SignInBox(
                      maxWidth: maxWidth,
                      ImageLoc: "lib/assets/images/google3.png",
                      header: "Google",
                      pressed: () async {
                        final GoogleSignInAccount? gUser =
                            await GoogleSignIn().signIn();
                        final GoogleSignInAuthentication gAuth =
                            await gUser!.authentication;
                        final credential = GoogleAuthProvider.credential(
                            accessToken: gAuth.accessToken,
                            idToken: gAuth.idToken);
                        try {
                          await FirebaseAuth.instance
                              .signInWithCredential(credential);
                        } on FirebaseAuthException catch (e) {
                          Fluttertoast.showToast(msg: e.toString());
                        }
                        if (credential != null) {
                          Fluttertoast.showToast(
                              msg: "Verification successful");
                          Get.to(Home());
                        }
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  SignInBox(
                    header: "Phone",
                    ImageLoc: "lib/assets/images/phone2.png",
                    maxWidth: maxWidth,
                    marginVal: 00,
                    color: Colors.green,
                    pressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext) => AlertDialog(
                                alignment: Alignment.center,
                                backgroundColor: Colors.white,
                                title: Text("Enter your mobile number"),
                                actions: [
                                  Column(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(
                                              right: 20, left: 20),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  decoration: const InputDecoration(
                                                      hintText:
                                                          "Phone number"),
                                                  controller: phoneText,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    initRequestOTP = true;
                                                  });
                                                },
                                                child: TextButton(
                                                    onPressed: () async {
                                                      await VerifyPhoneNumber(
                                                          OTPText,
                                                          phoneText.text,
                                                          context);
                                                    },
                                                    child: Text(
                                                        "Request for OTP")),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ],
                              ));
                    },
                  )
                ],
              )),
        ),
      ),
    );
  }
}

String? _verificationId;
int? _resendToken;

Future VerifyPhoneNumber(TextEditingController Controller, String PhoneNumber,
    BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  _auth.verifyPhoneNumber(
      verificationCompleted: (PhoneAuthCredential credential) {
        _auth.signInWithCredential(credential);
      },
      timeout: Duration(seconds: 60),
      verificationFailed: (FirebaseAuthException e) {
        Fluttertoast.showToast(msg: "${e.toString()}");
      },
      phoneNumber: "+91 ${PhoneNumber}",
      codeSent: (String? verficationId, [int? resendToken]) async {
        PhoneAuthCredential _credential;
        _verificationId = verficationId;
        _resendToken = resendToken;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Enter the OTP"),
                actions: [
                  TextFormField(
                    controller: Controller,
                    decoration: InputDecoration(hintText: "OTP"),
                  ),
                  IconButton(
                      onPressed: () async{
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: _verificationId!,
                                smsCode: Controller.text);
                        _credential = credential;
                        try{await FirebaseAuth.instance.signInWithCredential(credential);Get.off(Home());}
                            on FirebaseAuthException catch(e){
                          Fluttertoast.showToast(msg: e.toString());
                            }
                      },
                      icon: Icon(Icons.check))
                ],
              );
            });
        print('Verification ID : $verficationId');
        print('Resend Token : $resendToken');
      },
      codeAutoRetrievalTimeout: (String verID) {
        print("Auto retrival timeout");
        Fluttertoast.showToast(msg: "code auto retrival timeout");
      });
}

class SignInBox extends StatelessWidget {
  String ImageLoc;
  String header;
  double marginVal;
  Color color;
  final VoidCallback pressed;

  SignInBox({
    required this.pressed,
    this.color = Colors.blue,
    this.marginVal = 70,
    required this.header,
    required this.ImageLoc,
    super.key,
    required this.maxWidth,
  });

  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: pressed,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.only(top: marginVal),
        height: 42,
        width: maxWidth / 1.3,
        child: Row(children: [
          Container(
              margin: EdgeInsets.all(05),
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Image(fit: BoxFit.fill, image: AssetImage(ImageLoc))),
          const SizedBox(
            width: 70,
          ),
          Text(
            header,
            style: TextStyle(color: Colors.white, fontSize: 20),
          )
        ]),
      ),
    );
  }
}
