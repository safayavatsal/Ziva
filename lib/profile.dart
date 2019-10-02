import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
String uname,ucontact,uaddress;
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

  String email, contact, address, name;
  void validateandsubmit() async {
    Navigator.of(context).pop();
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    ProgressDialog progressDialog = new ProgressDialog(context);
    progressDialog.show();
    DatabaseReference database = FirebaseDatabase.instance.reference();
    Map<String, String> data = Map();
    data["name"] = uname;
    data["phone"] = ucontact;
    data["address"] = uaddress;
    if (data != null) {
      print(data);
      setState(() {
        database.child("Users").child(user.uid).update(data).catchError((e) {
          progressDialog.dismiss();
          Navigator.of(context).pop();
          Fluttertoast.showToast(
              msg: "Data not Updated",
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_LONG);
        });
        progressDialog.dismiss();
        Navigator.of(context).pop();
        Fluttertoast.showToast(
            msg: "User Data Updated",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG);
        accessdata();
      });
    }
  }
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
      resizeToAvoidBottomPadding: false,
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
            FlatButton(
              onPressed: () {
                Addcategory(
                    context,
                    name,contact,address
                ).then((onValue) {
                  SnackBar my = SnackBar(
                    content: Text(
                        onValue),
                  );
                  Scaffold.of(context)
                      .showSnackBar(my);
                });
              },
              child: Text("Edit Your Profile"),
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
                    child: Text(name != null? name: 'Loading...',
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
                    child: Text(email != null? email : 'Loading...',
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
                    child: Text(contact != null? contact:'Loading...',
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
                    child: Text(address != null? address:'Loading...',
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
  Future<String> Addcategory(BuildContext context, String name, String contact, String address) {
    return showDialog(
        context: context,
        builder: (context) {
          return Form(
            key: _formKey,
            autovalidate: true,
            child: AlertDialog(
              title: Text("Update Profile"),
              content: Container(
                height: 180.0,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (value) =>
                      value.isEmpty ? 'Please Enter the Name' : null,
                      initialValue: name == null ? "" : name,
                      onSaved: (value) => uname = value,
                      decoration: InputDecoration(
                          hintText: "Name",
                          labelText: "Name",
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                    TextFormField(
                      validator: (value) =>
                      value.isEmpty ? 'Please Enter the Seller Name' : null,
                      onSaved: (value) => ucontact = value,
                      initialValue: contact == null ? "" : contact,
                      decoration: InputDecoration(
                          hintText: "Contact Number",
                          labelText: "Contact Number",
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                    TextFormField(
                      validator: (value) =>
                      value.isEmpty ? 'Please Enter the Old Price' : null,
                      initialValue: address == null ? "" : address,
                      onSaved: (value) => uaddress = value,
                      decoration: InputDecoration(
                          hintText: "Address",
                          labelText: "Address",
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                MaterialButton(
                  onPressed: () {
                    if(_formKey.currentState.validate()){
                      _formKey.currentState.save();
                      validateandsubmit();
                    }
                  },
                  child: Text("Update"),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"),
                )
              ],
            ),
          );
        });
  }

}




