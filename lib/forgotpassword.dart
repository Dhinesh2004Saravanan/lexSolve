import 'dart:convert';

import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'changepassword.dart';




class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {



// initialisation
EmailOTP myauth=EmailOTP();
var initialOTP;
var otphash;
var otpEntered;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
     generateOtp();
  }

generateOtp() async
{
 try{

   SharedPreferences preferences=await SharedPreferences.getInstance();
  var emailid="dhinesh2004saravanan@gmail.com";
   var response=await http.post(Uri.parse("http://192.168.1.8:3030/otp"),headers: {"Content-Type":"application/json"},
   body: jsonEncode({
    "email_id":emailid

   })
   );
   var result=jsonDecode(response.body);
   setState(() {
     initialOTP=result["otp"];
     otphash=result["hash"];
   });
   print(initialOTP);



 }
 catch(e)
  {

  }

}

verifyOtp(otp) async{
  var response=await http.post(Uri.parse("http://192.168.1.8:3030/verifyotp"),headers: {
      "Content-Type":"application/json"
  },

  body: jsonEncode({
    "emailid":"dhinesh2004saravanan@gmail.com",
    "otp":otp,
    "hash":otphash,

  })
  );

 var answerOtp=jsonDecode(response.body);
 var isVerified=answerOtp["status"];
 if(isVerified==true)
   {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>changePassword()));
   }


}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("LEXSOLVE"),
      // ),
      body: SafeArea(
        child: Column(
          children: [

            SizedBox(height:100,),
            Text("Verification Code ",style: GoogleFonts.aBeeZee(
              fontSize: 30,fontWeight: FontWeight.bold,
              color: Colors.grey
            ),),

            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.all(20),
              child: Text("Please Enter your 6 digit Verification Code that has been sent to your email",style: GoogleFonts.aBeeZee(
                fontSize: 20
              ),),
            ),
            OtpTextField(

              numberOfFields: 6,
              showFieldAsBox: true  ,
              borderColor: Colors.black,
              onSubmit: (String code){
                setState(() {
                  otpEntered=code;
                  print(otpEntered);
                });
              },

            ),
            SizedBox(height: 20,),
            TextButton(onPressed: (){}, child: Text("RESEND CODE",style: GoogleFonts.aBeeZee(color: Colors.grey),))



            ,SizedBox(height: 20,),
            Container(
              width: double.infinity
                ,margin: EdgeInsets.fromLTRB(20, 0, 20, 0),

              child: ElevatedButton(onPressed: (){
              print("OTP ENTERED $otpEntered");
                verifyOtp(otpEntered);

              }, child:
              Padding
                (
                padding: const EdgeInsets.only(top: 20,bottom: 20),
                child: Text("SUBMIT"),
              ),style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(

                              borderRadius: BorderRadius.all(Radius.circular(20))
                )
              ),),
            )


          ],
        ),
      ),
    );
  }
}
