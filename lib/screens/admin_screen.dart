import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Admin_Screen extends StatelessWidget {
  const Admin_Screen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(elevation:0,
    backgroundColor: Color.fromARGB(255, 160, 216, 238),
     title: Text('Requests',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.white),),),
     body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Requests").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.hasData || snapshot.data != null) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  QueryDocumentSnapshot<Object?>? documentSnapshot =
                      snapshot.data?.docs[index];
                  return Dismissible(
                      key: Key(index.toString()),
                      child: Card(
                        elevation: 4,
                             
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text("Name : " + documentSnapshot?["name"],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                           ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Year of study : " + documentSnapshot?["year of study"],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Hostel Name : " + documentSnapshot?["hostel name"],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Room No : " + documentSnapshot?["room number"],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Reason: " + documentSnapshot?["reason"],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              SizedBox(width: 20,),
                              ElevatedButton(onPressed: (){} ,
                               child: Text("APPROVE",style: TextStyle(color: Color.fromARGB(255, 4, 211, 111),fontSize: 22),)),
                               SizedBox(width: 20,),
                               ElevatedButton(onPressed: null,
                               child: Text("REJECT",style: TextStyle(color: Colors.red,fontSize: 22),))
                            ],
                          ),
                          SizedBox(height: 10,),
                          ],
                        ),
                        // child: ListTile(
                        //   title: Text((documentSnapshot != null) ? (documentSnapshot["name"]) : ""),
                        //   subtitle: Text((documentSnapshot != null)
                        //       ? ((documentSnapshot["hostel name"] != null)
                        //           ? documentSnapshot["hostel name"]
                        //           : "")
                        //       : ""),

                         
                            
                        //   ),
                        ),
                      );
                });
          }
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.red,
              ),
            ),
          );
        },
      ),
      
      
    );
  }
}
