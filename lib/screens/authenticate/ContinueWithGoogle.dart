import 'package:country_code_picker/country_code_picker.dart';
import 'package:finance_app/screens/authenticate/newUser.dart';
import 'package:finance_app/screens/loading.dart';
import 'package:finance_app/screens/wrapper.dart';
import 'package:finance_app/services/database_service.dart';
import 'package:finance_app/widgets/continue_with_google_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:finance_app/services/auth_service.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:finance_app/screens/home.dart';

class ContinueWithGoogle extends StatefulWidget {
  @override
  _ContinueWithGoogleState createState() => _ContinueWithGoogleState();
}

class _ContinueWithGoogleState extends State<ContinueWithGoogle> {
  String _countryCode;
  String _phoneNumber;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Container(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 70.0, 0.0, 0.0),
                  child: Text(
                    "Welcome to\nFinoEase",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 8.0),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: CountryCodePicker(
                                showFlag: true,
                                showCountryOnly: false,
                                // showDropDownButton: true,
                                alignLeft: false,
                                hideMainText: false,
                                initialSelection: 'IN',
                                favorite: ['+91', "IN", "US"],
                                onInit: (countryCode) {
                                  _countryCode = countryCode.toString();
                                  print(_countryCode);
                                },
                                onChanged: (countryCode) {
                                  setState(() {
                                    _countryCode = countryCode.toString();
                                    print(_countryCode);
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: VerticalDivider(
                                color: Colors.black,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Phone Number",
                                  border: InputBorder.none,
                                ),
                                validator: (val) => val.length != 10
                                    ? 'Enter a mobile number of 10 digits'
                                    : null,
                                onChanged: (val) {
                                  setState(() {
                                    _phoneNumber = val;
                                  });
                                  print(_phoneNumber);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: RaisedButton(
                          color: Colors.pink,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          onPressed: (() {}),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "Request OTP",
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(children: <Widget>[
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        height: 36,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "OR",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                        child: Divider(
                      color: Colors.grey,
                      height: 36,
                    )),
                  ]),
                ),
                ContinueWithGoogleButton(
                  function: (() async {
                    setState(() {
                      isLoading = true;
                    });
                    UserCredential result =
                        await AuthService().continueWithGoogle();
                    final currentUser = result.user;
                    if (result.additionalUserInfo.isNewUser) {
                      await DatabaseService().addUser(
                          name: currentUser.displayName,
                          email: currentUser.email,
                          uid: currentUser.uid,
                          phoneNumber: currentUser.phoneNumber,
                          photoUrl: currentUser.photoURL);
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => NewUser(),
                        ),
                      );
                    }
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Wrapper()));
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Text(
                        "Not registered yet?",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14.0),
                      ),
                      GestureDetector(
                        onTap: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewUser()));
                        }),
                        child: Text(
                          " Create an Account",
                          style: TextStyle(
                              color: Colors.pink,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          isLoading
              ? Center(child: Loading())
              : Container(
                  width: 0.0,
                  height: 0.0,
                ),
        ]),
      ),
    );
  }
}
