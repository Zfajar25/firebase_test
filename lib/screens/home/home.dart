import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/models/drink.dart';
import 'package:firebase_test/screens/home/drink_list.dart';
import 'package:firebase_test/services/auth.dart';
import 'package:firebase_test/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Drinks>?>.value(
      value: DatabaseService().theDrink,
      initialData: List.empty(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('The Crew'),
          backgroundColor: Colors.brown,
          actions: <Widget>[
            ElevatedButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text('Logout'),
              style: ElevatedButton.styleFrom(primary: Colors.brown),
            ),
          ],
        ),
        body: DrinkList(),
      ),
    );
  }
}
