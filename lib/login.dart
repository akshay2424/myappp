// import 'dart:js';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:myapp/result.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  // Model model;

  @override
  _LoginFormState createState() => _LoginFormState();
}
class _LoginFormState extends State<LoginForm> {


  // Model model;

  // @override
  // _LoginFormState createState() => _LoginFormState();
  final _formKey = GlobalKey<FormState>();

  String email;
  String password;

  // BuildContext get context => null;

  Future<bool> saveBasicInformation(String email, String password) async {
    final body = {
      "email": email,
      "password": password,
    };

    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    };

    final response = await http.post(
        'http://api.bodyprocoach.com/api/v1/login',
        body: body,
        headers: headers);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  void submit() async {
    // First validate form.
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();
      bool result = await saveBasicInformation(this.email, this.password);
      if (result) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Result()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
            isEmail: true,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Enter your Password';
              }
              return null;
            },
            onSaved: (String value) {
              password = value;
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
              'Login',
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

// class _LoginFormState extends State<LoginForm> {

// }
