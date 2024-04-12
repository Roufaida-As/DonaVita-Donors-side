import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectfinal/Theme/Colors.dart';
import 'package:projectfinal/pages/homepage%20work/Mytextfield.dart';

import 'package:projectfinal/pages/homepage%20work/Fomulaire_service.dart';
import 'package:projectfinal/pages/homepage%20work/annonce_model.dart';
class onsiteform extends StatefulWidget {
final Announcement annonce;
 onsiteform({super.key, required this.annonce});

  @override
  State<onsiteform> createState() => _onsiteformState();
}

class _onsiteformState extends State<onsiteform> {
    late Formulaireservice formulaireservice;
   FirebaseFirestore db = FirebaseFirestore.instance;
     void initState() {
    super.initState();
    formulaireservice = Formulaireservice(widget.annonce.orgId, widget.annonce.annonceId);
  }


  
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonenumbercontroller = TextEditingController();
  TextEditingController adresscontroller = TextEditingController();
  TextEditingController quantitycontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
            children: [ 
               Mytextfield(abovestring: 'Full name',controller: namecontroller,),
                SizedBox(height: 20,),
                Mytextfield(abovestring: 'Phone number',controller: phonenumbercontroller,),
                    SizedBox(height: 20,),
                Mytextfield(abovestring: 'Adress',controller: adresscontroller,),
                SizedBox(height: 20,),
                Container(
       width:80,
                  child: TextField(
                  controller: quantitycontroller,
                              decoration: InputDecoration(
                  
                    suffixText: 'DA',
                    suffixStyle: TextStyle(color:AppColors.icons,fontFamily: 'Roboto',fontSize: 14,),
                 
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal)),
                        focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal)),
                   
                    labelText:	'Quantity',
                    labelStyle: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      color: AppColors.icons
                    )
                  ),
                        ),
                ),
            
              SizedBox(height: 45,),
              Center(
                child: GestureDetector(
                  onTap: () {
                    formulaireservice.addFormulaire(namecontroller.text,phonenumbercontroller.text,adresscontroller.text, quantitycontroller.text);
                    phonenumbercontroller.clear();
                    adresscontroller.clear();
                    namecontroller.clear();
                    quantitycontroller.clear();
                    int newquantity = int.parse(widget.annonce.quantityDonated) + int.parse(quantitycontroller.text);
                setState(() {
                  db.collection('Organisations')
                      .doc(widget.annonce.orgId)
                      .collection('annonces')
                      .doc(widget.annonce.annonceId)
                      .update({"quantityDonated": newquantity.toString()});
                });
                },
                    child: Container(
                      width: 140,
                      decoration: BoxDecoration(color: AppColors.icons,borderRadius: BorderRadius.circular(40)),
                      child: Padding(padding: EdgeInsets.only(left: 10,right: 10,top: 3,bottom: 3),
                      child: Center(child: Text('Submit',style: TextStyle(color: Colors.white,fontFamily: 'Roboto',fontSize: 18,fontWeight: FontWeight.w400),)),),
                                 ),
                  ),
              ),
               
            ],
          ),
    );
  }
}