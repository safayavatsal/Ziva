import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CategoryPageDetails.dart';

List<CategoryPageDetails> alldata = [];

void main() => runApp(MaterialApp(
  title: 'Flutter Demo',
  theme: ThemeData(
      primarySwatch: Colors.deepOrange[600],
      fontFamily: 'Manjari',
  ),
  home: ProductDetails(null,null,null,null,null,null),
  color: Colors.white,
));

class ProductDetails extends StatefulWidget {

  CategoryPageDetails pname,sname,oprice,nprice,image,desc;
  ProductDetails(this.pname,this.sname,this.oprice,this.nprice,this.image,this.desc);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            "Rs."'${widget.nprice.nprice}',
                            style:
                            TextStyle(fontSize: 20.0, color: Colors.orange),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                          child: Text(
                            "Rs."'${widget.oprice.oprice}',
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
              padding: const EdgeInsets.only(top:5.0,left: 20.0,right: 20.0,),
              child: MaterialButton(
                onPressed: addtocart,
                height: 50.0,
                child: Text(
                  "Add to cart",
                  style: TextStyle(color: Colors.white,fontSize: 20.0),
                ),
                color: Colors.orangeAccent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0,left: 20.0,right: 20.0,),
              child: MaterialButton(
                onPressed: (){},
                height: 50.0,
                child: Text(
                  "Buy now",
                  style: TextStyle(color: Colors.white,fontSize: 20.0),
                ),
                color: Colors.orangeAccent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: FlatButton(
                onPressed: addtowish,
                color: Colors.white,
                child: Text("Add to wish list",style: TextStyle(color: Colors.orange,fontSize: 15.0),),
              ),
            ),
            Divider(
              indent: 150.0,
              endIndent: 150.0,
            ),
            Center(child:Text("Description"),),
            Divider(
              indent: 150.0,
              endIndent: 150.0,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(widget.desc.desc,style: TextStyle(fontSize: 15.0),),
            )
          ],
        ),
      ),
    );
  }
  void addtocart() async{
    String productname = widget.pname.pname;
    String sellername = widget.sname.sname;
    String oldprice = widget.oprice.oprice;
    String newprice = widget.nprice.nprice;
    String image =widget.image.image;
    String description =widget.desc.desc;
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var data = {
      "pname": productname,
      "sname": sellername,
      "oprice": oldprice,
      "nprice":newprice,
      "image": image,
      "desc":description
    };
    print(data);
    reference.child("Cart").child(user.uid).push().set(data);
  }
  void addtowish() async{
    String productname = widget.pname.pname;
    String sellername = widget.sname.sname;
    String oldprice = widget.oprice.oprice;
    String newprice = widget.nprice.nprice;
    String image =widget.image.image;
    String description =widget.desc.desc;
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var data = {
      "pname": productname,
      "sname": sellername,
      "oprice": oldprice,
      "nprice":newprice,
      "image": image,
      "desc":description
    };
    print(data);
    reference.child("Wish list").child(user.uid).push().set(data);
  }
}
