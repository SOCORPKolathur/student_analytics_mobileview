

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsView extends StatefulWidget {
String?studentphono;
NotificationsView(this.studentphono);

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {

  @override
  void initState() {

    print("phonr number------------------------${widget.studentphono}");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff263646),
        toolbarHeight: 80,
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Notification",
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
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('messages').snapshots(),
            builder: (ctx, snap) {

              if(snap.hasData==null){
                return Center(child: CircularProgressIndicator(),);
              }
              if(!snap.hasData){
                return Center(child: CircularProgressIndicator(),);
              }
              return
                ListView.builder(
                  reverse: false,
                  itemCount: snap.data!.docs.length,
                  itemBuilder: (ctx, i) {

                    if(snap.data!.docs[i]['to']==widget.studentphono){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:  Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount:snap.data!.docs[i]['content'].length ,
                              itemBuilder: (context, index) {
                                return Text(snap.data!.docs[i]['content']['text']);
                              },)

                        ),
                      );
                    }
                  return  SizedBox();
                  },
                );
            },
          ),
        ],
      ),
    );
  }



}