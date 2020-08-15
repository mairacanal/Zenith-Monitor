//expose auth functions and a stream of changes

import 'package:zenith_monitor/app/models/user.dart';

class AuthManager {
  //final firebase = Firebase.instance;

  User _userFromFirebaseUser(dynamic user) {}

  Future<UserData> get user {
    return Future.delayed(
        Duration(seconds: 1),
        () => UserData(
              name: "Leonardo Baptistella",
              accessLevel: "Zenith User",
              image: null,
            ));
  }

  Future<bool> isLogged() {
    return Future.delayed(Duration(milliseconds: 500), () => true);
  }

  // sign in
  Future<bool> signIn(SignInPacket data) async {
    return Future.delayed(Duration(seconds: 2), () => true);
  }

  //register
  Future<bool> registerUser(RegisterPacket data) async {
    return Future.delayed(Duration(seconds: 1), () => true);
  }

  //sign out, n sei onde vai usar
  Future signOut() async {
    return Future.delayed(Duration(milliseconds: 750), () => true);
  }

  Future<bool> resetPassword(String email) async {
    return Future.delayed(Duration(seconds: 1), () => true);
  }
}
