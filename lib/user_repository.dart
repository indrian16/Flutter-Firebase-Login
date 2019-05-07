import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();
  
  Future<void> signInWithEmailAndPass(String email, String password) async {

    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password
    );
  }

  Future<FirebaseUser> signInWithGoogle() async {

    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser();
  }

  Future<void> signUp({
    @required String email,
    @required String password
  }) async {

    return _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password
    );
  }

  Future<bool> isSignedIn() async {

    return await _firebaseAuth.currentUser() != null;
  }

  Future<String> getUserEmail() async {

    return (await _firebaseAuth.currentUser()).email;
  }

  Future<void> requestResetPassword({@required String email}) async {

    return await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {

    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut()
    ]);
  }
}