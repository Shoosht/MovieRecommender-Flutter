import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movierecommender/reusable_widgets/reusable_widget.dart';
import 'package:movierecommender/screens/signup_screen.dart';
import 'package:movierecommender/screens/reset_password.dart';
import 'package:movierecommender/screens/preference_screen.dart';
import 'package:movierecommender/utils/color_utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // Define the TextEditingController
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: hexStringToColor("232430"), // Set the background color of the Container
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).size.height * 0.13,
              20,
              0,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  "MovieRecommender",
                  style: GoogleFonts.kadwa(
                    fontSize: 30,
                    color: hexStringToColor("DDDEEB"), 
                    letterSpacing: 1.100,
                    ),
                ),
                logoWidget("assets/images/movielogo.png"),
                const SizedBox(height: 30),
                reusableTextField(
                  "Enter Email",
                  Icons.person_outline,
                  false,
                  _emailTextController, // Use _emailTextController
                ),
                SizedBox(height: 15),
                reusableTextField(
                  "Enter Password",
                  Icons.lock_outline,
                  true,
                  _passwordTextController, // Use _passwordTextController
                ),
                SizedBox(height: 5),
                forgotPassword(context),
                firebaseUIButton(context, "Sign in.", () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PreferenceScreen()));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }),
                signUpOption(context), // Pass the context here
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Row signUpOption(BuildContext context) { // Pass context as a parameter
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
       Text("Don't have an account?",
          style: TextStyle(color: hexStringToColor("DDDEEB"))),
      GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SignUpScreen()));
        },
        child: Text(
          " Sign Up",
          style: TextStyle(color: hexStringToColor("DDDEEB"), fontWeight: FontWeight.bold),
        ),
      )
    ],
  );
}


Widget forgotPassword(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 35,
    alignment: Alignment.bottomRight,
    padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
     child: TextButton(
      child: const Text(
         "Forgot Password?",
        style: TextStyle(color: Colors.white70),
         textAlign: TextAlign.right,
       ),
       onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => ResetPassword())),
     ),
  );
}


