import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_auth/screens/home_screen.dart';
import 'package:google_auth/screens/signin_screen.dart';

import '../reusable_widgets/reusable_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      
      body: SafeArea(child: 
      Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Column(
              children: <Widget>[
                Center(
                child:
              Image.asset('assets/images/clg_logo.png',fit: BoxFit.fitWidth,)
          ),
                const SizedBox(
                  height: 80,
                ),
                reusableTextField("Enter Roll number", Icons.person_outline, false,
                    _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Email Id", Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outlined, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "Sign Up", () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    print("Created New Account");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoadingPage()));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }),
                 SizedBox(
             height: 10,
           ),
           signInOption(),
              ],
            ),
          ))),
   ) );
  }
  Row signInOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have account?",
            style: TextStyle(color: Color.fromARGB(255, 136, 92, 238))),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignInScreen()));
          },
          child: const Text(
            " Log In",
            style: TextStyle(color: Color.fromARGB(255, 96, 39, 231), fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}

