import 'package:arm_chat/exceptions/api_failure_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  FirebaseAuth _fb;
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

  Future<void> logoutAsync() async {
    await _fb.signOut();
  }
}
