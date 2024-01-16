
import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:better_open_file/better_open_file.dart';
import 'package:chat_bubbles/bubbles/bubble_special_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_document/my_files/init.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:share_plus/share_plus.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

import 'package:uuid/uuid.dart';

import 'login.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key});




  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {



  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home:Home() ,
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  int _currentCharIndex = 0;
  bool change=false;
  bool colorChange=false;
  int selected_index=0;
  var sharedData="H";
  bool isEnable=true;
  List messages=[];
   ScrollController _scrollController=ScrollController();

  TextEditingController h=TextEditingController();

  late ProgressDialog progressDialog;





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){

    });
  }

  var strdata="";
  void _typeWrittingAnimation(_strings){
    if(_currentCharIndex < _strings.length){
      _currentCharIndex++;
    }else{
      // _currentIndex = (_currentIndex+1)% _strings.length;
      _currentCharIndex = 0;
    }
    setState(() {
    });

    Future.delayed(const Duration(milliseconds: 50),(){
      _typeWrittingAnimation(_strings);
    });
  }


  TextEditingController message=TextEditingController();
  @override
  Widget build(BuildContext context)
  {
    Size size=MediaQuery.of(context).size;
    var width=size.width;
    var height=size.height;


    return Scaffold(

      appBar: AppBar(
      actions: [
        (change==true)?
        Row(
          children: [



            IconButton(onPressed: (){
print("Shared Button Clicked");
                     Share.share("${sharedData}-\n BY LEXSOLVE");
              print("shared data is $sharedData");

            }, icon: Icon(FontAwesomeIcons.share)),
            IconButton(onPressed: (){
              generatePdf();

              print("PDF IS CLICKED");


            }, icon: Icon(FontAwesomeIcons.filePdf))
          ],
        ):(SizedBox())
      ],
        title: Text("LEXSOLVE",style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blueAccent,
      ),

        drawer: Drawer(

          child: Container(
            color: Colors.white70,
            child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                DrawerHeader(child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("assets/law.png",width: 50,),
                  Text("LEXSOLVE",style: GoogleFonts.aBeeZee(fontSize: 30,fontWeight: FontWeight.bold),),





                ],
              ),),

                SizedBox(height: 40,),
                Divider(),
                GestureDetector(
                  onTap: (){
                    print("history");
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(

                      children: [
                    SizedBox(width: 30,),

                        Icon(FontAwesomeIcons.history)
                      ,SizedBox(width: 20,)
                        ,Text("HISTORY",style: GoogleFonts.aBeeZee(fontSize: 20),)
                      ],
                    ),
                  ),
                ),
                Divider()
,GestureDetector(
                  onTap: (){
                    print("Your Profile");
                  },
  child:   Container(

                    padding: EdgeInsets.all(10),

                    child: Row(



                      children: [

                        SizedBox(width: 30,),

                        Icon(FontAwesomeIcons.user)

                        ,SizedBox(width: 20,)

                        ,Text("YOUR PROFILE",style: GoogleFonts.aBeeZee(fontSize: 20),)

                      ],

                    ),

                  ),
),
                Divider(),
                GestureDetector(
                  onTap: (){
                    print("ABOUT US");
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(

                      children: [
                        SizedBox(width: 30,),
                        Icon(FontAwesomeIcons.info)
                        ,SizedBox(width: 20,)
                        ,Text("ABOUT US",style: GoogleFonts.aBeeZee(fontSize: 20),)
                      ],
                    ),
                  ),
                ),
                Divider()
                ,  GestureDetector(
                  onTap: (){
                    print("LOGOUT");
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(

                      children: [
                        SizedBox(width: 30,),
                        Icon(Icons.exit_to_app )
                        ,SizedBox(width: 20,)
                        ,Text("LOGOUT",style: GoogleFonts.aBeeZee(fontSize: 20),)
                      ],
                    ),
                  ),
                ),
                Divider()



              ],
            ),
          ),
        ),
        body: Column(
          children:
          [
            Expanded(
                flex: 12,

                child: ListView.builder(
                  controller: _scrollController,


                  itemBuilder: (context,index){
              if(messages.length==0)
                {
                  return CircularProgressIndicator();
                }



              else
                {






                  return


                    (messages[index]["type"]=="human")?
                  //human
                  Container(
                    alignment: Alignment.bottomRight,
                 constraints: BoxConstraints(
                   maxWidth: width-60
                 ),
                  margin: EdgeInsets.only(left: 50,bottom: 20),
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(messages[index]["message"],style: GoogleFonts.aBeeZee(
fontSize: 20
                        ),),
                      ),
                    ),
                  ):


                  GestureDetector(
                onDoubleTap: (){
                  print("TAP ENABLED");

                  setState(() {
                    selected_index=0;
                    change=false;
                    colorChange=false;
                  });
                  print("app bar ${change}is card ${colorChange}");
                },
                    onLongPress: (){
                  print("LONG PRESS ENABLED");


                  setState(() {
                    print("bool function called");

                    sharedData=messages[index]["message"].toString().replaceAll("\\n", "\n");


                    print("shsared dat is $sharedData");
                    change=true;
                sharedData;
                selected_index=index;

                    colorChange=true;
                  });
                  print(change);
                  print(selected_index);
                    },

                    child: (Container(

                      alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.only(right: 50,bottom: 20),
                      child: Card(

                        color:(colorChange==true
              && index==selected_index
                        )?Colors.lightBlueAccent:Colors.white,
                        child:






                        Container(
                          padding: EdgeInsets.all(10),
                          child:
                          (messages[index]["message"].toString().isEmpty)? AnimatedTextKit(

                            repeatForever: true,


                            animatedTexts: [
                              TyperAnimatedText(


                                 "PLEASE WAIT ....",textStyle: GoogleFonts.aBeeZee(
fontSize: 20
                              )
                              )

                            ],

                          ):(Text(messages[index]["message"].toString().replaceAll("\\n", "\n"),style: GoogleFonts.aBeeZee(fontSize: 20),))
                        ),
                      ),
                    )),
                  );


                }


            },itemCount: messages.length,)),


            Expanded(
              flex: 2,

              child: Align(

              alignment: Alignment.bottomCenter,
              child: TextField(
                cursorColor: Colors.red,
                style: GoogleFonts.aBeeZee(

                  color: Colors.orange
                ),
                controller: message,

                decoration: InputDecoration(border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)


                )
                 ,suffixIcon:
                  Container(
                    width: 100,
                    child: Row(

                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      IconButton(onPressed: (){

                        print("MICRO PHONE IS CLICKED");
                      },
                          icon: Icon(FontAwesomeIcons.microphone)),




                      IconButton(onPressed:
                      (isEnable==true)?

                          () async
                        {



                           // progressDialog.show();
                         //
                         setState(() {
                           isEnable=false;
                           messages.add({
                             "message":message.text,
                             "type":"human"
                           });
                           messages.add({
                             "message":"",
                             "type":"bot"
                           });
                           _currentIndex++;



                         });


                          upload(message.text);

                          message.clear();



                                      //TODO: upload
                        }:null, icon:(isEnable==true)? Icon(FontAwesomeIcons.upload):(Icon(FontAwesomeIcons.warning)))

                    ],
                ),
                  )

                ),

              ),

              ),
            )
          ],
        ),
    );
  }

  generatePdf() async
  {
      final pdf=pw.Document();
      pdf.addPage(

        pw.Page(
        pageFormat: PdfPageFormat.a4,
          build: (pw.Context context){
            return

              pw.Column(
              children: [
                pw.Header(
                  text: "LEXSOLVE",

                ),
               pw.SizedBox(height: 20),
                pw.Center(
                  child: pw.Container(
                    margin: pw.EdgeInsets.all(20),
                    child: pw.Expanded(
                      child: pw.Text(sharedData.toString())
                    )
                  )
                )
              ]

              );
          }
        )



      );
      //
      // final bytes=await pdf.save();
      // var filename=Uuid().v1().toString()+".pdf";
      // print("filename is $filename");
      Directory tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path;

      var bytes=await pdf.save();
      final file = File("${tempPath}.pdf");
      await file.writeAsBytes(bytes);
      print(bytes);
      await Printing.sharePdf(bytes: bytes);







  }

   upload(message) async
  {
try{



String stored;
  print("UPLOAD FUNCTION CALLED");
  SharedPreferences preferences=await SharedPreferences.getInstance();
  var id=await preferences.getString("id");
  var date=await preferences.getString("date");
  Uri uri=Uri.parse("http://192.168.1.8:3030/chat/connect");
  print("id is ${id} date is ${date}");




  var change_res=await http.post(Uri.parse("https://stileschat-ai.p.rapidapi.com/api"),headers:  {
    'Content-Type':'application/json',
    'X-RapidAPI-Key': 'f57d0797demsh1cd143822f6247fp185348jsnd47f87ec4638',
    'X-RapidAPI-Host': 'stileschat-ai.p.rapidapi.com'
  }

,body: jsonEncode(

          {

        "promptInput":message+"In India",
        "context":false

      }
      )


  );

  stored=change_res.body.trim();

  print("stored is ${stored} answer ${stored=="null" }");
  if(stored=="null")
    {
      print("stored is value of null");
      var re=await http.post(Uri.parse("https://gpts4u.p.rapidapi.com/llama2"),headers:  {
        'content-type': 'application/json',
        'X-RapidAPI-Key': 'f57d0797demsh1cd143822f6247fp185348jsnd47f87ec4638',
        'X-RapidAPI-Host': 'gpts4u.p.rapidapi.com'
      }

          ,body: jsonEncode([{
            "role":"user",
            "content":message+"In India"
          }])

      );

      print(re.body);
      setState(() {
        stored=re.body;

      });
    }

  messages[_currentIndex]={
    "status":true,
    "type":"bot",
    "message":stored
  };


  //progressDialog.hide();



  var response=await http.post(uri,headers: {
    "Content-Type":"application/json"
  },body: jsonEncode({
    "id":id,
    "message":message

  })

  );





print(messages);



setState(() {
  isEnable=true;
  messages;
  _currentIndex++;

});
scrollDown();


}
catch(e)
    {

    }
  }

scrollDown()
{
  _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 500), curve: Curves.ease);
}






}



