import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lexsolve_2/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'forgotpassword.dart';






class LoginPage extends StatefulWidget {

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

var status;


  @override
  void initState() {
    super.initState();
  UserStatus();



  }


  var isExpired;
 UserStatus() async
{
  SharedPreferences preferences=await SharedPreferences.getInstance();
status=await preferences.getBool("isExpired");

print("VALUE OF STATUS $status");

}

  final _formkey=GlobalKey<FormState>();
  final formWebKey=GlobalKey<FormState>();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController emailWeb=TextEditingController();
  TextEditingController paassWeb=TextEditingController();




  @override
  Widget build(BuildContext context) {




    Size size=MediaQuery.of(context).size;
    var width=size.width;
    var height=size.height;
    setState(() {
     width=size.width;
     height=size.height;
    });



    return Scaffold(

        body: Stack(

          children: [

            Image.asset("assets/backgroundapp.png",width: width,height: height,fit: BoxFit.cover,),



            (width<600) ?  Form(
              key: _formkey,
              child: SingleChildScrollView(
                  child:

                  Column(
                    children: [

                      SizedBox(height: height/3,),
                      Container(
                        padding: EdgeInsets.only(left: 20,right: 20),
                        height: height-height/3,
                        width: width,

                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),topRight: Radius.circular(30)

                            )
                        ),

                        child: Column(
                          children: [

                            SizedBox(height: 40,),
                            Text("Welcome Back ",style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold,fontSize: 30,color: Color.fromARGB(
                                255, 12, 68, 163)),textAlign: TextAlign.center,),
                            SizedBox(height: 30,),

                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: email,
                              decoration: InputDecoration(


                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)


                                  ),hintText: "EMAIL ID",
                                  labelText: "EMAIL",prefixIcon: Icon(Icons.mail_lock)

                              ),
                              validator: (value){
                                if(value==null || value.isEmpty)
                                {
                                  return "PLEASE FILL THIS FIELD";
                                }
                              },
                            ),
                            SizedBox(height: 30,),
                            TextFormField(
                              autocorrect: true ,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: password,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)


                                  ),hintText: "PASSWORD",
                                  labelText: "PASSWORD",prefixIcon: Icon(FontAwesomeIcons.userSecret)

                              ), validator: (value){
                              if(value==null || value.isEmpty)
                              {
                                return "PLEASE FILL THIS FIELD";
                              }
                            },
                            ),
                            SizedBox(height: 20,),
                            GestureDetector(
                              onTap: (){

                                print("FORGOT PASSWORD IS CLICKED");
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));
                                },
                              child: Container(
                                  alignment: Alignment.bottomRight,
                                  child: Text("Forgot Password ?",textAlign: TextAlign.end,style: GoogleFonts.aBeeZee(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.w800
                                  ),)
                              ),
                            ),


                            SizedBox(height: 30,),

                            Container(
                              width: double.infinity,

                              child: ElevatedButton(onPressed: (){
                                print("SIGN IN");
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>FreeHomePage()));

                                if(_formkey.currentState!.validate())
                                {
                                  print("HI");
                                  userLogin(email.text,password.text);
                                }


                              }, child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text("SIGN IN")),style:ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromARGB(
                                      255, 12, 68, 163),

                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                  )

                              ),),
                            ),


                            SizedBox(height: 30,),
                            Text("----------------Sign in With -----------------"),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(onPressed: (){}, icon: Image.asset("assets/icons8-google-48.png")),
                                IconButton(onPressed: (){}, icon: Image.asset("assets/icons8-apple-logo-50.png")),
                                IconButton(onPressed: (){}, icon: Image.asset("assets/icons8-facebook-48.png")),

                              ],
                            )




                          ],
                        ),
                      )



                    ],
                  )


              ),
            ):


