import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? _verificationId; // Stores the verification ID

  // Send OTP message for phone number verification
  Future<void> sendOtpMessage(String phoneNumber) async {
    final PhoneVerificationCompleted verificationCompleted = (PhoneAuthCredential credential) async {
      await _firebaseAuth.signInWithCredential(credential);
    };

    final PhoneVerificationFailed verificationFailed = (FirebaseAuthException e) {
      print('Verification failed: ${e.message}');
    };

    final PhoneCodeSent codeSent = (String verificationId, int? resendToken) {
      _verificationId = verificationId; // Store the verification ID
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String verificationId) {
      print('Code auto retrieval timeout. Verification ID: $verificationId');
    };

    try {
      final phoneNumberFormatted = '+$phoneNumber';
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumberFormatted,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        timeout: Duration(seconds: 60),
      );
    } catch (e) {
      print('Failed to send OTP message: ${e.toString()}');
    }
  }

  // Retrieve the verification ID
  String? getVerificationId() {
    return _verificationId;
  }

  // Sign in with email and password
  Future<String?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Logged in successfully!';
    } on FirebaseAuthException catch (e) {
      // Handle authentication exceptions
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Incorrect email or password.';
      } else {
        return 'Too many login attempts. Please try again later.';
      }
    }
  }

  // Register with email and password
  Future<String?> registerWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send email verification
      await userCredential.user!.sendEmailVerification();

      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return e.message;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
