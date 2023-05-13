/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  //Sign in with google
  signInWithGoogle() async {
    //begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //obtain auth details from user
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //create new user details
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    //Sign in the user
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}*/
