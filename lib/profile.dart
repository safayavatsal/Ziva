import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
void main() => runApp(MaterialApp(
  home: Profile(),
  color: Colors.white,
));
FirebaseAuth auth;
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String email,contact,address,name;
  @override
  void initState() {
    accessdata();
    super.initState();
  }
  void accessdata() async {
    // TODO: implement initState
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    try {
      reference..child(
          "Users").child(user.uid).once().then((DataSnapshot snap) {
        setState(() {
          var data = snap.value;
          email =data['email'];
          contact = data['phone'];
          name = data['name'];
          address = data['address'];
        });
      });
    }

    catch (e) {}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile",style: TextStyle(fontFamily: 'Manzari-Bold',color: Colors.orange),),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:28.0),
              child: CircleAvatar(
                maxRadius: 50.0,
                child: Icon(Icons.person),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:15.0),
              child: Text("Profile",style: TextStyle(
                  fontSize: 20.0
              ),),
            ),
            Divider(indent: 100.0,endIndent: 100.0,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 10.0,
                margin: EdgeInsets.only(top: 20.0),
                child: ListTile(
                  title: Text("Name",style: TextStyle(decoration: TextDecoration.underline),),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
                    child: Text(name != null? name: '',
                      style: TextStyle(fontSize: 15.0),),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right:8.0,left: 8.0),
              child: Card(
                elevation: 10.0,
                margin: EdgeInsets.only(top: 5.0),
                child: ListTile(
                  title: Text("Email Id",style: TextStyle(decoration: TextDecoration.underline),),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
                    child: Text(email != null? email : '',
                      style: TextStyle(fontSize: 15.0),),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right:8.0,left: 8.0,top: 8.0),
              child: Card(
                elevation: 10.0,
                margin: EdgeInsets.only(top: 5.0),
                child: ListTile(
                  title: Text("Contact Number",style: TextStyle(decoration: TextDecoration.underline),),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
                    child: Text(contact != null? contact:'',
                      style: TextStyle(fontSize: 15.0),),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right:8.0,left: 8.0,top: 8.0),
              child: Card(
                elevation: 10.0,
                margin: EdgeInsets.only(top: 5.0),
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Text("Address",style: TextStyle(decoration: TextDecoration.underline),),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
                    child: Text(address != null? address:'',
                      style: TextStyle(fontSize: 15.0),),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


