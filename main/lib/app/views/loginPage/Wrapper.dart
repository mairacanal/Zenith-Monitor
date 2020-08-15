import 'package:flutter/material.dart';
import './Authenticate.dart';
import '../../models/user.dart';
import 'package:provider/provider.dart';



class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final User user = Provider.of<User>(context);


    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      return StreamProvider<UserData>.value(
        value: ,//DatabaseService(uid: user.uid).userData,
        child: ,//aqui viria a primeira tela depois de logado
      );
    }
  }
}
