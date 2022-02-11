import 'package:firebase_test/screens/authenticate/register.dart';
import 'package:firebase_test/services/auth.dart';
import 'package:firebase_test/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({
    Key? key,
  }) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingWidget()
        : Scaffold(
            backgroundColor: Colors.brown[30],
            appBar: AppBar(
              title: Text('Sign In Screen'),
              backgroundColor: Colors.grey[700],
              elevation: 0,
              actions: [
                TextButton.icon(
                  icon: Icon(Icons.person),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Register()));
                  },
                  label: Text('Register'),
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
                        decoration: InputDecoration(
                            hintText: 'Email',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1))),
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
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Password')),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              dynamic result = await _auth
                                  .signInEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  error =
                                      'Could not sign in with those credentials';
                                  isLoading = false;
                                });
                              }
                            }
                          },
                          child: Text('Sign In')),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      )
                    ],
                  ),
                )),
          );
  }
}
