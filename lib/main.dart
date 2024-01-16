
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lexsolve_2/homepage.dart';
import 'package:lexsolve_2/login.dart';
import 'package:lexsolve_2/registerpage.dart';
import 'package:shared_preferences/shared_preferences.dart';



Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences preferences=await SharedPreferences.getInstance();
  var val;
  var token=await preferences.getString("token");
  print("token is $token");
  val=(token==null)?(true):(await JwtDecoder.isExpired(token));


  print(val);
  if(val==true || val==null)
    {
      runApp(FrontPage());
    }
  else
    {
      runApp(Homepage());
    }

}


//
//
// class Null extends StatefulWidget {
//   const Null({super.key});
//
//   @override
//   State<Null> createState() => _NullState();
// }
//
// class _NullState extends State<Null> {
//  final formkey=GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return  MaterialApp(
//       home: Scaffold(
//         body: Form(
//           key: formkey,
//           child: Column(
//             children: [
//               TextFormField(
//                 decoration: InputDecoration(),
//                 validator: (value){
//                   if(value!.isEmpty)
//                     {
//                       return "NULL";
//                     }
//
//                 },
//               ),
//               ElevatedButton(onPressed: (){
//
//                 if(formkey.currentState!.validate())
//                   {
//
//                   }
//               }, child:Text("h") )
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Front(),
    );
  }
}



class Front extends StatefulWidget {
  const Front({super.key});

  @override
  State<Front> createState() => _FrontState();
}

class _FrontState extends State<Front> {


  @override
  Widget build(BuildContext context) {

    Size size=MediaQuery.of(context).size;
    var width=size.width;
    var height=size.height;




    return Scaffold(

      extendBodyBehindAppBar: true,


      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(
              "assets/backgroundapp.png",

            ),fit: BoxFit.cover)
        ),
        child:Column(

          children: [

            Flexible(
              flex: 8,
              child: Center(
                child:  Container(
                    margin: EdgeInsets.only(
                        top: height/3
                    ),


                    child:Column(
                      children: [
                        Text("Welcome Back !",style: GoogleFonts.aBeeZee(
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                        ),),


                        SizedBox(height: 20,),

                        Flexible(
                            child:   Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text:"One stop solution to all your law related Queries",
                                    style: GoogleFonts.aBeeZee(fontSize: 20,color: Colors.white),

                                  )


                              ),
                            ))
                      ],
                    )





                ),
              ),
            ),


            Flexible(

                flex: 1,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Row(

                    children: [
                      Flexible(

                        flex: 1,
                        child:
                        GestureDetector(
                          onTap: (){
                            print("Sign In is Clicked");
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                          },
                          child: Container(
                            width: width/2,

                            padding: EdgeInsets.all(30),
                            child: Text("Sign In",style: GoogleFonts.aBeeZee(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,color: Colors.white
                            ),textAlign: TextAlign.center,


                            ),
                          ),
                        ),),

                      Flexible(
                          flex: 1,
                          child: GestureDetector(
                            onTap: (){
                              print("clicked");
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
                              },
                            child: Container(
                              margin: EdgeInsets.only(top: 15),
                              padding: EdgeInsets.only(top: 20),
                              width: width/2,
                              height: double.maxFinite,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(60)
                                  )
                              ),
                              child: Text(
                                "Sign Up",textAlign: TextAlign.center,style: GoogleFonts.aBeeZee(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),),






                            ),
                          )
                      )





                    ],
                  ),

                ))







            // for making last button




          ],
        ),
      ),

    );
  }
}




