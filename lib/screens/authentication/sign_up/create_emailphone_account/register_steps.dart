import 'package:flutter/material.dart';
import 'package:paysar/screens/authentication/sign_up/create_emailphone_account/biometric.dart';
import 'package:paysar/screens/authentication/sign_up/create_emailphone_account/phone_register_screen.dart';
import 'package:paysar/widgets/widgets.dart';
import 'package:sizer/sizer.dart';

class RegisterSteps extends StatefulWidget {
  final int stepIndex;
   RegisterSteps({Key? key, required this.stepIndex}) : super(key: key);

  @override
  State<RegisterSteps> createState() => _RegisterStepsState();
}

class _RegisterStepsState extends State<RegisterSteps> {
  Map<String, String> stepsList = {
    "Step 1. Create your Email Account: ":
        "Form is field and your email account is ready",
    "Step 2. Phone Number": "Add your Phone Number",
    "Step 3. Biometric": "Take selfie and scan Passport",
    "Step 4. Link Account": "Take selfie and scan Passport",
    "Step 5. Saudi Visa": "Take selfie and scan Passport"
  };
  List<String> stepsTitle = [
    "Your Account is almost Ready",
    "Your Phone Number is Ready",
    "Your step 3 Biometric is Ready",
    "Your step 4 Link Account is Ready"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: backBtnWidget(context, false),
            backgroundColor: Colors.transparent,
            elevation: 0),
        backgroundColor: Color.fromRGBO(88, 196, 212, 1), //88, 19   6, 212
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 22.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          'assets/logo/check.png',
                          height: 62,
                          width: 62,
                        ),
                        SizedBox(height: 32,),
                        Center(
                            child: Text(
                          stepsTitle[widget.stepIndex],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600),
                        )),
                      ],
                    ),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: stepsList.length,
                    itemBuilder: (context, index) {
                      return StepsCard2(
                          stepIndex: widget.stepIndex + 1,
                          listIndex: index,
                          stepsKey: stepsList.keys.elementAt(index),
                          stepsValue: stepsList.values.elementAt(index));
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
  bool nextStepNavigate({required int stepIndex,required int listIndex,})  {

    if(stepIndex == listIndex && listIndex == 1){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  PhoneRegisterScreen()));
      return true;
    }else if(stepIndex == listIndex && listIndex == 2){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  BiometricScreen()));
      return true;
    }else if(stepIndex == listIndex && listIndex == 3){
   //   Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  RegisterSteps(stepIndex: 0,)));
      return true;
    }else if(stepIndex == listIndex && listIndex == 4){
    //  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  RegisterSteps(stepIndex: 0,)));
      return true;
    }
    return false;

  }

  Widget StepsCard2(
      {required int stepIndex,
      required int listIndex,
      required String stepsKey,
      required String stepsValue
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: InkWell(
        onTap:(){
          print(stepIndex);
          print("current index: ${listIndex}");
          nextStepNavigate(stepIndex: stepIndex, listIndex: listIndex);
        } ,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color.fromRGBO(119, 255, 3, 1)),
          //rgba(119, 255, 3, 1)
          child: Padding(
            padding: EdgeInsets.only(
                left: (stepIndex == listIndex)
                    ? 0
                    : (stepIndex < listIndex)
                        ? 0
                        : 20),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: (stepIndex <= listIndex)
                      ? BorderRadius.circular(12)
                      : BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12)),
                  color: (stepIndex == listIndex)
                      ? Colors.white
                      : (stepIndex < listIndex)
                          ? Color.fromRGBO(224, 224, 224, 1)
                          : Color.fromRGBO(235, 255, 219,
                              1)), //rgba(224, 224, 224, 1)//rgba(235, 255, 219, 1)
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 20, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          stepsKey,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 9.8.sp,
                          ),
                          softWrap: true,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(stepsValue,
                            style: TextStyle(fontSize: 9.8.sp), softWrap: true),
                      ],
                    ),
                    Visibility(
                      visible: (stepIndex >= listIndex),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: (stepIndex == listIndex)
                            ? fwdIconWidget(context)
                            : Image.asset(
                                'assets/logo/check.png',
                                height: 22,
                                width: 22,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
