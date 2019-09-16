import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'CategoryPageDetails.dart';
void main() => runApp(Order());
List<CategoryPageDetails> alldata = [];

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
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
        .child("Order")
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
        title: Text("My Orders",style: TextStyle(fontFamily: 'Manzari-Bold',color: Colors.orange),),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: alldata.length == 0? Center(child: Text("No Orders"),):
        ListView.builder(
            itemCount: alldata== -1? 0 : alldata.length,
            itemBuilder: (_,int index){
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Card(
                      child: ListTile(
                        leading: Image.network(alldata[index].image,width: 60.0,),
                        title: Text(alldata[index].pname),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: Text(alldata[index].sname),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: Text("Price:"'${alldata[index].price}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text("Qty:"'${alldata[index].quantity}',style: TextStyle(fontSize: 12.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text("Total Price:"'${alldata[index].total}',style: TextStyle(fontSize: 12.0),),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(alldata[index].status,style: TextStyle(fontSize: 12.0),),
                                ),
                                FlatButton(
                                    onPressed: (){
                                      delete(alldata[index].id);
                                    },
                                    child: Text("Cancel Order"))
                              ],
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
        .child("Order")
        .child(user.uid).child(id);
    setState(() {
      // Navigator.of(context).pop();
      databaseReference.remove();
      alldata.clear();
      getdata();
    });
  }
}


