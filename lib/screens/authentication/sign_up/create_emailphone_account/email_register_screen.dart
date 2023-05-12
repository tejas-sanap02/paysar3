import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paysar/screens/authentication/sign_up/create_emailphone_account/otp_screen.dart';
import 'package:paysar/screens/authentication/sign_up/create_emailphone_account/phone_register_screen.dart';
import 'package:paysar/service/email_otp_service.dart';
import 'package:paysar/widgets/auth_custom_textfield.dart';
import 'package:paysar/widgets/widgets.dart';
import 'package:sizer/sizer.dart';

class CreateEmailPhoneAccount extends StatefulWidget {
  final bool isForEmail;
   CreateEmailPhoneAccount({Key? key, required this.isForEmail}) : super(key: key);

  @override
  State<CreateEmailPhoneAccount> createState() => _CreateEmailPhoneAccountState();
}

//
class _CreateEmailPhoneAccountState extends State<CreateEmailPhoneAccount> {
  EmailOTP myauth = EmailOTP();

  TextEditingController _emailController = TextEditingController(text: "rockingtejas2001@gmail.com");
  TextEditingController _passController = TextEditingController();
  TextEditingController _ConfirmPassController = TextEditingController();
  EmailOtpService emailOtpService = EmailOtpService();
  final loading = StateProvider((ref) => false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      extendBodyBehindAppBar: true,
      bottomNavigationBar:   Padding(
        padding:  EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            commonButton(context,() async{
              if(_emailController.text.isNotEmpty){
                print(_emailController.text);
               await emailOtpService.sendEmail(_emailController.text).then((value) {
                 if(value!=null){
                   print("One Time Otp Is $value");
                   Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                       OtpScreen( verificationId: '',isForEmail: true,otpValue: value,)));
                 }
               }
               );
              //  emailOtpService.sendOtp(_emailController.text, context);
               // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  PhoneRegisterScreen()));
               // sendOtp(_emailController.text);
              }else{
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(
                  content: Text("email required"),
                ));
              }
              }),
            SizedBox(height: 30,),
          ],
        ),
      ) ,

      backgroundColor:Color.fromRGBO(88, 196, 212, 1),
      appBar: AppBar(leading:backBtnWidget(context,false),backgroundColor: Colors.transparent,elevation: 0),

      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 18.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                authStepWidget(stepTitle: "Step 1. Create your account"),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AuthCustomTextfield(title: "Email",hint: "Enter your email",controller: _emailController),
                      AuthCustomTextfield(title: "Password",hint: "Choose your password",controller: _passController, ),
                      AuthCustomTextfield(title: "Confirm Password ",hint: "Enter your previous password",controller: _ConfirmPassController),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
