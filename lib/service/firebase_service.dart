import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paysar/screens/authentication/sign_up/create_emailphone_account/otp_screen.dart';
import 'package:paysar/screens/authentication/sign_up/create_emailphone_account/register_steps.dart';

class FirebaseService{
  String? _phoneNumber;
  String?  verificationId = null ;
  String? _otp, _authStatus = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<void> verifyPhoneNumber(BuildContext context,String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
     // timeout: const Duration(seconds: 15),
      verificationCompleted: (AuthCredential authCredential) {

          _authStatus = "Your account is successfully verified";
          print(_authStatus);

      },
      verificationFailed: (FirebaseAuthException authException) {
        print(authException);

          _authStatus = "Authentication failed";
          print(_authStatus);

      },
      codeSent: (String verId, [int? forceCodeResent]) {
        verificationId = verId;
        Navigator.push(context,MaterialPageRoute(builder: (context) =>OtpScreen(verificationId: verId,isForEmail: false,)));

          _authStatus = "OTP has been successfully send";
        print(_authStatus);


      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
        print(_authStatus);
          _authStatus = "TIMEOUT";

      },
    );
  }
  verifyOtp(String verificationId,String smsCode,BuildContext context) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

       var user = await _auth.signInWithCredential(credential);
       var currentUser = await _auth.currentUser;
       print(user);
       print(currentUser);
       if(currentUser != null){
         Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  RegisterSteps(stepIndex: 1,)));
       }


      //assert(user.user == currentUser.);
    //  Navigator.of(context).pop();
      //Navigator.of(context).pushReplacementNamed('/homepage');
    } catch (e) {
      print(e);
      print("failed");
    //  handleError(e);
    }
  }
}