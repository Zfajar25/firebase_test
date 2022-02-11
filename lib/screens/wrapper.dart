import 'package:firebase_test/models/user.dart';
import 'package:firebase_test/screens/authenticate/authenticate.dart';
import 'package:firebase_test/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userWrapper = Provider.of<User?>(context);

    if (userWrapper == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
