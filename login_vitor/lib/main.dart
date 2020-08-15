import 'package:flutter/material.dart';
import 'package:interface_zenith/Wrapper.dart';
import 'package:interface_zenith/Services/auth.dart';
import 'package:interface_zenith/Models/datatypes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );


  }
}