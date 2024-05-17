// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';

class Formulaireservice {
  final String orgId;
  final String annId;
  

  Formulaireservice(this.orgId, this.annId, );

  CollectionReference get formulaireCollection {
    return FirebaseFirestore.instance
        .collection('organisationsAsUsers')
        .doc(orgId)
        .collection('annonces')
        .doc(annId)
        .collection('Donnations');
  }

  Future<void> addDonnation(
      String fullname, String phonenumber, String adress, String quantitydonated,String orgId,String userId) {
    return formulaireCollection.add({
      'fullname': fullname,
      'phonenumber': phonenumber,
      'adress': adress,
      'quantitydonated': quantitydonated,
      'orgId':orgId,
      'personId':userId,
      'seen':false,
    });
  }
 
}