import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:ziva/forgetpassword.dart';
import 'package:ziva/homepage.dart';
import 'package:ziva/register.dart';

void main() => runApp(MyApp());
final FirebaseAuth _auth = FirebaseAuth.instance;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,fontFamily: 'Manjari',
        ),
        home: FutureBuilder(
          future: FirebaseAuth.instance.currentUser(),
          builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot){
            if(snapshot.hasData){
              FirebaseUser user = snapshot.data;
              return HomePage();
            }
            else{
              return HomePage();
            }
          },
        )
    );
  }
}
class Loginpage extends StatefulWidget {
  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _emailfocusnode = FocusNode();
  final _passwordfocusnode = FocusNode();

  @override
  Widget build(BuildContext context) {

    void movetoscreen(){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Registerpage()));
    }
    void movetoforget(){
      Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPassword()));
    }
    void movetohome(){
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
    }
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: Colors.black87,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Z I V A',style: TextStyle(
                    fontFamily: 'Manjari-Bold',fontSize: 50.0,color: Colors.orange
                ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    style: TextStyle(
                        color: Colors.white,decorationColor: Colors.white
                    ),
                    controller: _emailController,
                    focusNode: _emailfocusnode,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    //onSaved: (value) => email = value,
                    onFieldSubmitted: (value) {_emailfocusnode.unfocus();
                    FocusScope.of(context).requestFocus(_passwordfocusnode);},
                    validator: (value) => value.isEmpty ? 'Please Enter the Email' : null,
                    decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(
                          color: Colors.white,
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    style: TextStyle(
                        color: Colors.white,decorationColor: Colors.white
                    ),
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    controller: _passwordController,
                    focusNode: _passwordfocusnode,
                    //onSaved: (value) => password = value,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) {_passwordfocusnode.unfocus();},
                    validator: (value) => value.isEmpty ? 'Please Enter the Password' : null,
                    decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(
                            color: Colors.white
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric( vertical: 20.0,horizontal: 60.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            _signInWithEmailAndPassword();
                          }
                        },
                        child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 18.0),),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color: Colors.grey
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: FlatButton(
                      child: Text("Forget Password?",style: TextStyle(
                          fontSize: 20.0,color: Colors.white
                      ),),
                      onPressed: movetoforget
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _signInWithEmailAndPassword() async {
    ProgressDialog progressDialog = new ProgressDialog(context);
    progressDialog.show();
    final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ).catchError((e){
      progressDialog.dismiss();
      Fluttertoast.showToast(
          msg: "Login Failed",
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG);
    })) . user;
    if (user != null) {
      setState(() {
        progressDialog.dismiss();
        Fluttertoast.showToast(
            msg: "Login Successful",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG);
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
      });
    } else {
      print("failed");
    }
  }
}