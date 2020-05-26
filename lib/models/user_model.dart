import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String name;

  User({
    this.email,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
    };
  }


  User.fromMap(Map<String, dynamic> map)
      : assert(map['email'] != null),
        assert(map['name'] != null),
        email = map['email'],
        name = map['name'];

  User.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data);
}