// For Web

            LoginPageForWeb()











          ],



        )




    ) ;
      

  }
  userLogin(email,password) async
  {
      try{
        print(email);


        var request=(await http.post(Uri.parse("http://192.168.1.8:3030/login"),headers: {

            "Content-Type":"application/json"

        },body: jsonEncode({

          "email_id":email,
          "password":password

        })

        ));

      var response=request;
    var jsonResponse=jsonDecode(response.body);
print(jsonResponse);

      if(response.statusCode==404)
        {
          Fluttertoast.showToast(msg: jsonResponse["message"]);
          return;
        }

        if(response.statusCode==404 && jsonResponse["message"]=="password incorrect")
        {
          Fluttertoast.showToast(msg: "INCORRECT PASSWORD ENTERED");
          print("INCORRECT PASSWORD ENTERED");
          return;

        }


  setState(() {
    saveData(jsonResponse);


  });

  if(response.statusCode==404 && jsonResponse["message"]=="PASSWORD INCORRECT")
    {
      Fluttertoast.showToast(msg: "INCORRECT PASSWORD ENTERED");
      print("INCORRECT PASSWORD ENTERED");

    }









      }
      catch(e)
    {
      throw e;
    }
  }

  saveData(response) async
  {
    print("SAve data function called");
    isExpired= JwtDecoder.isExpired(response["token"]);
    print(isExpired);
    DateTime dateexpiry=JwtDecoder.getExpirationDate(response["token"]);
    String date=dateexpiry.day.toString();


    SharedPreferences prefs=await SharedPreferences.getInstance();
    await prefs.setBool("isExpired", isExpired);
    await prefs.setString("email", response["email"]);
    await prefs.setString("id", response["id"]);
    await prefs.setString("date", date);
    await prefs.setString("token", response["token"]);
    print("valid is ${prefs.getBool("isExpired") } email is ${prefs.getString("email")}");

    // var ans=await UserStatus();
    // print("USER VALID STATSUS $ans");


    Navigator.push(context,MaterialPageRoute(builder: (context)=>Homepage()) );
  }







}









class LoginPageForWeb extends StatefulWidget {
  const LoginPageForWeb({super.key});

  @override
  State<LoginPageForWeb> createState() => _LoginPageForWebState();
}

class _LoginPageForWebState extends State<LoginPageForWeb> {

  final formWebKey=GlobalKey<FormState>();
  TextEditingController emailWeb=TextEditingController();
  TextEditingController paassWeb=TextEditingController();



  @override
  Widget build(BuildContext context) {
  Size size=MediaQuery.of(context).size;

    var width=size.width;
    var height=size.height;
    setState(() {
      width=size.width;
      height=size.height;
    });

    return Form(
      key: formWebKey,
      child: SingleChildScrollView(
        child
            : Column(

          children: [
            Text(width.toString()),
            SizedBox(height: height/3.5),
            Container(
              margin: (width>600 && width<700)?(EdgeInsets.only(left: 20,right: 20,bottom: 50)):(width>701 && width<900)?(EdgeInsets.only(left: 75,right: 75,bottom: 50)):(width>901 && width<1100)?(EdgeInsets.only(left: 100,right: 100,bottom: 50)):(width>1101 && width<1300)?(EdgeInsets.only(left: 150,right: 150,bottom: 50)):(EdgeInsets.only(right: 300,left: 300,bottom: 100)),
              padding: (width>600 && width<700)?(EdgeInsets.only(left: 20,right: 20)):(width>701 && width<900)?(EdgeInsets.only(left: 75,right: 75)):(width>901 && width<1300)?(EdgeInsets.only(left: 85,right: 85)):(EdgeInsets.only(left: 100,right: 100)),



              decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),

              height: height-height/3.5,
              child: Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  children: [





                    SizedBox(height: 40,),
                    Text("Welcome Back ",style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold,fontSize: 30,color: Color.fromARGB(
                        255, 12, 68, 163)),textAlign: TextAlign.center,),

                    SizedBox(height: 50,),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: emailWeb,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)


                          ),hintText: "EMAIL ID",
                          labelText: "EMAIL",prefixIcon: Icon(Icons.mail)

                      ),
                      validator: (value){
                        if(value==null && value!.isEmpty)
                        {
                          return "PLEASE FILL THIS FIELD";
                        }

                      },
                    ),
                    SizedBox(height: 30,),  TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: paassWeb,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)


                            ),hintText: "PASSWORD",
                            labelText: "PASSWORD",prefixIcon: Icon(Icons.mail)

                        ),
                        validator: (value){
                          if(value==null && value!.isEmpty)
                          {

                            return "PLEASE FILL THIS FIELD";
                          }

                        }
                    ),

                    SizedBox(height: 30,),

                    GestureDetector(
                      onTap: (){
                        print("FORGOT PASSWORD IS CLICKED");
                      },
                      child: Container(
                          alignment: Alignment.bottomRight,
                          child: Text("Forgot Password ?",textAlign: TextAlign.end,style: GoogleFonts.aBeeZee(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w800
                          ),)
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: double.infinity,

                      child: ElevatedButton(onPressed: (){
                        if(formWebKey.currentState!.validate())
                        {
                          print("Clicked for web ");
                          userLogin(emailWeb.text,paassWeb.text);


                        }


                      }, child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text("SIGN IN")),style:ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(
                              255, 12, 68, 163),

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          )

                      ),),
                    ),

                    SizedBox(height: 30,),
                    Text("----------------Sign in With -----------------"),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(onPressed: (){}, icon: Image.asset("assets/icons8-google-48.png")),
                        IconButton(onPressed: (){}, icon: Image.asset("assets/icons8-apple-logo-50.png")),
                        IconButton(onPressed: (){}, icon: Image.asset("assets/icons8-facebook-48.png")),

                      ],
                    )



                  ],
                ),
              ),

            )

          ],



        ),
      ),
    );
  }
  userLogin(email,password) async
  {
    try{
      print(email);


      var request=(await http.post(Uri.parse("http://192.168.1.8:3030/login"),headers: {

        "Content-Type":"application/json"

      },body: jsonEncode({
        "email_id":email,
        "password":password

      })

      ));

      var response=request;
      print(jsonDecode(response.body));




    }
    catch(e)
    {
      throw e;
    }
  }

}


