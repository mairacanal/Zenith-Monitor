class User {
  final String uid;

  User({this.uid});
}

class UserData {
  String name;
  String accessLevel;
  String image;

  UserData({this.name, this.accessLevel, this.image});
}

class RegisterPacket {
  final String name;
  final String imageURL;
  final String email;
  final String password;

  RegisterPacket(this.name, this.imageURL, this.email, this.password);
}

class SignInPacket {
  final String email;
  final String password;

  SignInPacket(this.email, this.password);
}
