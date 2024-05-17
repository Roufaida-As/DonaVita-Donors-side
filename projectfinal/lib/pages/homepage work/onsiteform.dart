import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectfinal/Theme/colors.dart';
import 'package:projectfinal/pages/homepage%20work/fomulaire_service.dart';
import 'package:projectfinal/pages/homepage%20work/mytext_field.dart';
import 'package:projectfinal/pages/homepage%20work/annonce_model.dart';
import 'package:projectfinal/pages/homepage%20work/home_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:projectfinal/profile%20work/donator_service.dart';

// ignore: camel_case_types
class onsiteform extends StatefulWidget {
  final Announcement annonce;
  const onsiteform({super.key, required this.annonce});

  @override
  State<onsiteform> createState() => _onsiteformState();
}

// ignore: camel_case_types
class _onsiteformState extends State<onsiteform> {
  late Formulaireservice formulaireservice;
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirestoreService fs = FirestoreService();
  @override
  void initState() {
    super.initState();
    formulaireservice = Formulaireservice(
      widget.annonce.orgId,
      widget.annonce.annonceId,
    );
  }

  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonenumbercontroller = TextEditingController();
  TextEditingController adresscontroller = TextEditingController();
  TextEditingController quantitycontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Mytextfield(
            abovestring: 'Full name',
            controller: namecontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          Mytextfield(
            abovestring: 'Phone number',
            controller: phonenumbercontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          Mytextfield(
            abovestring: 'Adress',
            controller: adresscontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 80,
            child: TextField(
              controller: quantitycontroller,
              decoration: const InputDecoration(
                  suffixText: 'DA',
                  suffixStyle: TextStyle(
                    color: AppColors.icons,
                    fontFamily: 'Roboto',
                    fontSize: 14,
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)),
                  labelText: 'Quantity',
                  labelStyle: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      color: AppColors.icons)),
            ),
          ),
          const SizedBox(
            height: 45,
          ),
          Center(
            child: GestureDetector(
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Center(
                      child: LoadingAnimationWidget.prograssiveDots(
                          color: AppColors.icons, size: 100),
                    );
                  },
                );

                await formulaireservice.addDonnation(
                    namecontroller.text,
                    phonenumbercontroller.text,
                    adresscontroller.text,
                    quantitycontroller.text,
                     widget.annonce.orgId,
                                  await fs.getCurrentUserId().toString(),);
                phonenumbercontroller.clear();
                adresscontroller.clear();
                namecontroller.clear();
            
                // ignore: use_build_context_synchronously
                Navigator.of(context, rootNavigator: true).pop();

                // ignore: use_build_context_synchronously
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (BuildContext context) => const HomePage()),
                );
              },
              child: Container(
                width: 140,
                decoration: BoxDecoration(
                    color: AppColors.icons,
                    borderRadius: BorderRadius.circular(40)),
                child: const Padding(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
                  child: Center(
                      child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