/*


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


    Size size=MediaQuery.of(context).size;
    var width=size.width;
    var height=size.height;
    setState(() {
     width=size.width;
     height=size.height;
    });
    TextEditingController email=TextEditingController();
    TextEditingController password=TextEditingController();


    return Scaffold(

      body: SingleChildScrollView(



        child:

       // (width<600)?

        Column(

          children: [

            Image.asset("assets/backgroundapp.png",width: double.infinity,height: double.infinity,fit: BoxFit.cover,),


            // Text(width.toString()),
            SizedBox(height: height/3.5),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)
                )
              ),

              height: height-height/3.5,
              child: Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [





                      SizedBox(height: 40,),
                      Text("Welcome Back ",style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold,fontSize: 30,color: Color.fromARGB(
                          255, 12, 68, 163)),textAlign: TextAlign.center,),

                      SizedBox(height: 50,),
                      TextFormField(

                        controller: email,
                        decoration: InputDecoration(

                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)


                          ),hintText: "EMAIL ID",
                          labelText: "EMAIL",prefixIcon: Icon(Icons.mail)

                        ),

                        validator: (value){
                          if(value!.isEmpty)
                            {
                              return "PLEASE FILL THIS FIELD";
                            }
                        },
                      ),
                      SizedBox(height: 30,),

                      TextFormField(


                        controller: password,
                        decoration: InputDecoration(

                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)


                            ),hintText: "PASSWORD",
                            labelText: "PASSWORD",prefixIcon: Icon(Icons.mail)

                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return "PLEASE FILL THIS FIELD";

                          }
                        },
                      ),

                      SizedBox(height: 30,),

                      GestureDetector(
                        onTap: (){
                          print("FORGOT PASSWORD IS CLICKED");
                        },
                        child: Container(
                          alignment: Alignment.bottomRight,
                          child: Text("Forgot Password ?",textAlign: TextAlign.end,style: GoogleFonts.aBeeZee(
                              color: Colors.blueAccent,
                            fontWeight: FontWeight.w800
                            ),)
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: double.infinity,

                        child: ElevatedButton(onPressed: (){

                            if(_formkey.currentState!.validate())
                              {
                                print("USER ENTERED SUCCESSFULLY");
                                loginUser(email.text, password.text);
                              }




                        }, child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text("SIGN IN")),style:ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(
                              255, 12, 68, 163),

                            shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                            )

                        ),),
                      ),

                      SizedBox(height: 30,),
                      Text("----------------Sign in With -----------------"),
                     SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(onPressed: (){}, icon: Image.asset("assets/icons8-google-48.png")),
                          IconButton(onPressed: (){}, icon: Image.asset("assets/icons8-apple-logo-50.png")),
                          IconButton(onPressed: (){}, icon: Image.asset("assets/icons8-facebook-48.png")),

                        ],
                      )



                    ],
                  ),
                ),
              ),

            )

          ],



          )

   //         :
      //   //For web
      //   Container(
      //
      //
      //
      //     decoration: BoxDecoration(
      //         image: DecorationImage(image: AssetImage(
      //             "assets/backgroundapp.png"
      //         ),fit: BoxFit.cover)
      //     ),
      //     child: Column(
      //
      //       children: [
      //         Text(width.toString()),
      //         SizedBox(height: height/3.5),
      //         Container(
      //           margin: (width>600 && width<700)?(EdgeInsets.only(left: 20,right: 20,bottom: 50)):(width>701 && width<900)?(EdgeInsets.only(left: 75,right: 75,bottom: 50)):(width>901 && height<1100)?(EdgeInsets.only(left: 85,right: 85,bottom: 50)):(EdgeInsets.only(left: 300,right: 300,bottom: 50)),
      //           padding: (width>600 && width<700)?(EdgeInsets.only(left: 20,right: 20)):(width>701 && width<900)?(EdgeInsets.only(left: 75,right: 75)):(width>901 && height<1100)?(EdgeInsets.only(left: 85,right: 85)):(EdgeInsets.only(left: 150,right: 150)),
      //
      //
      //
      //           decoration: BoxDecoration(
      //               color: Colors.white,
      //
      //               borderRadius: BorderRadius.all(Radius.circular(20))
      //           ),
      //
      //           height: height-height/3.5,
      //           child: Container(
      //             margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      //             child: Column(
      //               children: [
      //
      //
      //
      //
      //
      //                 SizedBox(height: 40,),
      //                 Text("Welcome Back ",style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold,fontSize: 30,color: Color.fromARGB(
      //                     255, 12, 68, 163)),textAlign: TextAlign.center,),
      //
      //                 SizedBox(height: 50,),
      //                 TextFormField(
      //                   controller: email,
      //                   decoration: InputDecoration(
      //                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)
      //
      //
      //                       ),hintText: "EMAIL ID",
      //                       labelText: "EMAIL",prefixIcon: Icon(Icons.mail)
      //
      //                   ),
      //                 ),
      //                 SizedBox(height: 30,),  TextFormField(
      //                controller: password,
      //                   decoration: InputDecoration(
      //                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)
      //
      //
      //                       ),hintText: "PASSWORD",
      //                       labelText: "PASSWORD",prefixIcon: Icon(Icons.mail)
      //
      //                   ),
      //                 ),
      //
      //                 SizedBox(height: 30,),
      //
      //                 GestureDetector(
      //                   onTap: (){
      //                     print("FORGOT PASSWORD IS CLICKED");
      //                   },
      //                   child: Container(
      //                       alignment: Alignment.bottomRight,
      //                       child: Text("Forgot Password ?",textAlign: TextAlign.end,style: GoogleFonts.aBeeZee(
      //                           color: Colors.blueAccent,
      //                           fontWeight: FontWeight.w800
      //                       ),)
      //                   ),
      //                 ),
      //                 SizedBox(height: 20,),
      //                 Container(
      //                   width: double.infinity,
      //
      //                   child: ElevatedButton(onPressed: (){
      //                    if(_formkey.currentState!.validate())
      //                      {
      //                        print("Clicked for web");
      //                        loginUser(email.text, password.text);
      //                      }
      //
      //
      //                   }, child: Padding(
      //                       padding: EdgeInsets.all(20),
      //                       child: Text("SIGN IN")),style:ElevatedButton.styleFrom(
      //                       backgroundColor: Color.fromARGB(
      //                           255, 12, 68, 163),
      //
      //                       shape: RoundedRectangleBorder(
      //                           borderRadius: BorderRadius.all(Radius.circular(20))
      //                       )
      //
      //                   ),),
      //                 ),
      //
      //                 SizedBox(height: 30,),
      //                 Text("----------------Sign in With -----------------"),
      //                 SizedBox(height: 10,),
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                   children: [
      //                     IconButton(onPressed: (){}, icon: Image.asset("assets/icons8-google-48.png")),
      //                     IconButton(onPressed: (){}, icon: Image.asset("assets/icons8-apple-logo-50.png")),
      //                     IconButton(onPressed: (){}, icon: Image.asset("assets/icons8-facebook-48.png")),
      //
      //                   ],
      //                 )
      //
      //
      //
      //               ],
      //             ),
      //           ),
      //
      //         )
      //
      //       ],
      //
      //
      //
      //     ),
      //   )
      //
      //
      //
      //
      //
      //
       )




    );
  }


  Future<void> loginUser(String email,String password) async
  {


      var response=await http.post(Uri.parse("http://192.168.1.8:3030/login"),headers: {
        "Content-Type":"application/json"
      },body: jsonEncode({
        "email_id":email,
        "password":password

      })


      );
    var details=jsonDecode(response.body);
    if(response.statusCode==404 && details["message"]=="password incorrect")
      {
          print("PASSWORD INCORRECT");
          Fluttertoast.showToast(msg: "PASSWORD INCORRECT");
      }







  }

}


 */


