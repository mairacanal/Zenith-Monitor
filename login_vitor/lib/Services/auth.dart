import 'package:firebase_auth/firebase_auth.dart';
import 'package:interface_zenith/Services/database.dart';
import 'package:interface_zenith/Models/datatypes.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }


  // sign in
  Future signIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //register
  Future register(String name, String imageURL, String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      await DatabaseService(uid : user.uid).updateUserData(name, 'null', imageURL);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out, n sei onde vai usar
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future resetPassword(String email) async{
    try {
      return await _auth.sendPasswordResetEmail(email : email);
    } catch (e) {
      print(e.toString());
      return 1;
    }
  }
}
