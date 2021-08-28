import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// final FirebaseAuth _auth = FirebaseAuth.instance;
// final CollectionReference _users =
//     FirebaseFirestore.instance.collection("users");

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class NewUser extends StatefulWidget {
  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  String verificationId;

  bool showLoading = false;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      // if(authCredential?.user != null){
      //   Navigator.push(context, MaterialPageRoute(builder: (context)=> Screen()));
      // }

    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  getMobileFormWidget(context) {
    return Column(
      children: [
        Spacer(),
        TextField(
          controller: phoneController,
          decoration: InputDecoration(
            hintText: "Phone Number",
          ),
        ),
        SizedBox(
          height: 16,
        ),
        FlatButton(
          onPressed: () async {
            setState(() {
              showLoading = true;
            });

            await _auth.verifyPhoneNumber(
              phoneNumber: phoneController.text,
              verificationCompleted: (phoneAuthCredential) async {
                setState(() {
                  showLoading = false;
                });
                //signInWithPhoneAuthCredential(phoneAuthCredential);
              },
              verificationFailed: (verificationFailed) async {
                setState(() {
                  showLoading = false;
                });
                _scaffoldKey.currentState.showSnackBar(
                    SnackBar(content: Text(verificationFailed.message)));
              },
              codeSent: (verificationId, resendingToken) async {
                setState(() {
                  showLoading = false;
                  currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                  this.verificationId = verificationId;
                });
              },
              codeAutoRetrievalTimeout: (verificationId) async {},
            );
          },
          child: Text("SEND"),
          color: Colors.blue,
          textColor: Colors.white,
        ),
        Spacer(),
      ],
    );
  }

  getOtpFormWidget(context) {
    return Column(
      children: [
        Spacer(),
        TextField(
          controller: otpController,
          decoration: InputDecoration(
            hintText: "Enter OTP",
          ),
        ),
        SizedBox(
          height: 16,
        ),
        FlatButton(
          onPressed: () async {
            PhoneAuthCredential phoneAuthCredential =
                PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: otpController.text);
            _auth.currentUser
                .linkWithCredential(phoneAuthCredential)
                .then((value) => print("successfully linked"))
                .catchError((e) {
              print(e.code);
            });

            // signInWithPhoneAuthCredential(phoneAuthCredential);
          },
          child: Text("VERIFY"),
          color: Colors.blue,
          textColor: Colors.white,
        ),
        Spacer(),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          child: showLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                  ? getMobileFormWidget(context)
                  : getOtpFormWidget(context),
          padding: const EdgeInsets.all(16),
        ));
  }
}

