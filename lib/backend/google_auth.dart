import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopping_for_friends/models/user_model.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final db = Firestore.instance;
User currentSignedInUser = User();

Future<User> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  print('DC:signInWithGoogle');
  print(googleSignInAccount);
  if (googleSignInAccount == null) {
    return null;
  }

  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
  print('DC:googleSignInAuthentication');
  print(googleSignInAuthentication);
  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );
  print('DC:credential');
  print(credential);
  final FirebaseUser user = await _auth.signInWithCredential(credential);
  print('DC:user');
  print(user);
  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  print('DC:currentUser');
  print(currentUser);
  // check if user already exists
  final DocumentSnapshot userSnapshot = await db
      .collection('users')
      .document(user.email)
      .get();
  print('DC:userSnapshot');
  print(userSnapshot);
  print(userSnapshot.exists);
  if (userSnapshot.exists) {
    // user exists, retrieve user data from firestore
    updateCurrentSignedInUser(userSnapshot);
  } else {
    // user not exists, create a new user
    await addUserToFirestore(user: user);
  }
  print('DC: GOLAZOPAPA');

  return currentSignedInUser;
}

void signOutGoogle() async {
  currentSignedInUser = User();
  await googleSignIn.signOut();
  print('user signed out');
}

// retrieve user data from Firestore
void updateCurrentSignedInUser(DocumentSnapshot userSnapshot) {
  currentSignedInUser = User.fromSnapshot(userSnapshot);
}

// add user to firestore, email as document ID
Future<void> addUserToFirestore({FirebaseUser user}) async {
  // add user to firestore, email as document ID
  currentSignedInUser = User(
    email: user.email,
    name: user.displayName,
  );
  await db
      .collection('users')
      .document(user.email)
      .setData(currentSignedInUser.toMap());
}
