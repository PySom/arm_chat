import 'package:arm_chat/exceptions/api_failure_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  FirebaseAuth _fb;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  AuthenticationService(this._fb);

  Stream<FirebaseUser> get authStateChanges => _fb?.onAuthStateChanged;

  Future<bool> loginAsync({String email, String password}) async {
    try {
      AuthResult result = await _fb.signInWithEmailAndPassword(
          email: email, password: password);
      return result != null;
    } catch (e) {
      print(e.message);
      throw ApiFailureException(e.message);
    }
  }

  Future<FirebaseUser> getCurrentUserAsync() async => await _fb.currentUser();

  Future<bool> registerAsync({String email, String password}) async {
    try {
      AuthResult result = await _fb.createUserWithEmailAndPassword(
          email: email, password: password);
      return result != null;
    } catch (e) {
      print(e.message);
      throw ApiFailureException(e.message);
    }
  }

  Future<bool> signInWithGoogleAsync() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final authResult = await _fb.signInWithCredential(credential);
    final user = authResult.user;
    print(user);
    return user != null;
  }

  Future<void> logoutAsync() async {
    await _fb.signOut();
  }
}
