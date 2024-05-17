import 'package:flutter/material.dart';
import 'package:projectfinal/Theme/colors.dart';
import 'package:projectfinal/pages/homepage%20work/fomulaire_service.dart';
import 'package:projectfinal/pages/homepage%20work/mytext_field.dart';
import 'package:projectfinal/pages/homepage%20work/annonce_model.dart';
import 'package:projectfinal/pages/homepage%20work/details_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectfinal/pages/homepage%20work/home_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:projectfinal/profile%20work/donator_service.dart';
import 'package:projectfinal/profile%20work/profile_page.dart';

class FormotherPage extends StatefulWidget {
  final Announcement annonce;
  const FormotherPage({super.key, required this.annonce});

  @override
  State<FormotherPage> createState() => _FormotherPageState();
}

class _FormotherPageState extends State<FormotherPage> {

  late Formulaireservice formulaireservice;

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    formulaireservice =
        Formulaireservice(widget.annonce.orgId, widget.annonce.annonceId);
  }

  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonenumbercontroller = TextEditingController();
  TextEditingController adresscontroller = TextEditingController();
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

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
            fontFamily: 'Nunito',
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(
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
      body: Padding(
        padding: const EdgeInsets.only(
          top: 40,
        ),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(60),
              topRight: Radius.circular(60),
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withOpacity(0.2),
                spreadRadius: 0, // spread radius
                blurRadius: 30,
              )
            ],
          ),
          child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 40),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                        
                            children: [
                              Container(
                                  height: 60,
                                  width: 60,
                                  decoration:
                                      const BoxDecoration(shape: BoxShape.circle),
                                  child: Image.network(
                                      widget.annonce.organizationLogoUrl,
                                      height: 70,
                                      width: 70,fit: BoxFit.cover,)),
                                      SizedBox(width: 5,),
                             
                                 Text(
                                  widget.annonce.organizationName,
                                  style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.icons),
                                ),
                              
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Text(
                            widget.annonce.annonceTitle,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: AppColors.icons),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Column(
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
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Quantity',
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 14,
                                    color: AppColors.icons),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.clear,
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed:
                                        _counter > 0 ? _decrementCounter : null,
                                    icon: const Icon(
                                      Icons.remove,
                                      color: AppColors.icons,
                                      size: 15,
                                    ),
                                    padding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                '$_counter',
                                style: const TextStyle(
                                    fontSize: 14.0, color: AppColors.details),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.clear,
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: _incrementCounter,
                                    icon: const Icon(
                                      Icons.add,
                                      color: AppColors.icons,
                                      size: 15,
                                    ),
                                    padding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Persons',
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 14,
                                    color: AppColors.icons),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 45,
                          ),
                          GestureDetector(
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Center(
                                    child:
                                        LoadingAnimationWidget.prograssiveDots(
                                            color: AppColors.icons, size: 100),
                                  );
                                },
                              );
FirestoreService fs = FirestoreService();
  String? userId = await fs.getCurrentUserId();
                              await formulaireservice.addDonnation(
                                  namecontroller.text,
                                  phonenumbercontroller.text,
                                  adresscontroller.text,
                                  _counter.toString(),
                                  widget.annonce.orgId,
                                 userId!,
                                  );
                              phonenumbercontroller.clear();
                              adresscontroller.clear();
                              namecontroller.clear();
                             
                              // ignore: use_build_context_synchronously
                              Navigator.of(context, rootNavigator: true).pop();

                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const HomePage()),
                              );

                              setState(() {
                                _counter = 0;
                              });
                            },
                            child: Container(
                              width: 140,
                              decoration: BoxDecoration(
                                  color: AppColors.icons,
                                  borderRadius: BorderRadius.circular(40)),
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 3, bottom: 3),
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
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