// class NewUser extends StatefulWidget {
//   @override
//   _NewUserState createState() => _NewUserState();
// }
//
// class _NewUserState extends State<NewUser> {
//   final _formKey = GlobalKey<FormState>();
//   final _formKeyOTP = GlobalKey<FormState>();
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   final TextEditingController numberController = new TextEditingController();
//   final TextEditingController otpController = new TextEditingController();
//
//   var isLoading = false;
//   var isResend = false;
//   var isLoginScreen = false;
//   var isOTPScreen = false;
//   var verificationCode = '';
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     numberController.dispose();
//     otpController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           key: _scaffoldKey,
//           body: ListView(
//             children: [
//               Column(
//                 children: [
//                   Form(
//                     key: _formKey,
//                     child: Column(
//                       children: [
//                         Container(
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                                 vertical: 10.0, horizontal: 10.0),
//                             child: TextFormField(
//                               enabled: !isLoading,
//                               controller: numberController,
//                               keyboardType: TextInputType.phone,
//                               decoration:
//                                   InputDecoration(labelText: 'Phone Number'),
//                               validator: ((value) {
//                                 return value.isEmpty
//                                     ? "Please enter phoneNumber"
//                                     : null;
//                               }),
//                             ),
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(top: 40, bottom: 5),
//                           child: !isLoading
//                               ? ElevatedButton(
//                                   onPressed: (() async {
//                                     if (!isLoading) {
//                                       if (_formKey.currentState.validate()) {
//                                         setState(() {
//                                           validatePhoneNumber();
//                                           isOTPScreen = true;
//                                         });
//                                         displaySnackBar('please wait.....');
//                                       }
//                                     }
//                                   }),
//                                   child: Container(
//                                       padding: EdgeInsets.symmetric(
//                                         vertical: 15.0,
//                                         horizontal: 15.0,
//                                       ),
//                                       child: new Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Expanded(
//                                               child: Text(
//                                             "Submit",
//                                             textAlign: TextAlign.center,
//                                           )),
//                                         ],
//                                       )),
//                                 )
//                               : CupertinoActivityIndicator(),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               )
//             ],
//           )),
//     );
//   }
//
//   displaySnackBar(text) {
//     final snackBar = SnackBar(content: Text(text));
//     _scaffoldKey.currentState.showSnackBar(snackBar);
//   }
//
//   Widget returnOTPScreen() {
//     return Scaffold(
//         key: _scaffoldKey,
//         appBar: new AppBar(
//           title: Text('OTP Screen'),
//         ),
//         body: ListView(children: [
//           Form(
//             key: _formKeyOTP,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                     child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 10.0, horizontal: 10.0),
//                         child: Text(
//                             !isLoading
//                                 ? "Enter OTP from SMS"
//                                 : "Sending OTP code SMS",
//                             textAlign: TextAlign.center))),
//                 !isLoading
//                     ? Container(
//                         child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 10.0, horizontal: 10.0),
//                         child: TextFormField(
//                           enabled: !isLoading,
//                           controller: otpController,
//                           keyboardType: TextInputType.number,
//                           inputFormatters: <TextInputFormatter>[
//                             FilteringTextInputFormatter.digitsOnly
//                           ],
//                           initialValue: null,
//                           autofocus: true,
//                           decoration: InputDecoration(
//                               labelText: 'OTP',
//                               labelStyle: TextStyle(color: Colors.black)),
//                           validator: (value) {
//                             if (value.isEmpty) {
//                               return 'Please enter OTP';
//                             }
//                           },
//                         ),
//                       ))
//                     : Container(),
//                 !isLoading
//                     ? Container(
//                         margin: EdgeInsets.only(top: 40, bottom: 5),
//                         child: Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 10.0),
//                             child: new ElevatedButton(
//                               onPressed: () async {
//                                 if (_formKeyOTP.currentState.validate()) {
//                                   // If the form is valid, we want to show a loading Snackbar
//                                   // If the form is valid, we want to do firebase signup...
//                                   setState(() {
//                                     isResend = false;
//                                     isLoading = true;
//                                   });
//                                   try {
//                                     await _auth
//                                         .signInWithCredential(
//                                             PhoneAuthProvider.credential(
//                                                 verificationId:
//                                                     verificationCode,
//                                                 smsCode: otpController.text
//                                                     .toString()))
//                                         .then((user) async => {
//                                               //sign in was success
//                                               if (user != null)
//                                                 {
//                                                   //store registration details in firestore database
//                                                   await _firestore
//                                                       .collection('users')
//                                                       .doc(
//                                                           _auth.currentUser.uid)
//                                                       .set(
//                                                           {
//                                                         'name': nameController
//                                                             .text
//                                                             .trim(),
//                                                         'cellnumber':
//                                                             cellnumberController
//                                                                 .text
//                                                                 .trim(),
//                                                       },
//                                                           SetOptions(
//                                                               merge:
//                                                                   true)).then(
//                                                           (value) => {
//                                                                 //then move to authorised area
//                                                                 setState(() {
//                                                                   isLoading =
//                                                                       false;
//                                                                   isResend =
//                                                                       false;
//                                                                 })
//                                                               }),
//
//                                                   setState(() {
//                                                     isLoading = false;
//                                                     isResend = false;
//                                                   }),
//                                                 }
//                                             })
//                                         .catchError((error) => {
//                                               setState(() {
//                                                 isLoading = false;
//                                                 isResend = true;
//                                               }),
//                                             });
//                                     setState(() {
//                                       isLoading = true;
//                                     });
//                                   } catch (e) {
//                                     setState(() {
//                                       isLoading = false;
//                                     });
//                                   }
//                                 }
//                               },
//                               child: new Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   vertical: 15.0,
//                                   horizontal: 15.0,
//                                 ),
//                                 child: new Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     new Expanded(
//                                       child: Text(
//                                         "Submit",
//                                         textAlign: TextAlign.center,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             )))
//                     : Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: <Widget>[
//                                 CircularProgressIndicator(
//                                   backgroundColor:
//                                       Theme.of(context).primaryColor,
//                                 )
//                               ].where((c) => c != null).toList(),
//                             )
//                           ]),
//                 isResend
//                     ? Container(
//                         margin: EdgeInsets.only(top: 40, bottom: 5),
//                         child: Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 10.0),
//                             child: new ElevatedButton(
//                               onPressed: () async {
//                                 setState(() {
//                                   isResend = false;
//                                   isLoading = true;
//                                 });
//                                 await signUp();
//                               },
//                               child: new Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   vertical: 15.0,
//                                   horizontal: 15.0,
//                                 ),
//                                 child: new Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     new Expanded(
//                                       child: Text(
//                                         "Resend Code",
//                                         textAlign: TextAlign.center,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             )))
//                     : Column()
//               ],
//             ),
//           )
//         ]));
//   }
//
//   Future validatePhoneNumber() async {
//     setState(() {
//       isLoading = true;
//     });
//     var _phoneNumber = numberController.text.trim();
//     var verifyPhoneNumber = _auth.verifyPhoneNumber(
//       phoneNumber: _phoneNumber,
//       verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
//         if (_auth.currentUser != null) {
//           await _users.doc(_auth.currentUser.uid).update(
//               {'phoneNumber': numberController.text.trim()}).then((value) {
//             setState(() {
//               isLoading = false;
//               isOTPScreen = false;
//             });
//           }).catchError((e) {
//             print("$e");
//           });
//         }
//       },
//       verificationFailed: (FirebaseAuthException error) {
//         debugPrint("Error validating :" + error.message);
//         setState(() {
//           isLoading = false;
//         });
//       },
//       codeSent: (verificationId, [forceResendingToken]) {
//         setState(() {
//           isLoading = false;
//           verificationCode = verificationId;
//         });
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         debugPrint('Gideon test 7');
//         setState(() {
//           isLoading = false;
//           verificationCode = verificationId;
//         });
//       },
//       timeout: Duration(seconds: 60),
//     );
//     debugPrint('Gideon test 7');
//     await verifyPhoneNumber;
//     debugPrint('Gideon test 8');
//   }
// }
