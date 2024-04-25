import 'package:cloud_firestore/cloud_firestore.dart';

class Formulaireservice {
  final String orgId;
  final String annId;
  

  Formulaireservice(this.orgId, this.annId, );

  CollectionReference get formulaireCollection {
    return FirebaseFirestore.instance
        .collection('Organisations')
        .doc(orgId)
        .collection('annonces')
        .doc(annId)
        .collection('Formulaire');
  }

  Future<void> addFormulaire(
      String fullname, String phonenumber, String adress, String quantitydonated,) {
    return formulaireCollection.add({
      'fullname': fullname,
      'phonenumber': phonenumber,
      'adress': adress,
      'quantitydonated': quantitydonated,
    });
  }
 
}