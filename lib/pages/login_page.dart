import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/helpers/spacers.dart';
import 'package:social_media/utils/buttons.dart';
import 'package:social_media/utils/text_fields.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _emailHintText = 'Email: ';
  final _passwordController = TextEditingController();
  final _passwordHintText = 'Password: ';

  // sign user in
  void signIn() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // pop loading circle
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      // pop loading circle
      if (context.mounted) Navigator.pop(context);
      // display error message
      displayErrorMessage(e.code);
    }
  }

  // display error taht occured while signing in
  void displayErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300], // to change later
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SafeArea(
            // ignores the notch area
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // logo
                Icon(
                  Icons.lock,
                  size: 100,
                ),

                verticalSpacer(20),

                // welcome back text message
                const Text('Welcome back'),

                verticalSpacer(10),

                // email textfield
                MyTextField(
                    controller: _emailController,
                    hintText: _emailHintText,
                    obscureText: false),

                verticalSpacer(20),

                // password textfield
                MyTextField(
                    controller: _passwordController,
                    hintText: _passwordHintText,
                    obscureText: true),

                verticalSpacer(50),

                // sign in button
                MyButton(
                  onTap: signIn,
                  text: 'Sign In',
                ),

                verticalSpacer(30),

                // go to register page
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Doesn't have an account?"),
                      horizontalSpacer(5),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          'REGISTER NOW!',
                          style: TextStyle(
                            color: Colors.tealAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
