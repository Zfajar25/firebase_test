import 'package:firebase_test/models/drink.dart';
import 'package:firebase_test/screens/home/drink_list.dart';
import 'package:firebase_test/screens/home/settings_home.dart';
import 'package:firebase_test/services/auth.dart';
import 'package:firebase_test/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _showPanel() {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: SettingsForm(),
              color: Colors.grey,
            );
          });
    }

    return StreamProvider<List<Drinks>?>.value(
      value: DatabaseService().theDrink,
      initialData: List.empty(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
            elevation: 0,
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
              ElevatedButton.icon(
                  onPressed: () => _showPanel(),
                  icon: Icon(Icons.settings),
                  label: Text('Settings'),
                  style: ElevatedButton.styleFrom(primary: Colors.brown))
            ]),
        body: Container(
          child: DrinkList(),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/coffee_bg.png'),
                  fit: BoxFit.cover)),
        ),
        backgroundColor: Colors.brown[100],
      ),
    );
  }
}
