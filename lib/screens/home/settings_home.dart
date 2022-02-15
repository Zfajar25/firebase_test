import 'package:firebase_test/models/user.dart';
import 'package:firebase_test/services/services.dart';
import 'package:firebase_test/shared/constant.dart';
import 'package:firebase_test/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4', '5'];

  String? _currentName;
  String? _currentSugars;
  dynamic _amount;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData?>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Update your Setting',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: TextFormField(
                        initialValue: userData!.name,
                        decoration: textInputDecoration,
                        validator: (value) =>
                            value!.isEmpty ? 'Please Enter a Name' : null,
                        onChanged: (value) => setState(() {
                          _currentName = value;
                        }),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField<String>(
                      decoration: dropDownDecoration,
                      value: _currentSugars ?? userData.sugars,
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                          value: sugar,
                          child: Text('$sugar sugars'),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() {
                        _currentSugars = value;
                      }),
                      onTap: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                      },
                    ),
                    Slider(
                      value: (_amount ?? userData.amount).toDouble(),
                      min: 100.0,
                      max: 900.0,
                      divisions: 8,
                      onChanged: (value) => setState(() {
                        _amount = value.round();
                      }),
                      activeColor: Colors.brown[_amount],
                      inactiveColor: Colors.brown[100],
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentSugars ?? userData.sugars,
                              _currentName ?? userData.name,
                              _amount ?? userData.amount);
                        }
                        Navigator.pop(context);
                      },
                      child: Text('Update'),
                      style: ElevatedButton.styleFrom(primary: Colors.brown),
                    )
                  ],
                ),
              ),
            );
          } else {
            return LoadingWidget();
          }
        });
  }
}
