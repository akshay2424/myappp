import 'package:flutter/material.dart';
// import 'model.dart';
class Result extends StatelessWidget {
//   Model model;
// Result({this.model});
// final http.Response response = await http.post(
//     'https://jsonplaceholder.typicode.com/albums',
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'title': title,
//     }),
//   );
@override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(title: Text('Successful')),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Welecome", style: TextStyle(fontSize: 22)),
            // Text(model.lastName, style: TextStyle(fontSize: 22)),
            // Text(model.email, style: TextStyle(fontSize: 22)),
            // Text(model.password, style: TextStyle(fontSize: 22)),
          ],
        ),
      ),
    ));
  }
}

