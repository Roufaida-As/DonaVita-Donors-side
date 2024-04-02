import 'package:flutter/material.dart';
import 'package:projectfinal/Theme/Colors.dart';
import 'package:projectfinal/pages/homepage%20work/Mytextfield.dart';
import 'package:projectfinal/pages/homepage%20work/annonce_model.dart';
import 'package:projectfinal/pages/homepage%20work/details_page.dart';
class FormotherPage extends StatefulWidget {
  final Announcement annonce;
  const FormotherPage({super.key, required this.annonce});

  @override
  State<FormotherPage> createState() => _FormotherPageState();
}

class _FormotherPageState extends State<FormotherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              MaterialPageRoute(builder: (BuildContext context) =>  DetailsPage(annonce: widget.annonce)),
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
        )],
      ),
      SizedBox(height: 60,),
      Padding(
       padding: const EdgeInsets.only(right: 30),
        child: Column(
          children: [ 
             Mytextfield(abovestring: 'Full name'),
              SizedBox(height: 20,),
              Mytextfield(abovestring: 'Phone number'),
                  SizedBox(height: 20,),
              Mytextfield(abovestring: 'Adress'),
              SizedBox(height: 20,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                Text('Quantity',style: TextStyle(fontFamily: 'Roboto',fontSize: 14,color: AppColors.icons),),
                SizedBox(width: 10,),
                Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: AppColors.clear,),
                child: Center(child: IconButton(onPressed: () {}, 
                icon: Icon(Icons.remove,color: AppColors.icons,size: 15,),padding: EdgeInsets.zero,),),),
                 Text('Persons',style: TextStyle(fontFamily: 'Roboto',fontSize: 14,color: AppColors.icons),),
               ],
              )
            
          ],
        ),
      )
    ],
  ),
),
                                 ),
    
      ),
     
    )
    );
  }
}