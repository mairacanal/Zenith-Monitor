import 'package:flutter/material.dart';
import './login.dart';
import './updatePassword.dart';
import './register.dart';

class Authenticate extends StatefulWidget {
  @override
  AuthenticateState createState() => AuthenticateState();
}

class AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  bool showUpdatePassword = false;
  void toggleUpdatePassword() {
    setState(() => showUpdatePassword = !showUpdatePassword);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      if (showUpdatePassword) {
        return UpdatePassword(toggleUpdatePassword: toggleUpdatePassword);
      } else {
        return Login(
            toggleView: toggleView, toggleUpdatePassword: toggleUpdatePassword);
      }
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
