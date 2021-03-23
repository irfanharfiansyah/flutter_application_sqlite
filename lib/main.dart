import 'package:flutter/material.dart';
import 'package:flutter_application_sqlite/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Tambahkan Item",
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: Home(),
    );
  }
}
