import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import '../HomePage.dart';

class OTPScreen extends StatefulWidget {
  String phone;
  String Studnetdocid;
  OTPScreen({required this.phone, required this.Studnetdocid});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {

  OtpFieldController otpController = OtpFieldController();


  @override
  void initState() {
    // TODO: implement initState
    _verifyphone();

    super.initState();
  }
  var _verificationCode;

  _verifyphone()async{
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91${widget.phone}" ,
        verificationCompleted:(PhoneAuthCredential credential)async{
          await FirebaseAuth.instance.signInWithCredential(credential).then((value)async{
            if(value.user!=null){
             // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
            }
          });
        },
        verificationFailed:(FirebaseAuthException e){

        } ,
        codeSent:(String ?verificationid ,int ?resendtoken ){
          setState(() {
            _verificationCode=verificationid;
          });
        },
        codeAutoRetrievalTimeout:( String verificationid){
          setState(() {
            _verificationCode=verificationid;
          });
        },timeout: const Duration(seconds: 120) );

    //location  function
    //check();

  }


  String PinValue='';




  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:Colors.white,
      body: Container(
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
              Container(
                height: height/1.5,
                width: width/1.2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black,width: 0.2),
                    image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: AssetImage("assets/pngwing.com (2).png")
                    )
                    // color: Colors.white,
                    // gradient: const LinearGradient(
                    //   colors: [
                    //     Color(0xff5C258D),
                    //     Color(0xff4389A2),
                    //   ],
                    //   end: Alignment.bottomRight,
                    //   begin: Alignment.topLeft,
                    //
                    // )
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [

                    SizedBox(height: height/2.6,),
                    Padding(
                      padding:  EdgeInsets.only(left:width/170.75),
                      child: Text("Your Phone : +91 ${widget.phone}",style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: width/24
                      ),),
                    ),

                    Padding(
                      padding:  EdgeInsets.only(left:width/170.75),
                      child: Text("Enter the OTP",style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: width/24
                      ),),
                    ),
                    SizedBox(height: height/50.85,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: height/18.9,
                          width:width/ 1.32,
                          child:
                          OTPTextField(
                            controller: otpController,
                            length: 6,
                            width: MediaQuery.of(context).size.width,
                            textFieldAlignment: MainAxisAlignment.spaceAround,
                            fieldWidth: width/9.142,
                            fieldStyle: FieldStyle.box,
                            outlineBorderRadius: 15,
                            otpFieldStyle: OtpFieldStyle(
                              enabledBorderColor:  Colors.white,
                              borderColor:  Colors.white,
                              focusBorderColor:  Colors.white,
                              backgroundColor: Colors.white

                            ),

                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 17),
                            onChanged: (pin) {
                            },
                            onCompleted: (pin) {
                              setState(() {
                                PinValue=pin;
                              });
                              try{
                                FirebaseAuth.instance.signInWithCredential(
                                    PhoneAuthProvider.credential(
                                        verificationId:_verificationCode ,
                                        smsCode: pin)).then((value){
                                  if(value.user!=null){

                                  }
                                });
                              }
                              catch(e){


                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height/30.375,),
                    GestureDetector(
                      onTap: () async {
                        String? token = await FirebaseMessaging.instance.getToken();
                        try{
                          FirebaseAuth.instance.signInWithCredential(
                              PhoneAuthProvider.credential(
                                  verificationId:_verificationCode ,
                                  smsCode:PinValue)).then((value) async {
                            if(value.user!=null){
                              FirebaseFirestore.instance.collection("Student").doc(widget.Studnetdocid).update({
                                "userid":FirebaseAuth.instance.currentUser!.uid,
                                 "fcm_token":token,
                              });
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
                            }
                          });
                        }
                        catch(e){
                        }

                      },
                      child: Container(
                        height: height/18.9,
                        width: width/2.4,
                        decoration: BoxDecoration(
                            color: Color(0xff263646),
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child: Center(
                          child: Text("Verify",style:
                          GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              color: Colors.white
                          ),),
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}