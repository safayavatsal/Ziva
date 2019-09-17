import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ziva/summary.dart';
import 'package:ziva/summarydetails.dart';

import 'CategoryPageDetails.dart';
import 'ProductDetails.dart';
import 'cart.dart';
void main() => runApp(MaterialApp(
  home: Wishlist(),
  color: Colors.white,
));
List<CategoryPageDetails> alldata = [];

class Wishlist extends StatefulWidget {
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {

  @override
  void initState() {
    // TODO: implement initState
    alldata.clear();
    getdata();
    super.initState();
  }
getdata() async{
  FirebaseUser user = await FirebaseAuth.instance.currentUser();

  DatabaseReference reference = FirebaseDatabase.instance
      .reference()
      .child("Wish list")
      .child(user.uid);
  reference.once().then((DataSnapshot snap) {
    var keys = snap.value.keys;
    var data = snap.value;
    alldata.clear();
    for (var key in keys) {
      CategoryPageDetails d = CategoryPageDetails(
        data[key]["id"],
        data[key]["cname"],
        data[key]["pname"],
        data[key]["sname"],
        data[key]["oprice"],
        data[key]["nprice"],
        data[key]["image"],
        data[key]["desc"],
          data[key]["price"],
          data[key]["total"],
          data[key]["quantity"],
          data[key]["status"]
      );
      alldata.add(d);
    }
    setState(() {
      print(alldata.length);
    });
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Wish list",style: TextStyle(fontFamily: 'Manzari-Bold',color: Colors.orange),),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: alldata.length == 0? Center(child: Text("No items to Wish list"),):
        ListView.builder(itemCount: alldata==null? 0 : alldata.length,
            itemBuilder: (_,int index){
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Card(
                      child: ListTile(
                        onTap: () => Navigator.of(context).push(
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ProductDetails(
                                      alldata[index],
                                      alldata[index],
                                      alldata[index],
                                      alldata[index],
                                      alldata[index],
                                      alldata[index],
                                      alldata[index],
                                      alldata[index]             ,

                                    ))),
                        leading: Image.network(alldata[index].image,width: 60.0,),
                        title: Text(alldata[index].pname),
                        trailing: CircleAvatar(
                          backgroundColor: Colors.orange,
                          child: IconButton(icon: Icon(Icons.remove,color: Colors.white,),onPressed: (){
                            delete(alldata[index].id);
                          },),
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: Text(alldata[index].sname),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top:8.0),
                                  child: Text("Rs."'${alldata[index].nprice}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:8.0,top: 8.0),
                                  child: Text("Rs."'${alldata[index].oprice}',style: TextStyle(decoration: TextDecoration.lineThrough),),
                                ),
                              ],
                            ),
                            FlatButton(
                              onPressed: (){movetocart(alldata[index].id,
                                alldata[index].cname,
                                alldata[index].pname,
                                alldata[index].sname,
                                alldata[index].oprice,
                                alldata[index].nprice,
                                alldata[index].image,
                                alldata[index].desc,);},
                              child: Text("Move to cart"),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
        ),
      ),
    );
  }

  void delete(String id) async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DatabaseReference databaseReference = await FirebaseDatabase.instance
        .reference()
        .child("Wish list")
        .child(user.uid).child(id);
    setState(() {
      // Navigator.of(context).pop();
      databaseReference.remove();
      alldata.clear();
      getdata();
    });
  }

  void movetocart(String id, String cname, String pname, String sname, String oprice, String nprice, String image, String desc) async {
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var data = {
      "id": id,
      "cname": cname,
      "pname": pname,
      "sname": sname,
      "oprice": oprice,
      "nprice": nprice,
      "image": image,
      "desc": desc
    };
    print(data);
    reference.child("Cart").child(user.uid).child(id).set(data);
    delete(id);
  }
}
