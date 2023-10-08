import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/helpers/spacers.dart';
import 'package:social_media/utils/buttons.dart';
import 'package:social_media/utils/text_fields.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final String _emailHintText = 'Email: ';
  final _passwordController = TextEditingController();
  final String _passwordHintText = 'Password: ';
  final _confirmPasswordController = TextEditingController();
  final String _confirmPasswordHintText = 'Confirm password: ';

  // sing up function
  void signUp() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // make sure passwords match
    if (_passwordController.text != _confirmPasswordController.text) {
      // pop loading circle
      Navigator.pop(context);
      // show error to the user
      displayErrorMessage("Passwords don't match!");
    } else {
      // try creating the user
      try {
        // create the user
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // after creating the user, create a new document in cloud firestore called Users
        FirebaseFirestore.instance
            .collection("Users")
            .doc(userCredential.user!.email)
            .set({
          'username': _emailController.text.split('@')[0], // initial username
          'bio': 'Empty bio..',
        });

        // pop loading circle
        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        // pop loading circle
        if (context.mounted) Navigator.pop(context);

        displayErrorMessage(e.code);
      }
    }
  }

  // display error message while siginig up
  void displayErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
                  obscureText: true,
                ),

                verticalSpacer(20),

                MyTextField(
                  controller: _confirmPasswordController,
                  hintText: _confirmPasswordHintText,
                  obscureText: true,
                ),

                verticalSpacer(50),

                // sign up button
                MyButton(
                  onTap: signUp,
                  text: 'Sign Up',
                ),

                verticalSpacer(30),

                // go to register page
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      horizontalSpacer(5),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          'Login Now!',
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
