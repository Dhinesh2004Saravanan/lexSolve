


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lexsolve_2/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formkey=GlobalKey<FormState>();
  final formWebKey=GlobalKey<FormState>();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController emailWeb=TextEditingController();
  TextEditingController paassWeb=TextEditingController();
  TextEditingController name=TextEditingController();

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
                child: Column(
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

                      child: SingleChildScrollView(
                        child: Column(
                          children: [

                            SizedBox(height: 40,),
                            Text("Get Started",style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold,fontSize: 30,color: Color.fromARGB(
                                255, 12, 68, 163)),textAlign: TextAlign.center,),
                            SizedBox(height: 30,),
                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller:name ,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)


                                  ),hintText: "USERNAME",
                                  labelText: "NAME",prefixIcon: Icon(FontAwesomeIcons.person)

                              ),
                              validator: (value){
                                if(value!.isEmpty){
                                  return "PLEASE FILL THIS FIELD";
                                }
                              },
                            ),
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
                            SizedBox(height: 30,),


                            Container(
                              width: double.infinity,

                              child: ElevatedButton(onPressed: (){
                                print("SIGN IN");
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>FreeHomePage()));

                                if(_formkey.currentState!.validate())
                                {
                                  print("HI");
                                  registerFunc(name.text,email.text,password.text);
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
            ):

// For Web
           RegisterPageforWeb()












          ],



        )




    );
  }


  registerFunc(name,email,password) async
  {
    try {
      print("NAME $name");

      var request = await http.post(
          Uri.parse("http://192.168.1.8:3030/register"), headers: {
        "Content-Type": "application/json"
      },

          body: jsonEncode({
            "name":name,
            "email_id": email,
            "password": password
          })
      );



      var response = jsonDecode(request.body);
      if (request.statusCode == 404 && response["message"] ==
      "USER ALREADY REGISTERED") {
        print("USER ALREADY REGISTERED");
        return ;

      }
      SharedPreferences preferences=await SharedPreferences.getInstance();
      await preferences.setString("name", name);

      Fluttertoast.showToast(msg:"REGISTRATION SUCCESSFUL");

        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));

    }
    catch(e)
    {
      throw e;
    }
  }
}



















class RegisterPageforWeb extends StatefulWidget {
  const RegisterPageforWeb({super.key});

  @override
  State<RegisterPageforWeb> createState() => _RegisterPageforWebState();
}

class _RegisterPageforWebState extends State<RegisterPageforWeb> {

  TextEditingController emailWeb=TextEditingController();
  TextEditingController paassWeb=TextEditingController();
  TextEditingController name=TextEditingController();
  final formWebKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


    Size size=MediaQuery.of(context).size;
    var width=size.width;
    var height=size.height;
    setState(() {
      width=size.width;
      height=size.height;
    });


    return     Form(
      key: formWebKey,
      child: SingleChildScrollView(
        child
            : Column(

          children: [
            Text(width.toString()),
            SizedBox(height: height/3.5),
            Container(
              margin: (width>600 && width<700)?(EdgeInsets.only(left: 20,right: 20,bottom: 50)):(width>701 && width<900)?(EdgeInsets.only(left: 75,right: 75,bottom: 50)):(width>901 && height<1100)?(EdgeInsets.only(left: 85,right: 85,bottom: 50)):(EdgeInsets.only(left: 300,right: 300,bottom: 50)),
              padding: (width>600 && width<700)?(EdgeInsets.only(left: 20,right: 20)):(width>701 && width<900)?(EdgeInsets.only(left: 75,right: 75)):(width>901 && height<1100)?(EdgeInsets.only(left: 85,right: 85)):(EdgeInsets.only(left: 150,right: 150)),



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
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      //   autovalidateMode: AutovalidateMode.onUserInteraction,
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

                          //  loginUser(email.text, password.text);
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
}




