import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopping_for_friends/models/user_model.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final db = Firestore.instance;
User currentSignedInUser;

Future<User> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  if (googleSignInAccount == null) {
    return null;
  }

  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );
  final FirebaseUser user = await _auth.signInWithCredential(credential);
  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  // check if user already exists
  final DocumentSnapshot userSnapshot =
      await db.collection('users').document(user.uid).get();
  if (userSnapshot.exists) {
    // user exists, retrieve user data from firestore
    updateCurrentSignedInUser(user, userSnapshot);
  } else {
    // user not exists, create a new user
    await addUserToFirestore(user: user);
  }
  print(currentSignedInUser);
  return currentSignedInUser;
}

Future<bool> signOutGoogle() async {
  currentSignedInUser = null;
  await googleSignIn.signOut();
  return true;
}

// retrieve user data from Firestore
void updateCurrentSignedInUser(
    FirebaseUser user, DocumentSnapshot userSnapshot) async {
  currentSignedInUser = User.fromMap(user.uid, userSnapshot.data);
}

// add user to firestore, email as document ID
Future<void> addUserToFirestore({FirebaseUser user}) async {
  // add user to firestore, email as document ID
  currentSignedInUser =
      User(email: user.email, name: user.displayName, uid: user.uid);
  await db
      .collection('users')
      .document(user.uid)
      .setData(currentSignedInUser.toMap());
}
