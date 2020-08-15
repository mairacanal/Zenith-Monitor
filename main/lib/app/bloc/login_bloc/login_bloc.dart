import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zenith_monitor/app/components/firebase_authentication.dart';
import 'package:zenith_monitor/app/models/user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthManager authManager;
  LoginBloc(this.authManager) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginStart) {
      yield LoginLoading();
      // check if already logged in
      if (await authManager.isLogged()) {
        yield LoginSignInSuccesful();
      } else {
        // Continue with normal Login Flow
        yield LoginInitial();
      }
    } else if (event is LoginSignIn) {
      yield LoginLoading();
      if (await authManager.signIn(event.data)) {
        yield LoginSignInSuccesful();
      } else {
        yield LoginSignInFailed();
      }
    } else if (event is LoginSignOut) {
      yield LoginLoading();
      if (await authManager.signOut()) {
        yield LoginSignOutSuccesful();
      } else {
        yield LoginSignOutFailed();
      }
    } else if (event is LoginRegister) {
      yield LoginLoading();
      // is it even useful to make this distinctios here?
      if (await authManager.registerUser(event.data)) {
        yield LoginRegisterSuccesful();
      } else {
        // yield LoginRegisterFailedRequirements();
        yield LoginRegisterFailed();
      }
    } else if (event is LoginResetPassword) {
      yield LoginLoading();
      if (await authManager.resetPassword(event.data)) {
        yield LoginResetSuccesful();
      } else {
        yield LoginResetFailed();
      }
    }
  }
}
