import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:myapp/login.dart';
import 'result.dart';

// import 'package:validators/validators.dart' as validator;
import 'model.dart';
// import 'result.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Register User'),
        ),
        body: TestForm(),
      ),
    );
  }
}

class TestForm extends StatefulWidget {
  Model model;

  @override
  _TestFormState createState() => _TestFormState();
}

class _TestFormState extends State<TestForm> {
  final _formKey = GlobalKey<FormState>();
  Model model = Model();

  String firstName;
  String lastName;
  String password;
  String email;
  String password_confirmation;

  Future<bool> saveBasicInformation(
      String firstName, String lastName, String email, String password ,String password_confirmation) async {
    final body = {
      "name": firstName + lastName,
      "email": email,
      "password": password,
      "password_confirmation" :password_confirmation
    };

    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    };

    final response = await http.post(
        'http://api.bodyprocoach.com/api/v1/register',
        body: body,
        headers: headers);

    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  void submit() async {
    // First validate form.
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();
      bool result = await saveBasicInformation(
          this.firstName, this.lastName, this.email, this.password,this.password_confirmation);
      if (result) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  width: halfMediaWidth,
                  child: MyTextFormField(
                    hintText: 'First Name',
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Enter your first name';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      firstName = value;
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  width: halfMediaWidth,
                  child: MyTextFormField(
                    hintText: 'Last Name',
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Enter your last name';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      lastName = value;
                    
                    },
                  ),
                )
              ],
            ),
          ),
          MyTextFormField(
            hintText: 'Email',
            isEmail: true,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Enter your Email';
              }
              return null;
            },
            onSaved: (String value) {
              email = value;
            },
          ),
          MyTextFormField(
            hintText: 'Password',
            isPassword: true,
            validator: (String value) {
              if (value.length < 7) {
                return 'Password should be minimum 7 characters';
              }
              _formKey.currentState.save();
              return null;
            },
            onSaved: (String value) {
              password = value;
            },
          ),
          MyTextFormField(
            hintText: 'Confirm Password',
            isPassword: true,
            validator: (String value) {
              if (value.length < 7) {
                return 'Password should be minimum 7 characters';
              } else if (model.password != null && value != model.password) {
                print(value);
                print(password);
                return 'Password not matched';
              }
              return null;
            },
            onSaved: (String value) {
              password_confirmation = value;
            },
          ),
          RaisedButton(
            color: Colors.blueAccent,
            // onPressed: () {
            //   if (_formKey.currentState.validate()) {
            //     _formKey.currentState.save();
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => Result(model: this.model)));
            //   }
            // },
            onPressed: () => {submit()},
            child: Text(
              'Submit',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isPassword;
  final bool isEmail;
  MyTextFormField({
    this.hintText,
    this.validator,
    this.onSaved,
    this.isPassword = false,
    this.isEmail = false,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.all(15.0),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[200],
        ),
        obscureText: isPassword ? true : false,
        validator: validator,
        onSaved: onSaved,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}
