import 'package:firebase_test/models/drink.dart';
import 'package:flutter/material.dart';

class DrinkTile extends StatelessWidget {
  DrinkTile({Key? key, this.drink}) : super(key: key);
  final Drinks? drink;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.brown[drink!.amount],
          ),
          title: Text(drink!.name),
          subtitle: Text('Takes ${drink!.sugar} sugar'),
        ),
      ),
    );
  }
}