//
// class CustomScaffold extends StatelessWidget {
//   const CustomScaffold({super.key, this.child});
//   final Widget? child;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.white),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       extendBodyBehindAppBar: true,
//       body: Stack(
//         children: [
//           Image.asset(
//             'assets/backgroundapp.png',
//             fit: BoxFit.cover,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           SafeArea(
//             child: child!,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
// class WelcomeScreen extends StatelessWidget {
//   const WelcomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomScaffold(
//       child: Column(
//         children: [
//           Flexible(
//               flex: 8,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 0,
//                   horizontal: 40.0,
//                 ),
//                 child: Center(
//                   child: RichText(
//                     textAlign: TextAlign.center,
//                     text: const TextSpan(
//                       children: [
//                         TextSpan(
//                             text: 'Welcome Back!\n',
//                             style: TextStyle(
//                               fontSize: 45.0,
//                               fontWeight: FontWeight.w600,
//                             )),
//                         TextSpan(
//                             text:
//                             '\nEnter personal details to your employee account',
//                             style: TextStyle(
//                               fontSize: 20,
//                               // height: 0,
//                             ))
//                       ],
//                     ),
//                   ),
//                 ),
//               )),
//           Flexible(
//             flex: 1,
//             child: Align(
//               alignment: Alignment.bottomRight,
//               child: Row(
//                 children: [
//                    Expanded(
//                     child: WelcomeButton(
//                       buttonText: 'Sign in',
//                       onTap:const LoginPage(),
//                       color: Colors.transparent,
//                       textColor: Colors.white,
//                     ),
//                   ),
//                   Expanded(
//                     child: WelcomeButton(
//                       buttonText: 'Sign up',
//                       onTap: const RegisterPage(),
//                       color: Colors.white,
//                       textColor: lightColorScheme.primary,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
// class WelcomeButton extends StatelessWidget {
//   const WelcomeButton(
//       {super.key, this.buttonText, this.onTap, this.color, this.textColor});
//   final String? buttonText;
//   final Widget? onTap;
//   final Color? color;
//   final Color? textColor;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (e) => onTap!,
//           ),
//         );
//       },
//       child: Container(
//         padding: const EdgeInsets.all(30.0),
//         decoration: BoxDecoration(
//           color: color!,
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(50),
//           ),
//         ),
//         child: Text(
//           buttonText!,
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 20.0,
//             fontWeight: FontWeight.bold,
//             color: textColor!,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
// const lightColorScheme = ColorScheme(
//   brightness: Brightness.light,
//   primary: Color(0xFF416FDF),
//   onPrimary: Color(0xFFFFFFFF),
//   secondary: Color(0xFF6EAEE7),
//   onSecondary: Color(0xFFFFFFFF),
//   error: Color(0xFFBA1A1A),
//   onError: Color(0xFFFFFFFF),
//   background: Color(0xFFFCFDF6),
//   onBackground: Color(0xFF1A1C18),
//   shadow: Color(0xFF000000),
//   outlineVariant: Color(0xFFC2C8BC),
//   surface: Color(0xFFF9FAF3),
//   onSurface: Color(0xFF1A1C18),
// );
//
// const darkColorScheme = ColorScheme(
//   brightness: Brightness.dark,
//   primary: Color(0xFF416FDF),
//   onPrimary: Color(0xFFFFFFFF),
//   secondary: Color(0xFF6EAEE7),
//   onSecondary: Color(0xFFFFFFFF),
//   error: Color(0xFFBA1A1A),
//   onError: Color(0xFFFFFFFF),
//   background: Color(0xFFFCFDF6),
//   onBackground: Color(0xFF1A1C18),
//   shadow: Color(0xFF000000),
//   outlineVariant: Color(0xFFC2C8BC),
//   surface: Color(0xFFF9FAF3),
//   onSurface: Color(0xFF1A1C18),
// );
//
// ThemeData lightMode = ThemeData(
//   useMaterial3: true,
//   brightness: Brightness.light,
//   colorScheme: lightColorScheme,
//   elevatedButtonTheme: ElevatedButtonThemeData(
//     style: ButtonStyle(
//       backgroundColor: MaterialStateProperty.all<Color>(
//         lightColorScheme.primary, // Slightly darker shade for the button
//       ),
//       foregroundColor:
//       MaterialStateProperty.all<Color>(Colors.white), // text color
//       elevation: MaterialStateProperty.all<double>(5.0), // shadow
//       padding: MaterialStateProperty.all<EdgeInsets>(
//           const EdgeInsets.symmetric(horizontal: 20, vertical: 18)),
//       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//         RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16), // Adjust as needed
//         ),
//       ),
//     ),
//   ),
// );
//
// ThemeData darkMode = ThemeData(
//   useMaterial3: true,
//   brightness: Brightness.dark,
//   colorScheme: darkColorScheme,
// );