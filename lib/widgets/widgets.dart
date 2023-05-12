
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Widget authStepWidget({required String stepTitle}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      paysarLogo(),
      SizedBox(height: 40,),
      Text(stepTitle,style: TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold),),
      SizedBox(height: 22,),
      Text("Almost there",style: TextStyle(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
      SizedBox(height: 8,),
      Text("we are excites to see you here!",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.normal)),
      SizedBox(height: 40,),
    ],
  );
}
Widget commonButton(BuildContext context,VoidCallback onTap){
  return Container(
   margin: EdgeInsets.symmetric(horizontal: 12),
    height: 50,
    width: MediaQuery.of(context).size.width,
    child: ElevatedButton(

      style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(214, 184, 127, 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)) ),//rgba(214, 184, 127, 1)
      onPressed: onTap, child: Text("Continue",style: TextStyle(fontSize: 20),),
    ),
  );
}
Widget backBtnWidget(BuildContext context,bool istrue){
  return       InkWell(
    onTap: (){ (!istrue)?Navigator.pop(context):FocusManager.instance.primaryFocus?.unfocus();
    ;} ,
    child: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(color: Colors.white,width: 2)),
        child: const Icon(Icons.arrow_back_ios_rounded,color: Colors.amber,size: 16,)),
  );
  //backgroundColor: Colors.transparent,elevation: 0),
}
Widget fwdIconWidget(BuildContext context){
  return Container(

      decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(color: Colors.black,width: 2)),
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: const Icon(Icons.arrow_forward_ios_rounded,color: Colors.amber,size: 16,),
      ));
  //backgroundColor: Colors.transparent,elevation: 0),
}


Widget paysarLogo(){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.account_balance_wallet,size: 52),
        Column(
          children: [
            Text("PAYSAR",style: TextStyle(color: Color.fromRGBO(20, 37, 124, 1.0),fontWeight: FontWeight.bold,fontSize: 18,),textAlign: TextAlign.end,softWrap: true),//21,30,79
            Text("باي صار",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18)),
          ],
        )
      ],
    ),
  );
}