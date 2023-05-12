import 'dart:io';
import 'dart:math';

import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:paysar/screens/authentication/sign_up/create_emailphone_account/otp_screen.dart';

class EmailOtpService{

  EmailOTP myauth = EmailOTP();
  Future<void> sendingMail() async {
    try {
      var userEmail = 'rockingtejas2001@gmail.com';
      var message = Message();
      message.subject = "Subject from Flutter";
      message.text = "Heyy…..send from Flutter";
      message.from = Address ("vinayharane23@gmail.com");
      message.recipients.add (userEmail);
      var smtpServer = gmailSaslXoauth2("vinayharane23@gmail.com",'eukalwofnonekmae');

    await  send (message, smtpServer);
      print ("Email has been sent successfully.");
      } catch (e) {
        print("${e.toString()}");
        }
    }


  Future<void> verifyEmailOtp(String otp,BuildContext context) async {
    if (await myauth.verifyOTP(otp: otp) == true) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(
        content: Text("OTP is verified"),
      ));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(
        content: Text("Invalid OTP"),
      ));
    }
  }
  Future<int?> sendEmail(String emailId) async {

    var rmg = Random();
    var code = rmg.nextInt(900000)+100000;
    print("Otp :$code");
    // Note that using a username and password for gmail only works if
    // you have two-factor authentication enabled and created an App password.
    // Search for "gmail app password 2fa"
    // The alternative is to use oauth.
    String username = 'vinayharane23@gmail.com';
    String password = 'eukalwofnonekmae';

    final smtpServer = gmail(username, password);
    var connection = PersistentConnection(smtpServer);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, 'PaySar')
      ..recipients.add(emailId,)
     // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      //..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'PaySar: Email Otp Verification'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h3>Hello User ,</h3>\n<p>Use this OTP to complete your Sign Up procedures and verify your account on PaySar.</p>\n\n<center><h1><b>$code</b></h1></center>\n\n<p>OTP Expires in <b>2 minutes</b></p>\n<p>Remember, Never share this OTP with anyone,</p>\n\n<h3><b>- PaySar</b></h3>";

    try {
      final sendReport = await send(message, smtpServer);

      print('Message sent: ' + sendReport.toString());
      await connection.close();
      return code;
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
      await connection.close();
    }
    // DONE


    // Let's send another message using a slightly different syntax:
    //
    // Addresses without a name part can be set directly.
    // For instance `..recipients.add('destination@example.com')`
    // If you want to display a name part you have to create an
    // Address object: `new Address('destination@example.com', 'Display name part')`
    // Creating and adding an Address object without a name part
    // `new Address('destination@example.com')` is equivalent to
    // adding the mail address as `String`.
    // final equivalentMessage = Message()
    //   ..from = Address(username, 'PaySar')
    //   //..recipients.add(Address('destination@example.com'))
    //   ..ccRecipients.addAll([Address('destCc1@example.com'), 'destCc2@example.com'])
    //   ..bccRecipients.add('bccAddress@example.com')
    //   ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
    //   ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    //   ..html = '<h1>Test</h1>\n<p>Hey! Here is some HTML content</p><img src="cid:myimg@3.141"/>'
    //   ..attachments = [
    //     FileAttachment(File('exploits_of_a_mom.png'))
    //       ..location = Location.inline
    //       ..cid = '<myimg@3.141>'
    //   ];

   // final sendReport2 = await send(equivalentMessage, smtpServer);

    // Sending multiple messages with the same connection
    //
    // Create a smtp client that will persist the connection


    // Send the first message
   // await connection.send(message);

    // send the equivalent message
   // await connection.send(equivalentMessage);

    // close the connection



  }

  void sendOtp(String email,BuildContext context) async {
    myauth.setSMTP(host: "smtp.gmail.com",auth: true,username: "vinayharane23@gmail.com",password: "eukalwofnonekmae",secure: "TLS",port: 587);

    myauth.setConfig(

        appEmail: "sanaptejas01@gmail.com",
        appName: "PaySar",
        userEmail: email,
        otpLength: 6,
        otpType: OTPType.digitsOnly
    );
    if (await myauth.sendOTP() == true) {
      print("send otp");



      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(
        content: Text("OTP has been sent"),
      ));
      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  OtpScreen( verificationId: "", isForEmail: true,)));

    } else {
      print("failed ");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(
        content: Text("Oops, OTP send failed"),
      ));
    }
  }
}