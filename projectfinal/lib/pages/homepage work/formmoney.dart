import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projectfinal/Theme/Colors.dart';
import 'package:projectfinal/pages/homepage%20work/annonce_model.dart';
import 'package:projectfinal/pages/homepage%20work/details_page.dart';
import 'package:projectfinal/pages/homepage%20work/onsiteform.dart';
class FormmoneyPage extends StatefulWidget {
  final Announcement annonce;
  const FormmoneyPage({super.key, required this.annonce});

  @override
  State<FormmoneyPage> createState() => _FormmoneyPageState();
}

class _FormmoneyPageState extends State<FormmoneyPage> {
  bool onsitePressed=true;
  
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        backgroundColor: AppColors.clear,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Donation form",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 32,
              color: AppColors.highicons,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        DetailsPage(annonce: widget.annonce)),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Image.asset(
                'assets/Icons/eva_arrow-back-outline.png',
                width: 32,
                height: 32,
              ),
            ),
          ),
        ),

      
      body: Padding(padding: EdgeInsets.only(top: 40,),
      child:Container(
        height:double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: AppColors.background,borderRadius: BorderRadius.only(topLeft: Radius.circular(60),topRight:  Radius.circular(60),),
           boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF000000).withOpacity(0.2),
                                    spreadRadius: 0, // spread radius
                                    blurRadius: 30,
                                  )
                                ],),
                                 child: Padding(
                                  padding: EdgeInsets.only(top:40,left: 40),
child: SingleChildScrollView(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Row(children: [
          
           Container(height:60,width:60,decoration:BoxDecoration(shape: BoxShape.circle),child: Image.network(widget.annonce.organizationLogoUrl, height: 60, width: 60)),
          
           Padding(
             padding: const EdgeInsets.only(top: 40,left: 5),
             child: Text(widget.annonce.organizationName,style: TextStyle(fontFamily: 'Roboto',fontSize: 24,fontWeight: FontWeight.bold,color: AppColors.icons),),
           )
        ],),
        SizedBox(height: 15,),
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Text(widget.annonce.annonceTitle,textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Roboto',fontSize: 18,fontWeight: FontWeight.w500,color: AppColors.icons),),
        ),
        Padding(padding: EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          child: Center(
            child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
           
            children: [
                   
                  
                  Container(
                    width: 100,
                    decoration: BoxDecoration(  borderRadius: BorderRadius.circular(2),border: Border(bottom: BorderSide(color:onsitePressed? AppColors.highicons : Colors.transparent, width: 4,))) ,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            onsitePressed=true;  
                          });
                      
                        },
                        child: Text(
                          'Onsite',
                        style: TextStyle(fontFamily: 'Nunito',fontSize: 20,fontWeight: FontWeight.w600,color: AppColors.highicons),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 60,),
                   Container(
                    width: 100,
                    decoration: BoxDecoration(  borderRadius: BorderRadius.circular(2),border: Border(bottom: BorderSide(color: onsitePressed? Colors.transparent : AppColors.highicons, width: 4,))) ,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          
                          setState(() {
                            onsitePressed=false;  
                          });
                      
                        },
                        child: Text(
                          'Online',
                        style: TextStyle(fontFamily: 'Nunito',fontSize: 20,fontWeight: FontWeight.w600,color: AppColors.highicons),
                        ),
                      ),
                    ),
                  ),
                  
             
            ],
            ),
          ),
        ),
        ),
        onsiteform(annonce: widget.annonce),
        ]
        ,
      ),
        
 ]))))) );
  }
}