import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/models/drink.dart';
import 'package:firebase_test/models/user.dart';

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

  // userData from Snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        sugars: snapshot.data['sugar'],
        amount: snapshot.data['amount']);
  }

  // get stream for firestore
  Stream<List<Drinks>> get theDrink {
    return drink.snapshots().map(_drinkListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return drink.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
