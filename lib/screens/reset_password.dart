import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_auth/screens/signin_screen.dart';

import '../reusable_widgets/reusable_widget.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController _emailTextController = TextEditingController();
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
                reusableTextField("Enter Email Id", Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "Reset Password", () {
                  FirebaseAuth.instance
                      .sendPasswordResetEmail(email: _emailTextController.text)
                      .then((value) => Navigator.of(context).pop());
                }),
                signInOption()
              ],
            ),
          ))),
   ));
  }


  Row signInOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Back to",
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