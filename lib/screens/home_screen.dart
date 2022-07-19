import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_auth/screens/signin_screen.dart';
import 'package:lottie/lottie.dart';

import '../reusable_widgets/reusable_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
 
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
                child: ElevatedButton(
                  child: Text("Logout"),
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      print("Signed Out");
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignInScreen()));
                    });
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/2,),
          Center(
            child: Text('To create new request press on "+" icon',style: TextStyle(fontSize: 18),),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
          showCupertinoDialog(context: context, builder: (BuildContext content){
            return Form();
          });
          // showDialog(
          //     context: context,
          //     builder: (BuildContext context) {
          //       return AlertDialog(
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(10)),
          //         title: const Text("Add Todo"),
          //         content: Container(
          //           width: 400,
          //           height: 100,
          //           child: Column(
          //             children: [
          //               TextField(
          //                 onChanged: (String value) {
          //                   name = value;
          //                 },
          //               ),
          //               TextField(
          //                 onChanged: (String value) {
          //                   year_of_study = value;
          //                 },
          //               ),
          //             ],
          //           ),
          //         ),
          //         actions: <Widget>[
          //           TextButton(
          //               onPressed: () {
          //                 setState(() {
          //                   //todos.add(title);
          //                   createRequests();
          //                 });
          //                 Navigator.of(context).pop();
          //               },
          //               child: const Text("Add"))
          //         ],
          //       );
          //     });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
    ));
  }
}

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),
          ()=>Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => HomeScreen()
          ))
         );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
      child: CircularProgressIndicator(),
    ),
    );
  }
}

class Form extends StatefulWidget {
  

  @override
  State<Form> createState() => _FormState();
}

class _FormState extends State<Form> {
  List requests = List.empty();

  String name = "";

  String year_of_study = "";

  String room_number = "";

  String hostel_name = "";

  String reason = "";

  
    createRequests() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Requests").doc(name);
  
  Map<String, String> RequestList = {
      "name": name,
      "room number":room_number,
      "year of study":year_of_study,
      "hostel name":hostel_name,
      "reason":reason,
   

    };

    

    documentReference
        .set(RequestList)
        .whenComplete(() => print("Data stored successfully"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body:
      SafeArea(child: 
    Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              
               Container(
                 width: MediaQuery.of(context).size.width/2,
                  height: MediaQuery.of(context).size.height/4,
                 child: Lottie.network(
                  'https://assets4.lottiefiles.com/packages/lf20_xyadoh9h.json'),
               ),
               //form
               Padding(
                  padding: const EdgeInsets.only(right: 30,left: 30),
                  child:TextField(
    cursorColor: Colors.black,
    style: TextStyle(color: Colors.black.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        Icons.person,
        color: Colors.black,
      ),
      labelText: "Name",
      labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.black.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
     onChanged: (String value) {
                            name = value;
                          },
    ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30,left: 30),
                  child:TextField(
    cursorColor: Colors.black,
    style: TextStyle(color: Colors.black.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        Icons.date_range,
        color: Colors.black,
      ),
      labelText: "Year of study",
      labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.black.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
     onChanged: (String value) {
                            year_of_study = value;
                          },
    ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30,left: 30),
                  child:TextField(
    cursorColor: Colors.black,
    style: TextStyle(color: Colors.black.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        Icons.room,
        color: Colors.black,
      ),
      labelText: "Room number",
      labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.black.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
     onChanged: (String value) {
                            room_number = value;
                          },
    ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30,left: 30),
                  child:TextField(
    cursorColor: Colors.black,
    style: TextStyle(color: Colors.black.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        Icons.home,
        color: Colors.black,
      ),
      labelText: "Hostel name",
      labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.black.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
     onChanged: (String value) {
                            hostel_name = value;
                          },
    ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30,left: 30),
                  child:TextField(
    cursorColor: Colors.black,
    style: TextStyle(color: Colors.black.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        Icons.note,
        color: Colors.black,
      ),
      labelText: "Reason for the request",
      labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.black.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
     onChanged: (String value) {
                            reason = value;
                          },
    ),
                ),
                const SizedBox(
                  height: 20,
                ),
               
                 Padding(
                 padding: const EdgeInsets.only(right: 30,left: 30),
                   child: ElevatedButton(
      onPressed: () {
        // requests.add(name);
        createRequests();
        
        Timer(const Duration(seconds: 3), () =>  Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Done())));
        
      },
      child: Text(
        'Submit',
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Color.fromARGB(255, 0, 140, 255);
            }
            return Color.fromARGB(255, 0, 140, 255);
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),),
    SizedBox(height: 10,),
    Padding(
                 padding: const EdgeInsets.only(right: 30,left: 30),
                   child: ElevatedButton(
      onPressed: () {
       Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomeScreen()));
        
      },
      child: Text(
        'Cancel',
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Color.fromARGB(255, 0, 140, 255);
            }
            return Color.fromARGB(255, 0, 140, 255);
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),)
               ]))) ));}
                 
     
  }

  class Done extends StatelessWidget {
  const Done({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     Timer(const Duration(seconds: 3), () =>  Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomeScreen())));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
      child:  Lottie.network('https://assets3.lottiefiles.com/packages/lf20_zxtzul55.json'),
      
      ),
      
    );
  }
}
