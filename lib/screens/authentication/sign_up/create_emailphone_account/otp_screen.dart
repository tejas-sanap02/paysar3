import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:paysar/screens/authentication/sign_up/create_emailphone_account/register_steps.dart';
import 'package:paysar/service/email_otp_service.dart';
import 'package:paysar/service/firebase_service.dart';
import 'package:paysar/widgets/widgets.dart';
import 'dart:convert';

import 'package:sizer/sizer.dart';

class OtpScreen extends StatefulWidget {
  final bool isForEmail;
   int? otpValue;
  final String verificationId;
   OtpScreen({Key? key, required this.verificationId, required this.isForEmail,this.otpValue}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  FirebaseService firebaseService =FirebaseService();
  TextEditingController otpController = TextEditingController();
  EmailOtpService emailOtpService = EmailOtpService();
  bool _keyboardVisible = false;
  String? otp;
  @override
  void initState() {
    Future.delayed( Duration(minutes: 2), () {
      widget.otpValue = null;
      print('Otp Expired');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
        extendBodyBehindAppBar: true,
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              commonButton(context, () {
                if(otp != null){
                  print((widget.isForEmail)?"Email verificaation":"Phone verification");
                  print("Otp is ${widget.otpValue}  $otp");
                if(widget.isForEmail){
                  if(widget.otpValue.toString() == otp){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  RegisterSteps(stepIndex: 0,)));

                  }else{
                    ScaffoldMessenger.of(context)
                        .showSnackBar( SnackBar(
                      content: Text((widget.otpValue!=null)?"invalid Otp":"Otp Expired"),
                    ));
                  }

                }else{
                    firebaseService.verifyOtp(widget.verificationId, otp!,context);
                  }
                }

                // if(true == true){
                //  // print(_emailController.text);
                //   //sendOtp(_emailController.text);
                // }else{
                //   ScaffoldMessenger.of(context)
                //       .showSnackBar(const SnackBar(
                //     content: Text("email required"),
                //   ));
                // }
              }),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromRGBO(88, 196, 212, 1),
        appBar: AppBar(
            leading: backBtnWidget(context,_keyboardVisible),
            backgroundColor: Colors.transparent,
            elevation: 0),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: SingleChildScrollView(
              child: Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,

                mainAxisSize: MainAxisSize.min,
                children: [
                  authStepWidget(stepTitle: "Step 1. Create your account"),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          (widget.isForEmail)?"Email\nverification":"Phone\nverification",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 24.sp, color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 26,),
                        Text(
                          "Enter 6 - digit number that send\nTo your Email",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 12.sp, color: Colors.white),
                        ),
                        SizedBox(height: 32,),
                        OTPTextField(
                          length: 6,
                          otpFieldStyle: OtpFieldStyle(backgroundColor: Colors.white,borderColor: Colors.white ),
                          width: MediaQuery.of(context).size.width,
                          fieldWidth: 48,

                          style: TextStyle(
                              fontSize: 34
                          ),
                          onChanged: (value){

                          },
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldStyle: FieldStyle.box,
                          onCompleted: (pin) {
                            otp = pin;
                            print("Completed: " + pin);
                          },
                        ),
                        SizedBox(height: 16,),
                        Text("Re-send code in 0:34")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
