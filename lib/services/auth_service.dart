import 'package:finance_app/models/user.dart';
import 'package:finance_app/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:finance_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService extends ChangeNotifier {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  SignedInUser _userFromFirebase(User user) {
    return user != null
        ? SignedInUser(
            uid: user.uid ?? "",
            photoURL: user.photoURL ?? "",
            email: user.email ?? "",
            name: user.displayName ?? "",
          )
        : null;
  }

  Stream<SignedInUser> get signedInUser {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future<UserCredential> continueWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    if (googleSignInAccount != null) {
      print(googleSignInAccount);
      final GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      try {
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        return e;
      }
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  // Future<UserCredential> signInWithFacebook() async {
  //   // Trigger the sign-in flow
  //   final AccessToken result = await FacebookAuth.instance.login();
  //   if (result != null) {
  //     // Create a credential from the access token
  //
  //     final facebookAuthCredential =
  //         FacebookAuthProvider.credential(result.token);
  //     print(result);
  //     print(result.token);
  //     print(facebookAuthCredential);
  //
  //     try {
  //       // Once signed in, return the UserCredential
  //       final userCredential =
  //           await _auth.signInWithCredential(facebookAuthCredential);
  //       if (userCredential.additionalUserInfo.isNewUser) {}
  //     } on FirebaseAuthException catch (e) {
  //       if (e.code == 'account-exists-with-different-credential') {
  //         // Lookup existing account’s provider ID.
  //         return _auth.fetchSignInMethodsForEmail(e.email).then((methods) {
  //           if (methods[0].toString() == "google.com") {
  //             var googleProvider = GoogleAuthProvider();
  //             // Sign in user to Google with same account.
  //             googleProvider.setCustomParameters({'login_hint': e.email});
  //             return _auth.signInWithRedirect(googleProvider).then((result) {
  //               return result;
  //             });
  //           }
  //         }).then((user) {
  //           // Existing email/password or Google user signed in.
  //           // Link Facebook OAuth credential to existing account.
  //           return user.linkWithCredential(e.credential);
  //         });
  //       }
  //     } catch (e) {}
  //   }
  // }
  //
  // Future<void> signInAnon() async {
  //   try {
  //     UserCredential userCredential = await _auth.signInAnonymously();
  //     User user = userCredential.user;
  //     print(user);
  //     return user;
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }
  //
  // Future signInUser({String email, String password}) async {
  //   try {
  //     final signInOption = await _auth.fetchSignInMethodsForEmail(email);
  //     // UserCredential userCredential = await _auth.signInWithEmailAndPassword(
  //     //     email: email, password: password);
  //     print(signInOption);
  //     // User user = userCredential.user;
  //     // return _userFromFirebase(user);
  //   } on FirebaseAuthException catch (e) {
  //     print(e.email);
  //     print(e.credential);
  //     // if (e.code == "wrong-password") {
  //     //   _auth.fetchSignInMethodsForEmail(e.email).then((providers) {
  //     //     print(providers[0]);
  //     //   });
  //     // }
  //   } catch (e) {
  //     return null;
  //   }
  // }

  //register with email and password
  // Future<void> registerUser({String email, String password}) async {
  //   try {
  //     UserCredential userCredential = await _auth
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //     User user = userCredential.user;
  //     return _userFromFirebase(user);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       return "weak-password";
  //     } else if (e.code == 'email-already-in-use') {
  //       print("email-already-in-use");
  //       return "email-already-in-use";
  //     } else if (e.code == 'account-exists-with-different-credential') {
  //       print("account-exists-with-different-credential");
  //       return "Already signed-In with Google please continue with that";
  //     } else if (e.code == 'invalid-credential') {
  //       // handle the error here
  //     }
  //     print(e.toString());
  //   } catch (e) {
  //     print(e.toString());
  //     return e;
  //   }
  // }

}
