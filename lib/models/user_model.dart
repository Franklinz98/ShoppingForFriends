import 'package:flutter/foundation.dart';

class User {
  final String email;
  final String name;
  final String uid;

  User({
    @required this.email,
    @required this.name,
    @required this.uid,
  });

  Map<String, dynamic> toMap() {
    return {'email': email, 'name': name};
  }

  factory User.fromMap(String uid, Map<String, dynamic> map) {
    assert(uid != null);
    assert(map != null);
    return User(
      email: map['email'],
      name: map['name'],
      uid: uid,
    );
  }
}
