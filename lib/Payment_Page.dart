

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';

class PaymentPage extends StatefulWidget {
 String ?stid;
 PaymentPage(this.stid);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {


  bool check1=false;
  bool check2=false;

  @override
  Widget build(BuildContext context) {

    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff263646),
        toolbarHeight: 80,
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Dues",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: width/16
              ),),
          ],
        ),

      ),
      body: Stack(

        children: [
          Image.asset("assets/white-trianglify-b79c7e1f.jpg",height: height/1,width: width/1,fit: BoxFit.fitHeight,),
          Column(
            children: [
              SizedBox(
                height: height/26.425,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text("Your Dues",style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: width/20
                      ),),
                      Text("Select the month you want to pay",style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: width/30
                      ),),
                    ],
                  ),
                ],
              ),


              //streambuilder with grid view builder

              ListView(
                shrinkWrap: true,
                children: [
                 StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection("Student").doc(widget.stid).
                    collection("Fees").where("paid",isEqualTo: false).snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData==null){
                        return Center(child:
                        Lottie.network("https://assets1.lottiefiles.com/datafiles/vhvOcuUkH41HdrL/data.json"),);
                      }
                      if(!snapshot.hasData){
                        return Center(child: CircularProgressIndicator(),);
                      }
                      if(snapshot.data!.docs.length==0){
                        return Center(child:
                        Lottie.network("https://assets1.lottiefiles.com/datafiles/vhvOcuUkH41HdrL/data.json")
                          ,);
                      }
                      return

                        GridView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 180/110
                          ),
                          itemBuilder: (context, index) {
                            var uservalue=snapshot.data!.docs;
                            return

                              Padding(
                                padding:  EdgeInsets.symmetric(
                                  horizontal: width/45,
                                  vertical: height/94.5

                                ),
                                child: GestureDetector(
                                  onTap: (){
                                    paidsingleamount(
                                      uservalue[index].id,
                                      uservalue[index]['fees month'],
                                    );

                                  },
                                  child: Container(
                                    height: height/16.425,
                                    width: width/34.15,
                                    decoration: BoxDecoration(
                                      borderRadius:  BorderRadius.circular(8),
                                      color: Colors.red,
                                    ),
                                    child: Center(
                                      child: Text(uservalue[index]["fees month"],style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white
                                      ),),
                                    ),

                                  ),
                                ),
                              );
                          },);
                    },
                  ),




                  //all button

                  GestureDetector(
                    onTap: (){
                      paidallamount(widget.stid);
                    },
                    child: Padding(
                      padding:  EdgeInsets.only(left: width/170.75,right: width/170.75),
                      child: Container(
                        height: height/20.531,
                        width: width/14.229,
                        decoration: BoxDecoration(
                           color: Color(0xff263646),
                          borderRadius: BorderRadius.circular(100)
                        ),
                        child: Center(child: Text("Pay All",style: GoogleFonts.montserrat(
                          fontWeight:FontWeight.w500,
                          fontSize: width/25,
                          color: Colors.white
                        ),)),
                      ),
                    ),
                  )
                ],
              )

            ],
          ),
        ],
      ),
    );
  }

   int paidamount=0;
  int totalpay=0;

  String name1="";
  String name2="";
  updatefeesamount(paidid)async{
      FirebaseFirestore.instance.collection("Student").doc(widget.stid).
      collection("Fees").doc(paidid).update({
        "paid": true,
      });

      var valued= await FirebaseFirestore.instance.collection("Student").doc(widget.stid).
      collection("Fees").where("paid",isEqualTo: false).get();
       totalpay=valued.docs.length;
      print(totalpay);

        var val = await FirebaseFirestore.instance.collection("Student").doc(widget.stid).get();
        Map<String, dynamic>?value = val.data();
        setState(() {
          name1=value!['Student Name'];
          paidamount = (totalpay)*(int.parse(value["Fees Amount"]));});


      FirebaseFirestore.instance.collection("Accounts").doc(
          'baKyUImIDbz1wCZskug4').update({
        "Bank Balance": FieldValue.increment(paidamount)
      });
      addstudentinvertpayment();

  }

  //pay all amount
   int pendeingvalue=0;

  paidall()async{
    var paidallamount=await FirebaseFirestore.instance.collection("Student").doc(widget.stid).
    collection("Fees").where("paid",isEqualTo: false).get();
    setState(() {
      pendeingvalue=paidallamount.docs.length;
    });

    print(pendeingvalue);

    for(int i=0;i<paidallamount.docs.length;i++){
      FirebaseFirestore.instance.collection("Student").doc(widget.stid).
      collection("Fees").doc(paidallamount.docs[i].id).update({
        "paid":true,
      });
    }
    allamountpay();
    addstudentinvertpayment();

}


    int checkamount1=0;
    int checkamount2=0;
    //inside function..

    allamountpay()async {
      var paidallamounts2 = await FirebaseFirestore.instance.collection("Student").doc(widget.stid).get();
      Map<String,dynamic>?value=paidallamounts2.data();
      setState(() {
        name2=value!['Student Name'];
        checkamount1 = int.parse(value["Fees Amount"]);
        checkamount2 = (pendeingvalue)*(checkamount1);
      });
      print(checkamount2);

    FirebaseFirestore.instance.collection("Accounts").doc(
        'baKyUImIDbz1wCZskug4').update({
      "Bank Balance": FieldValue.increment(checkamount2)
    });

}


  addstudentinvertpayment(){
      print("Invert paymenty ccccccccv");
      FirebaseFirestore.instance.collection("Invert_payment").doc().set({
        "method":"bank",
        "User_Name":name1==""?name2:name1,
        "Timestamp":DateTime.now().millisecondsSinceEpoch,
        "Time":DateFormat("hh:mm:ss a").format(DateTime.now()),
        "Date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        "Amount":check2==true?checkamount2:check1==true?paidamount:"",
        "Remarked":"Fees"


      });
      
      
}



