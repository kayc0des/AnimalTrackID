// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // ✅ Sign up with Email & Password
//   Future<User?> signUpWithEmail(String email, String password) async {
//     try {
//       UserCredential userCredential =
//           await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential.user;
//     } catch (e) {
//       print("Error: $e");
//       return null;
//     }
//   }

//   // ✅ Sign in with Google
//   Future<User?> signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       if (googleUser == null) return null; // User canceled the sign-in

//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       UserCredential userCredential =
//           await _auth.signInWithCredential(credential);
//       return userCredential.user;
//     } catch (e) {
//       print("Google Sign-In Error: $e");
//       return null;
//     }
//   }
// }
