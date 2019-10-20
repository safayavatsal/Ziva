import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ziva/category.dart';
import 'package:ziva/main.dart';
import 'package:ziva/summary.dart';
import 'package:ziva/summarydetails.dart';

import 'CategoryPageDetails.dart';

List<CategoryPageDetails> alldata = [];
List<summary> senddata = [];
summary id,cname,pname,sname,oprice,nprice,image,desc;

void main() => runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange[600],
        fontFamily: 'Manjari',
      ),
      home: ProductDetails(null, null, null, null, null, null, null, null),
      color: Colors.white,
    ));

class ProductDetails extends StatefulWidget {

  CategoryPageDetails id, cname, pname, sname, oprice, nprice, image, desc;
  ProductDetails(this.id, this.cname, this.pname, this.sname, this.oprice,
      this.nprice, this.image, this.desc);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  
  getcart() async {
    bool result =false;
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DatabaseReference reference = await FirebaseDatabase.instance
        .reference()
        .child("Cart")
        .child(user.uid);
    reference.once().then((DataSnapshot snap){
      var keys = snap.value.keys;
      print(keys);
      for(var key in keys){
       /* if(key == widget.id.id){
          print("added to wish");
          result =true;

          Scaffold.of(context).showSnackBar(new SnackBar(content: Text("Item Already addded to cart")));
        }
        else{*/

      }
      print(result);
      return result;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.pname.pname,
            style: TextStyle(fontFamily: 'Manzari-Bold', color: Colors.orange)),
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: <Widget>[
            Container(
              height: 300.0,
              child: Image.network(widget.image.image),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            widget.pname.pname,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            widget.sname.sname,
                            style: TextStyle(fontSize: 18.0),
                          ),
                        )
                      ],
                    ),
                    subtitle: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                          child: Text(
                            "Rs." '${widget.nprice.nprice}',
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.orange),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                          child: Text(
                            "Rs." '${widget.oprice.oprice}',
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 5.0,
                left: 20.0,
                right: 20.0,
              ),
              child: FutureBuilder(
                future: FirebaseAuth.instance.currentUser(),
                builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot){
                  if(snapshot.hasData){
                    FirebaseUser user = snapshot.data;
                    return MaterialButton(
                      onPressed: addtocart,
                      height: 50.0,
                      child: Text(
                        "Add to cart",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      color: Colors.orangeAccent,
                    );
                  }
                  else{
                    return MaterialButton(
                      onPressed: (){
                        Fluttertoast.showToast(
                            msg: "Please Login",
                            gravity: ToastGravity.BOTTOM,
                            toastLength: Toast.LENGTH_LONG);
                      },
                      height: 50.0,
                      child: Text(
                        "Add to cart",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      color: Colors.orangeAccent,
                    );
                  }
                },
              )
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                left: 20.0,
                right: 20.0,
              ),
              child: FutureBuilder(
                future: FirebaseAuth.instance.currentUser(),
                builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot){
                  if(snapshot.hasData){
                    FirebaseUser user = snapshot.data;
                    return  MaterialButton(
                      onPressed: () {

                        Navigator.push(context, MaterialPageRoute(builder: (context) => SummaryDetails(
                            widget.id.id,
                            widget.cname.cname,
                            widget.pname.pname,
                            widget.sname.sname,
                            widget.oprice.oprice,
                            widget.nprice.nprice,
                            widget.image.image,
                            widget.desc.desc
                        )));

                      },
                      height: 50.0,
                      child: Text(
                        "Buy now",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      color: Colors.orangeAccent,
                    );
                  }
                  else{
                    return  MaterialButton(
                      onPressed: (){
                        Fluttertoast.showToast(
                            msg: "Please Login",
                            gravity: ToastGravity.BOTTOM,
                            toastLength: Toast.LENGTH_LONG);
                      },
                      height: 50.0,
                      child: Text(
                        "Buy now",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      color: Colors.orangeAccent,
                    );
                  }
                },
              ),
            ),
            FutureBuilder(
              future: FirebaseAuth.instance.currentUser(),
              builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot){
                if(snapshot.hasData){
                  FirebaseUser user = snapshot.data;
                  return FlatButton(
                      onPressed: addtowish,
                      child: Text("Add to wish")
                  );
                }
                else{
                  return FlatButton(
                      onPressed: (){
                        Fluttertoast.showToast(
                            msg: "Please Login",
                            gravity: ToastGravity.BOTTOM,
                            toastLength: Toast.LENGTH_LONG);
                      },
                      child: Text("Add to wish")
                  );
                }
              },
            ),
            Divider(
              indent: 150.0,
              endIndent: 150.0,
            ),
            Center(
              child: Text("Description"),
            ),
            Divider(
              indent: 150.0,
              endIndent: 150.0,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                widget.desc.desc,
                style: TextStyle(fontSize: 15.0),
              ),
            )
          ],
        ),
      ),
    );
  }


  void addtocart() async {
    String id = widget.id.id;
    String cname = widget.cname.cname;
    String productname = widget.pname.pname;
    String sellername = widget.sname.sname;
    String oldprice = widget.oprice.oprice;
    String newprice = widget.nprice.nprice;
    String image = widget.image.image;
    String description = widget.desc.desc;
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var data = {
      "id": id,
      "cname": cname,
      "pname": productname,
      "sname": sellername,
      "oprice": oldprice,
      "nprice": newprice,
      "image": image,
      "desc": description
    };
    print(data);
    reference.child("Cart").child(user.uid).child(id).set(data);
    Fluttertoast.showToast(
        msg: "Item Added to cart",
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG);
  }

  void addtowish() async {
    String id = widget.id.id;
    String cname = widget.cname.cname;
    String productname = widget.pname.pname;
    String sellername = widget.sname.sname;
    String oldprice = widget.oprice.oprice;
    String newprice = widget.nprice.nprice;
    String image = widget.image.image;
    String description = widget.desc.desc;
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var data = {
      "id": id,
      "cname": cname,
      "pname": productname,
      "sname": sellername,
      "oprice": oldprice,
      "nprice": newprice,
      "image": image,
      "desc": description
    };
    print(data);
    reference.child("Wish list").child(user.uid).child(id).set(data);
    Fluttertoast.showToast(
        msg: "Item Added to wishlist",
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG);
  }
}
