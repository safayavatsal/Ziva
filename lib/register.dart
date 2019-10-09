import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'Homepage.dart';

void main() => runApp(Registerpage());
final FirebaseAuth _auth = FirebaseAuth.instance;
String email, name, address, contact;

class Registerpage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        fontFamily: 'Manjari',
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<FormState> formkey = new GlobalKey<FormState>();

  final emailcontrol = TextEditingController();
  final namecontrol = TextEditingController();
  final passwordcontrol = TextEditingController();
  final contactcontrol = TextEditingController();
  final addresscontrol = TextEditingController();
  final emailfocus = FocusNode();
  final passwordfocus = FocusNode();
  final namefocus = FocusNode();
  final contactfocus = FocusNode();
  final addressfocus = FocusNode();



  bool validateandsave() {
    final formstate = formkey.currentState;
    if (formstate.validate()) {
      formstate.save();
      validateandsubmit();


      return true;
    }
    return false;
  }
  // ignore: missing_return
  void validateandsubmit() async {
    ProgressDialog progressDialog = new ProgressDialog(context);
    progressDialog.show();
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: emailcontrol.text,
      password: passwordcontrol.text,
    ).catchError((e){
      progressDialog.dismiss();
      Fluttertoast.showToast(
      msg: "Registration Failed",
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG);
    })) . user;

    DatabaseReference database = FirebaseDatabase.instance.reference();
    var data = {
      "email": email,
      "name": name,
      "phone": contact,
      "address":address
    };
    database.child("Users").child(user.uid).set(data);
    if (user != null) {
      setState(() {
        progressDialog.dismiss();
        Fluttertoast.showToast(
            msg: "Registration Successful",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG);
        debugPrint(email);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
      });
    } else {
      debugPrint("Error");

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: Colors.black87,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: formkey,
          autovalidate: true,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Z I V A',
                    style: TextStyle(
                        fontFamily: 'Manjari-Bold',
                        fontSize: 50.0,
                        color: Colors.orange),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      style: TextStyle(
                          color: Colors.white,decorationColor: Colors.white
                      ),
                      keyboardType: TextInputType.text,
                      controller: namecontrol,
                      onSaved: (value) => name = value,
                      textInputAction: TextInputAction.next,
                      validator: (value) => value.isEmpty ? 'Please Enter the Name' : null,
                      onFieldSubmitted: (value){namefocus.unfocus();
                      FocusScope.of(context).requestFocus(contactfocus);},
                      decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: TextStyle(
                              color: Colors.white
                          )
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      style: TextStyle(
                          color: Colors.white,decorationColor: Colors.white
                      ),
                      keyboardType: TextInputType.number,
                      controller: contactcontrol,
                      textInputAction: TextInputAction.next,
                      focusNode: contactfocus,
                      onSaved: (value) => contact = value,
                      validator: (value) => value.isEmpty ? 'Please Enter Contact No' : null,
                      onFieldSubmitted: (value){
                        contactfocus.unfocus();
                        FocusScope.of(context).requestFocus(emailfocus);
                      },
                      decoration: InputDecoration(
                          hintText: "Contact Number",
                          hintStyle: TextStyle(
                              color: Colors.white
                          )
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      style: TextStyle(
                          color: Colors.white,decorationColor: Colors.white
                      ),
                      controller: emailcontrol,
                      onSaved: (value) => email = value,
                      textInputAction: TextInputAction.next,
                      focusNode: emailfocus,
                      validator: (value) => value.isEmpty ? 'Please Enter the email' : null,
                      onFieldSubmitted: (value){
                        emailfocus.unfocus();
                        FocusScope.of(context).requestFocus(passwordfocus);
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "Email Id",
                          hintStyle: TextStyle(
                              color: Colors.white
                          )
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      style: TextStyle(
                          color: Colors.white,decorationColor: Colors.white
                      ),
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      controller: passwordcontrol,
                      focusNode: passwordfocus,
                      validator: (value) => value.isEmpty ? 'Please Enter the Password' : null,
                      onFieldSubmitted: (value){
                        passwordfocus.unfocus();
                        FocusScope.of(context).requestFocus(addressfocus);
                      },
                      decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(
                              color: Colors.white
                          )
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      style: TextStyle(
                          color: Colors.white,decorationColor: Colors.white
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      controller: addresscontrol,
                      focusNode: addressfocus,
                      onSaved: (value) => address = value,
                      validator: (value) => value.isEmpty ? 'Please Enter the address' : null,
                      onFieldSubmitted: (value){
                        addressfocus.unfocus();
                      },
                      decoration: InputDecoration(
                          hintText: "Address",
                          hintStyle: TextStyle(
                              color: Colors.white
                          )
                      ),
                    ),
                  ),
                  MaterialButton(
                    minWidth: 20.0,
                    onPressed: validateandsave,
                    child: Text("Register",style: TextStyle(color: Colors.white,fontSize: 18.0),),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: Colors.grey
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'OR',
                      style: TextStyle(
                          fontFamily: 'Manjari-Bold',
                          fontSize: 20.0,
                          color: Colors.white),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric( vertical: 0.0,horizontal: 60.0),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: <Widget>[
                  //       MaterialButton(
                  //         onPressed: () async {
                  //           if (formkey.currentState.validate()) {
                  //           }
                  //         },
                  //         child: Text("Google",style: TextStyle(color: Colors.white,fontSize: 18.0),),
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(5.0),
                  //           side: BorderSide(color: Colors.grey
                  //           ),
                  //         ),
                  //       ),
                  //       MaterialButton(
                  //         minWidth: 20.0,
                  //         //  onPressed: movetoscreen,
                  //         child: Text("Facebook",style: TextStyle(color: Colors.white,fontSize: 18.0),),
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(5.0),
                  //           side: BorderSide(color: Colors.grey
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


