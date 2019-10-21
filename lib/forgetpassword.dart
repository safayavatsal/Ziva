import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'main.dart';


void main() => runApp(ForgetPassword());
final FirebaseAuth _auth = FirebaseAuth.instance;

class ForgetPassword extends StatelessWidget {
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final _emailfocusnode = FocusNode();
  final TextEditingController _contactController = TextEditingController();
  final _contactfocusnode = FocusNode();

  void forgetpassword() async{
    ProgressDialog progressDialog = new ProgressDialog(context);
    progressDialog.show();
    await _auth.sendPasswordResetEmail(email: _emailController.text).catchError((e){
      progressDialog.dismiss();
      Fluttertoast.showToast(
          msg: "Email cannot be sent",
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG);
    });
    if (_auth != null) {
      setState(() {
        progressDialog.dismiss();
        Fluttertoast.showToast(
            msg: "Email has been Sended",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyHomePage()));
      });
    } else {
      print("failed");
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Z I V A',
              style: TextStyle(
                  fontFamily: 'Manjari-Bold',
                  fontSize: 50.0,
                  color: Colors.orange),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                style: TextStyle(
                    color: Colors.white, decorationColor: Colors.white),
                controller: _emailController,
                focusNode: _emailfocusnode,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                //onSaved: (value) => email = value,
                onFieldSubmitted: (value) {
                  _emailfocusnode.unfocus();
                  FocusScope.of(context).requestFocus(_contactfocusnode);
                },
                validator: (value) =>
                value.isEmpty ? 'Please Enter the Email' : null,
                decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                style: TextStyle(
                    color: Colors.white, decorationColor: Colors.white),
                obscureText: true,
                keyboardType: TextInputType.text,
                controller: _contactController,
                focusNode: _contactfocusnode,
                //onSaved: (value) => password = value,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) {
                  _contactfocusnode.unfocus();
                },
                validator: (value) =>
                value.isEmpty ? 'Please Enter the Password' : null,
                decoration: InputDecoration(
                    hintText: "Contact Number",
                    hintStyle: TextStyle(color: Colors.white)),
              ),
            ),
            MaterialButton(
              minWidth: 20.0,
              onPressed: forgetpassword,
              child: Text(
                "Reset Password",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
