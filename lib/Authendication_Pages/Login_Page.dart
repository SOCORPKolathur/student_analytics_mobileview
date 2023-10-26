

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'Otp_Page.dart';


class Login_Page extends StatefulWidget {
  const Login_Page({Key? key}) : super(key: key);

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {

  TextEditingController userid=TextEditingController();
  TextEditingController password=TextEditingController();

  @override
  Widget build(BuildContext context) {

    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

    return
      Scaffold(


      body:
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitHeight,
            image: AssetImage("assets/white-trianglify-b79c7e1f.jpg")
          )
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height/12.6,),
              Row(
                children: [
                  SizedBox(width: width/18,),
                  Image.asset("assets/side.png",height: height/15.12,width: width/7.2,),
                  SizedBox(width: width/72,),
                  Text("JAPAN SHOTOKAN KARATE DO \nFEDERATION INDIA",style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700
                      ,color: Colors.black,
                      fontSize: width/24
                  ),),
                ],
              ),
              SizedBox(height: height/37.8,),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Image.asset("assets/white-trianglify-b79c7e1f.jpg",height: height/1,width: width/1,fit: BoxFit.fitHeight,),
                  Container(
                    height: height/1.5,
                    width: width/1.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                     border: Border.all(color: Colors.black,width: 0.2),
                      color:  Color(0xff5C258D).withOpacity(0.2),
                     //  gradient: const LinearGradient(
                     //    colors: [
                     //      Color(0xff5C258D),
                     //      Color(0xff4389A2),
                     //    ],
                     //    end: Alignment.bottomRight,
                     //    begin: Alignment.topLeft,
                     //  )
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage("assets/pngwing.com (1).png")
                      )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [
                        SizedBox(height: height/75.6,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: height/38.0,
                                ),
                                Text("Welcome To JSKFI",style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w700
                                    ,color: Colors.white,
                                    fontSize: width/20
                                ),),
                                Text("(Log In Now)",style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: width/24
                                ),),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: height/3.6,),

                        Padding(
                          padding:  EdgeInsets.only(left:width/170.75),
                          child: Text("Enter Student Id:",style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: width/24
                          ),),
                        ),
                        SizedBox(height: height/75.6,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Material(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              child: SizedBox(
                                height: height/18.9,
                                width:width/ 1.44,
                                child: TextField(
                                  style: GoogleFonts.montserrat(color: Colors.black,fontSize: width/25,fontWeight:FontWeight.w700),
                                  controller: userid,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: width/18,),
                                    border: InputBorder.none,
                                    hintText: "Enter Your Student id",
                                    hintStyle: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: width/30
                                    )
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: height/75.375,),

                        Padding(
                          padding:  EdgeInsets.only(left:width/170.75),
                          child: Text("Enter Student Phone:",style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: width/24
                          ),),
                        ),
                        SizedBox(height: height/75.6,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Material(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                height: height/18.9,
                                width:width/ 1.44,
                                child: TextField(
                                  style: GoogleFonts.montserrat(color: Colors.black,fontSize: width/25,fontWeight:FontWeight.w700),
                                  controller: password,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: width/18,),
                                      border: InputBorder.none,
                                      hintText: "Enter Student phone",
                                      hintStyle: GoogleFonts.montserrat(
                                          color: Colors.black,
                                          fontSize:width/30
                                      )
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height/45.6,),




                        GestureDetector(
                          onTap: (){


                            usergetfunction();
                          },
                          child: Container(
                            height: height/18.9,
                            width: width/2.4,
                            decoration: BoxDecoration(
                                color: Color(0xff263646),
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Center(
                              child: Text("Submit",style:
                              GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white
                              ),),
                            ),
                          ),
                        ),
                        SizedBox(height: height/75.6,),

                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top:height/1.50,left: width/1.8),
                    child: Image.asset("assets/right_side_img.png",height: height/5.815,width: width/2.769,),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top:height/1.48,right: width/1.44),
                    child: Image.asset("assets/leftside_img.png",height: height/6.872,width: width/3.272,),
                  ),
                  // Padding(
                  //   padding:  EdgeInsets.only(top:height/1.0,right: width/1.9),
                  //   child: Image.asset("assets/pngwing.com.png",fit: BoxFit.cover,),
                  // ),


                ],
              ),
            ],
          ),
        ),
      ),
      
    );
  }




String name="";
String passwordd="";
String Studocid="";
bool loading=false;

  usergetfunction()async{
    print(userid.text);
    print(password.text);
    print(9688697940);
    print("JKSFI004");
    var userdetails= await FirebaseFirestore.instance.collection("Student").
    where("Student_id",isEqualTo:userid.text).where("Phone Number",isEqualTo:password.text).get();
    print(userdetails.docs.length);
    if(userdetails.docs.length>0){
      print("ggggggggggggggggggggggggggggggggggggggggggggg");
      print(userdetails.docs[0]["Phone Number"]);
      print("User id${userdetails.docs[0].id}");
    Navigator.push(context, MaterialPageRoute(builder: (context) =>OTPScreen(
        phone: userdetails.docs[0]["Phone Number"].toString(),Studnetdocid: userdetails.docs[0].id.toString())));
    }

    else {
      return  wrongpopupduialog();
    }

  }

  wrongpopupduialog(){

    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

    return  showDialog(context: context, builder: (context) {
      return
        Padding(
          padding: EdgeInsets.only(left: width/170.75,right: width/170.75),
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Container(
              height:height/3.1,
              width: width/5.2,

              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:  BorderRadius.circular(8)
              ),
              child: Column(
                children: [
                  SizedBox(height: height/41.062,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Please enter the correct \nStudent Id & Phone Number",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: width/30
                        ),),
                    ],
                  ),
                  SizedBox(height: height/24.75,),

                  Container(
                    height: height/8.475,
                    width: width/4.383,
                    child: Lottie.network("https://assets2.lottiefiles.com/packages/lf20_pqpmxbxp.json"),
                  ),
                  SizedBox(height: height/54.75,),

                  GestureDetector(

                    onTap: (){
                      Navigator.pop(context);


                    },
                    child: Container(
                      height: height/20.531,
                      width: width/3.60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color(0xff263646)
                      ),
                      child: Center(
                        child: Text("okay",style: GoogleFonts.montserrat(color:
                        Colors.white),),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
    },);
  }

}
