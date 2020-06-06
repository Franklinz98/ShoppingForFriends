import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_for_friends/models/user_model.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final db = Firestore.instance;
User currentSignedInUser = User();

Future<User> signInWithFirebase(email, password) async {
  var fbuser;
  try {
    fbuser = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  } catch (error) {
    print('ERRORS');
    print(error.message.toString());
    print(error.code.toString());
    return null;
  }
  final DocumentSnapshot userSnapshot =
      await db.collection('users').document(fbuser.email).get();
  updateCurrentSignedInUser(userSnapshot);
  return currentSignedInUser;
}

Future<User> signUpWithFirebase(email, password, name) async {
  var fbUser;
  try {
    fbUser = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  } catch (error) {
    throw Exception(error.code);
  }
  if (fbUser.email == email) {
    try {
      var user = await _auth.currentUser();
      UserUpdateInfo updateUser = UserUpdateInfo();
      updateUser.displayName = name;
      user.updateProfile(updateUser);
    } catch (error) {
      print(error);
      throw Exception(error.code);
    }
  } else {
    throw Exception('ERROR_SET_NAME');
  }

  currentSignedInUser = User(
    email: email,
    name: name,
    uid:fbUser.uid
  );
  print('currentSignedInUser' + currentSignedInUser.toString());
  await db
      .collection('users')
      .document(email)
      .setData(currentSignedInUser.toMap());
  return currentSignedInUser;
}

Future<String> recoverWithFirebase(email) async {
  try {
    await _auth.sendPasswordResetEmail(email: email);
  } catch (error) {
    throw Exception(error.code);
  }
  return 'OK';
}

void updateCurrentSignedInUser(DocumentSnapshot userSnapshot) {
  currentSignedInUser = User.fromSnapshot(userSnapshot);
}

Future<bool> signOutFirebase() async {
  currentSignedInUser = User();
  await _auth.signOut();
  return true;
}
