import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:interface_zenith/Models/datatypes.dart';


class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  final CollectionReference usersCollection = Firestore.instance.collection('users');

  Future updateUserData(String name, String accessLevel,
      String imageURL) async {
    return await usersCollection.document(uid).setData({
      'name': name,
      'accessLevel': accessLevel,
      'imageURL': imageURL,
    });
  }


  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    try{
      return UserData(
        name: snapshot.data['name'],
        accessLevel: snapshot.data['accessLevel'],
        image: snapshot.data['imageURL'],
      );
    } catch(e){
      return UserData(name: "User", accessLevel: "Entusiasta", image: null);
    }
  }


  Stream<UserData> get userData {
    return usersCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

}

