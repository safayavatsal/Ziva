import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    alldata.clear();
    getdata();
    super.initState();
  }

  getdata() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("Order");
    reference.orderByChild("userid").equalTo(user.uid).once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      print(data);
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
            data[key]["status"],
            data[key]["userid"],
            data[key]["orderid"]
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
            itemCount: alldata== null? 0 : alldata.length,
            itemBuilder: (_,int index){
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Card(
                      child: ListTile(
                        leading: Image.network(alldata[index].image,width: 60.0,),
                        title: Text(alldata[index].pname == null ? '' :alldata[index].pname),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: Text(alldata[index].sname == null ? '' :alldata[index].sname),
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
                                    child: Text(alldata[index].status == null ? '' :alldata[index].status,style: TextStyle(fontSize: 12.0),),
                                ),
                                FlatButton(
                                    onPressed: (){
                                      delete(alldata[index].orderid);
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

  void delete(String orderid) async{
    DatabaseReference databaseReference = await FirebaseDatabase.instance.reference().child("Order").child(orderid);

    setState(() {
      // Navigator.of(context).pop();
      databaseReference.remove();
      Fluttertoast.showToast(
          msg: "Order Deleted",
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG);
      alldata.clear();
      getdata();
    });
  }

}