//alert dislogboxx(Single payment)

   paidsingleamount(paidid,month,){

      double height=MediaQuery.of(context).size.height;
      double width=MediaQuery.of(context).size.width;

      return showDialog(context: context, builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content:
          Container(
            height: height/2.346,
            width: width/4.268,
            decoration: BoxDecoration(
                color: Color(0xff263565),
                borderRadius: BorderRadius.circular(8)
            ),
            child: Column(
              children: [
                SizedBox(height: height/27.375),

                Text("Are You sure  to Pay",style: GoogleFonts.montserrat(
                  color: Colors.white
                ),),
                SizedBox(height: height/47.375,),

                Text(month,style: GoogleFonts.montserrat(color: Colors.white),),

                SizedBox(height: height/47.375,),


                Container(
                  height: height/8.475,
                  width: width/4.383,
                child:Lottie.network("https://assets1.lottiefiles.com/packages/lf20_rgdnbvya.json") ,
                ),
                SizedBox(height: height/41.062,),

                GestureDetector(
                  onTap: (){
                    setState(() {
                      check1=true;
                    });
                    updatefeesamount(paidid);
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: height/20.531,
                  width: width/3.60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color(0xff265656),
                  ),
                  child: Center(
                    child: Text("Okay",style: GoogleFonts.montserrat(color: Colors.white),),
                  ),
                  ),
                )




              ],
            ),
          ),

        );
      },);

}

  //alert dislogboxx(All payment)
  paidallamount(id){

      double height=MediaQuery.of(context).size.height;
      double width=MediaQuery.of(context).size.width;

    return showDialog(context: context, builder: (context) {

      return AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content:  Container(
          height: height/2.346,
          width: width/4.268,
          decoration: BoxDecoration(
              color: Color(0xff263565),
              borderRadius: BorderRadius.circular(8)
          ),
          child: Column(
            children: [
              SizedBox(height: height/27.375),

              Text("Are You sure want Pay All",style: GoogleFonts.montserrat(
                  color: Colors.white
              ),),
              SizedBox(height: height/27.375),

              SizedBox(height: height/47.375),


              Container(
                height: height/8.475,
                width: width/4.383,
                child:Lottie.network("https://assets1.lottiefiles.com/packages/lf20_rgdnbvya.json") ,
              ),
              SizedBox(height: height/41.062,),

              GestureDetector(
                onTap: (){
                  setState(() {
                    check2=true;
                  });
                 paidall();
                 Navigator.pop(context);
                },
                child: Container(
                  height: height/20.531,
                  width: width/3.60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color(0xff265656),
                  ),
                  child: Center(
                    child: Text("Okay",style: GoogleFonts.montserrat(color: Colors.white),),
                  ),
                ),
              )





            ],
          ),
        ),
      );
    },);

  }



  }




