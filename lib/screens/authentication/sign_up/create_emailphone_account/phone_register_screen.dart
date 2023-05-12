import 'package:flutter/material.dart';
import 'package:paysar/service/firebase_service.dart';
import 'package:paysar/widgets/auth_custom_textfield.dart';
import 'package:paysar/widgets/widgets.dart';
import 'package:sizer/sizer.dart';

class PhoneRegisterScreen extends StatefulWidget {
  const PhoneRegisterScreen({Key? key}) : super(key: key);

  @override
  State<PhoneRegisterScreen> createState() => _PhoneRegisterScreenState();
}

class _PhoneRegisterScreenState extends State<PhoneRegisterScreen> {
  TextEditingController _phoneController = TextEditingController(text: "+918691829922");
  TextEditingController _passController = TextEditingController();
  TextEditingController _ConfirmPassController = TextEditingController();
  FirebaseService firebaseService = FirebaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        bottomNavigationBar:   Padding(
          padding:  EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              commonButton(context,() {
                if(_phoneController.text.isNotEmpty){
                  print(_phoneController.text);
                 // sendOtp(_emailController.text);
                  firebaseService.verifyPhoneNumber(context, _phoneController.text);
                }else{
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(
                    content: Text("email required"),
                  ));
                }
              }),
              SizedBox(height: 30),
            ],
          ),
        ) ,

        backgroundColor: Color.fromRGBO(88, 196, 212, 1),
        appBar: AppBar(leading:backBtnWidget(context,false),backgroundColor: Colors.transparent,elevation: 0),

        body: SafeArea(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 18),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  authStepWidget(stepTitle: "Step 2. Add your phone number"),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AuthCustomTextfield(title: "phone",hint: "Enter your phone number",controller: _phoneController),
                        AuthCustomTextfield(title: "Password",hint: "Choose your password",controller: _passController, ),
                        AuthCustomTextfield(title: "Confirm Password ",hint: "Enter your previous password" ,controller: _ConfirmPassController),
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
