import 'package:firebase_test/services/auth.dart';
import 'package:firebase_test/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({
    Key? key,
  }) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String email = '';
  String password = '';
  String error = '';
  dynamic result;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingWidget()
        : Scaffold(
            backgroundColor: Colors.brown[30],
            appBar: AppBar(
              title: Text('Register Screen'),
              backgroundColor: Colors.grey[700],
              elevation: 0,
              actions: [
                TextButton.icon(
                  icon: Icon(Icons.person),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  label: Text('Sign In'),
                  style: TextButton.styleFrom(primary: Colors.white),
                )
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) =>
                            value!.isEmpty ? 'Enter an email' : null,
                        onChanged: (value) => setState(() {
                          email = value;
                        }),
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          validator: (value) => value!.length < 6
                              ? 'Enter a password more than 6 character'
                              : null,
                          obscureText: true,
                          onChanged: (value) => setState(() {
                                password = value;
                              }),
                          decoration:
                              InputDecoration(border: OutlineInputBorder())),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                                error =
                                    'Register complete, please press back button';
                              });
                              result = await _auth.registerEmailAndPassword(
                                  email, password);
                              if (result != null) {
                                setState(() {
                                  isLoading = false;
                                });
                              } else if (result == null) {
                                setState(() {
                                  error = 'Please use a valid email';
                                  isLoading = false;
                                });
                              }
                            }
                          },
                          child: Text('Register')),
                      SizedBox(
                        height: 10,
                      ),
                      result == null
                          ? Text(
                              error,
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            )
                          : Text(
                              error,
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 16),
                            )
                    ],
                  ),
                )),
          );
  }
}
