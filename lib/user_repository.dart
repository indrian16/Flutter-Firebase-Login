import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class UserRepository {

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookLogin _facebookLogin;

  UserRepository(
      {FirebaseAuth firebaseAuth,
      GoogleSignIn googleSignin,
      FacebookLogin facebookLogin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn(),
        _facebookLogin = facebookLogin ?? FacebookLogin();

  Future<void> signInWithEmailAndPass(String email, String password) async {

    return _firebaseAuth.signInWithEmailAndPassword(
      email: email, 
      password: password);
  }

  Future<FirebaseUser> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser();
  }

  Future<FirebaseUser> signInWithFacebook() async {

    final resultFB = await _facebookLogin.logInWithReadPermissions(['email']);
    
    if (resultFB.status == FacebookLoginStatus.loggedIn) {

      final AuthCredential credential = FacebookAuthProvider.getCredential(
        accessToken: resultFB.accessToken.token
      );
      await _firebaseAuth.signInWithCredential(credential);
      return _firebaseAuth.currentUser();
    }
    return null;
  }

  Future<void> signUp({
    @required String email, @required String password
    }) async {

      return _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
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
      _googleSignIn.signOut(),
      _facebookLogin.logOut()
    ]);
  }

}
