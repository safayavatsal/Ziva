import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'CategoryPageDetails.dart';
void main() => runApp(MaterialApp(
  home: Cart(),
  color: Colors.white,
));
List<CategoryPageDetails> alldata = [];

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
  }
  getdata() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("Cart")
        .child(user.uid);
    reference.once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      alldata.clear();
      for (var key in keys) {
        CategoryPageDetails d = CategoryPageDetails(
          data[key]["pname"],
          data[key]["sname"],
          data[key]["oprice"],
          data[key]["nprice"],
          data[key]["image"],
          data[key]["desc"],
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
        title: Text("My Cart",style: TextStyle(fontFamily: 'Manzari-Bold',color: Colors.orange),),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: alldata.length == 0? Center(child: Text("Loading..."),):
        ListView.builder(itemCount: alldata==null? 0 : alldata.length,
            itemBuilder: (_,int index){
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Card(
                      child: ListTile(
                        leading: Image.network(alldata[index].image,width: 60.0,),
                        title: Text(alldata[index].pname),
                        trailing: CircleAvatar(child: IconButton(icon: Icon(Icons.add_shopping_cart,color: Colors.orange,), onPressed: null),),
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
                            Row(
                              children: <Widget>[
                                Text("Qty:"),
                                Padding(
                                  padding: const EdgeInsets.only(left:8.0),
                                  child: CircleAvatar(maxRadius: 16.0,child: IconButton(icon: Icon(Icons.add,size: 16.0,), onPressed: null)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:8.0),
                                  child: Text("1"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:8.0),
                                  child: CircleAvatar(maxRadius: 16.0,child: IconButton(icon: Icon(Icons.remove,size: 16.0,), onPressed: null)),
                                ),
                              ],
                            ),
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
}


