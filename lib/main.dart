import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_auth/screens/admin_screen.dart';
import 'package:google_auth/screens/home_screen.dart';
import 'package:google_auth/screens/signin_screen.dart';
import 'package:google_auth/screens/signup_screen.dart';
import 'package:lottie/lottie.dart';
import 'firebase_options.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options:DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home:StreamBuilder(
          stream:FirebaseAuth.instance.authStateChanges() ,
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.active){
              if(snapshot.hasData){
                 FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: 'admin@gmail.com',
                            password: 'admin123')
                        .then((value) {
                          if ( User == 'admin@gmail.com') {
                       Admin_Screen();
                          }
                    }).onError((error, stackTrace) {
                      
                     
                      print("Error ${error.toString()}");
                      
                    });
                return LoadingPage();
              }else if(snapshot.hasError){
                return Center(child: Text('${snapshot.error}'),);
              }
            } 
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
             return SplashScreen();
          },
        )
      
      
      
      
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),
          ()=>Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => SignInScreen()
          ))
         );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: 
      Column(
        children: [
          Center(
            child: Lottie.network(
                      'https://assets9.lottiefiles.com/private_files/lf30_y0m027fl.json'),
                   ),
                   Text('SMART MESS',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 32),)
        ],
      ),)
    
    );
  }
}


