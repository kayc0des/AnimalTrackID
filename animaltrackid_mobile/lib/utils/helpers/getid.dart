import 'package:firebase_auth/firebase_auth.dart';

Future<String?> getUserId() async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    return user.uid;
  } else {
    return null;
  }
}
