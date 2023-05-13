import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/my_text_field.dart';
import '../components/my_button.dart';
import '../components/square_tile.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //text editing controllers
  final emailController = TextEditingController();
  final passController = TextEditingController();


  //Sign User In
  void signUserIn() async {
    //show loading circle
    showDialog(
        context: context,
        builder: (context){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
    );


    try{
      //try sign in
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passController.text
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      //show error message
      showErrorMessage(e.code);
    }
  }

  //Error Message To user
  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.deepPurpleAccent,
            title: Center(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),


                  //logo
                   Image.asset('lib/images/newlogo.png',scale: 2,),


                  const SizedBox(height: 30),


                  //login text
                  const Text(
                    'Please Login to continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 30),


                  //username text field
                  MyTextField(
                    controller: emailController,
                    hintText: 'Username',
                    obscureText: false,
                  ),

                  const SizedBox(height: 20),


                  //pass text field
                  MyTextField(
                    controller: passController,
                    hintText: 'Password',
                    obscureText: true,
                  ),

                  const SizedBox(height: 20),


                  //forgot password
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),


                  //Submit Button
                  MyButton(
                    text: 'Sign In',
                    onTap: signUserIn, name: 'Sign In',
                  ),

                  const SizedBox(height: 30),


                  //or continue with
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: const [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.white,
                          ),
                        ),

                        Text(
                          '   Or Continue With   ',
                          style: TextStyle(color: Colors.white,),
                        ),

                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),


                  //other options (Google and Apple Sign In)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //google button
                      SquareTile(
                        onTap: () => {},
                        imagePath: 'lib/images/google.png',
                      ),

                      const SizedBox(width: 60),

                      //apple button
                      SquareTile(
                        onTap: () {},
                        imagePath: 'lib/images/apple.png',
                      ),
                    ],
                  ),

                  const SizedBox(height: 50),


                  //new register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'New Member?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(width: 10),

                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          'Register Now',
                          style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
