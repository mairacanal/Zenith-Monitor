import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/app/views/loginPage/login.dart';
import 'package:zenith_monitor/app/views/loginPage/register.dart';
import 'package:zenith_monitor/app/views/loginPage/updatePassword.dart';
import '../../bloc/login_bloc/login_bloc.dart';
import "../../models/user.dart";
import './Effects/Loader.dart';
import './Effects/FadeAnimation.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<LoginBloc>(context).add(LoginStart());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSignInSuccesful) {
          Navigator.popAndPushNamed(context, '/map');
        }
      },
      builder: (context, state) {
        if (state is LoginLoading) {
          return Loader();
        } else if (state is LoginInitial) {
          return Login();
        } else if (state is LoginRegisterPage) {
          debugPrint("change to register page");
          return Register();
        } else if (state is LoginResetPage) {
          return UpdatePassword();
        } else {
          return Login();
        }
      },
    );
  }
}
