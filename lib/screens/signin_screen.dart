import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_auth/reusable_widgets/reusable_widget.dart';
import 'package:google_auth/screens/admin_screen.dart';
import 'package:google_auth/screens/home_screen.dart';
import 'package:google_auth/screens/reset_password.dart';
import 'package:google_auth/screens/signup_screen.dart';
class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
    TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:SafeArea(child: 
       Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child:
              Image.asset('assets/images/clg_logo.png',fit: BoxFit.fitWidth,)
          ),
         
          SizedBox(
            height: 150,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30,right: 30),
            child: reusableTextField("Enter Email",Icons.person_outline,false,_emailTextController),
          ),

          SizedBox(height: 20,),
           
           Padding(
             padding: const EdgeInsets.only(left: 30,right: 30),
             child: reusableTextField("Enter Password",Icons.lock,true,_passwordTextController),
           ),
           SizedBox(
             height: 10,
           ),
            
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: forgetPassword(context),
            ),
                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30),
                  child: firebaseUIButton(context, "Sign In", () {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text)
                        .then((value) {
                          if (_emailTextController.text!='admin@gmail.com') {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoadingPage()));
                          }else{
                            Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Admin_Screen()));
                          };
                    }).onError((error, stackTrace) {
                      
                      showAlert(context);
                      print("Error ${error.toString()}");
                      
                    });
                  }),
                ),
        

           signUpOption(),
          ],
          ),
        ),
      ),
   ) );
  }
 Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Color.fromARGB(255, 136, 92, 238))),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Color.fromARGB(255, 96, 39, 231), fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Color.fromARGB(255, 96, 39, 231)),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => ResetPassword())),
      ),
    );
  }

   Widget showAlert(BuildContext context) {
    return Container(
     color: Colors.red,
     width: double.infinity,
     
     padding: EdgeInsets.all(8),
     child: Row(),
    );
  }
  // return SizedBox(height:0);


}
