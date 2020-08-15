import 'package:flutter/material.dart';
import 'package:interface_zenith/Authenticate.dart';
import 'package:interface_zenith/Models/datatypes.dart';
import 'package:provider/provider.dart';
import 'package:interface_zenith/Services/database.dart';



class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final User user = Provider.of<User>(context);


    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      return StreamProvider<UserData>.value(
        value: DatabaseService(uid: user.uid).userData,
        child: //aqui viria a primeira tela depois de logado
      );
    }
  }
}