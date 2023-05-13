import 'package:csebbsbec/main_cse.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_or_register_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user is logged in
          if(snapshot.hasData) {
            return BottomNav();
          }

          //user is not logged in
          else {
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}