import 'package:flutter/material.dart';
import 'register_page.dart';
import 'login_page.dart';


class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({Key? key}) : super(key: key);

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  //initially show login page
  bool showLoginPage = true;

  //toggle between login and register page
  void toggle() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: toggle,
      );
    } else {
      return RegisterPage(
        onTap: toggle,
      );
    }
  }
}
