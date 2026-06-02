import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  AuthRepository({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;
  bool _googleReady = false;

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  // --- Email / password ---------------------------------------------------

  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) {
    return _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  Future<UserCredential> registerWithEmail({
    required String email,
    required String password,
  }) {
    return _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  Future<void> sendPasswordReset(String email) {
    return _auth.sendPasswordResetEmail(email: email.trim());
  }

  // --- Google (API v7) ----------------------------------------------------

  Future<void> _ensureGoogleInitialized() async {
    if (_googleReady) return;

    await GoogleSignIn.instance.initialize(
      serverClientId:
          '1013171447198-rkipovn7k1124ldjnbhvjkm4quv2kkr0.apps.googleusercontent.com',
    );
    _googleReady = true;
  }

  Future<UserCredential> signInWithGoogle() async {
    await _ensureGoogleInitialized();

    final googleUser = await GoogleSignIn.instance.authenticate(
      scopeHint: ['email'],
    );

    final idToken = googleUser.authentication.idToken;
    final credential = GoogleAuthProvider.credential(idToken: idToken);

    return _auth.signInWithCredential(credential);
  }

  // --- Logout ---------------------------------------------------------------

  Future<void> signOut() async {
    if (_googleReady) {
      await GoogleSignIn.instance.signOut();
    }
    await _auth.signOut();
  }

  static String messageFromError(Object error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'invalid-email':
          return 'That email address looks invalid.';
        case 'user-not-found':
        case 'wrong-password':
        case 'invalid-credential':
          return 'Incorrect email or password.';
        case 'email-already-in-use':
          return 'An account with this email already exists.';
        case 'weak-password':
          return 'Password is too weak (at least 6 characters).';
        case 'network-request-failed':
          return 'No internet connection.';
        default:
          return 'Something went wrong. Please try again.';
      }
    }
    return 'Something went wrong. Please try again.';
  }
}
