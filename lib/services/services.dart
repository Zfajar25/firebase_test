import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/models/drink.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  final CollectionReference drink = Firestore.instance.collection('drink');

  Future updateUserData(String sugar, String name, int amount) async {
    return await drink.document(uid).setData({
      'sugar': sugar,
      'name': name,
      'amount': amount,
    });
  }

  // the list from snapshot
  List<Drinks> _drinkListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Drinks(
          amount: doc.data['amount'] ?? 0,
          name: doc.data['name'] ?? "",
          sugar: doc.data['sugar'] ?? "");
    }).toList();
  }

  // get stream for firestore
  Stream<List<Drinks>> get theDrink {
    return drink.snapshots().map(_drinkListFromSnapshot);
  }
}
