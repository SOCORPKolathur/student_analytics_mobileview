import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'Noticies_Page.dart';
import 'Payment_Page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  void initState() {

    getstudentdetails();
    // TODO: implement initState
    super.initState();
  }


  String Studentdocumentid='';
  String Studentname='';
  String Studentregno='';
  String Studentprofile='';
  String Studentphoneno='';

  getstudentdetails() async {
    print(FirebaseAuth.instance.currentUser!.uid);
    print("11111111111111111111");
    ///u38S3dJ5upOD3TZDFUkG6Ed0SYD3
    var document = await FirebaseFirestore.instance.collection("Student").get();
    print(document.docs.length);
    for(int i=0;i<document.docs.length;i++){
      print(document.docs[i]["userid"]);
      if(document.docs[i]["userid"]==FirebaseAuth.instance.currentUser!.uid){
        print("222222222222222222");
        setState(() {
          Studentdocumentid=document.docs[i].id;
        });
        print("33333333333333333");
        print(Studentdocumentid);
        print("4444444444444444444444");
      }

    };
    print("55555555555555");
    var document2= await FirebaseFirestore.instance.collection("Student").doc(Studentdocumentid).get();
    Map<String,dynamic>?value=document2.data();
    print("66666666666666666");
    setState(() {
      Studentname=value!['Student Name'];
      Studentregno=value['Student_id'];
      Studentprofile=value['Picture'];
      Studentphoneno=value['Phone Number'];
    });
    print("777777777777777");
    print(Studentname);
    print(Studentregno);
    print(Studentprofile);
    print(Studentphoneno);
    print("8888888888888888888");
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff263646),
        toolbarHeight: 80,
        leading:Padding(
          padding:  EdgeInsets.only(left: 8),
          child: Image.network("https://firebasestorage.googleapis.com/v0/b/students-d2abf.appspot.com/o/dailyupdates%2Fside.png?alt=media&token=61522c3e-3bab-4718-b943-3dc7648fc35c"),
        ),

        title:  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Home Page",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: width/16
              ),),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.more_vert_sharp,color: Colors.white,),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset("assets/white-trianglify-b79c7e1f.jpg",height: height/1,width: width/1,fit: BoxFit.cover,),
          Padding(
            padding:  EdgeInsets.only(left:18,right: 18),
            child: Column(
              children: [
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height:85,
                      width: 85,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          image:Studentprofile==""?
                          DecorationImage(
                              image: AssetImage("assets/avator.png")
                          ): DecorationImage(
                              image: NetworkImage(Studentprofile)
                          ),
                          borderRadius: BorderRadius.circular(100)
                      ),
                    ),
                    SizedBox(width: 15,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 220,
                          child: Text("Hello ${Studentname}",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: width/16,
                              textStyle: TextStyle(
                                overflow: TextOverflow.ellipsis
                              )

                            ),),
                        ),
                        SizedBox(height: 5,),
                        Text("Reg No: ${Studentregno}",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: width/28
                          ),),
                      ],
                    ),

                  ],
                ),
                SizedBox(height: 80,),

                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage(Studentdocumentid),));
                  },
                  child: Material(
                    elevation: 30,
                    color: Colors.indigo,
                    shadowColor: Colors.black12,
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: 320,
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(15),

                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Pay Fees",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: width/16
                            ),),
                          SizedBox(width: 30,),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Image.asset("assets/money.png",height: 50,width: 50,),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),

                GestureDetector(

                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationsView(Studentphoneno),));
                  },
                  child: Material(
                    elevation: 30,
                    color: Colors.indigo,
                    shadowColor: Colors.black12,
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: 320,
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(15),

                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("View Notices",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: width/16
                            ),),
                          SizedBox(width: 10,),
                          Image.asset("assets/post-it.png",height: 50,width: 50,)
                        ],
                      ),
                    ),
                  ),
                ),



              ],
            ),
          ),
        ],
      ),

    );
  }


  
}
