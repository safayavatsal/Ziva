import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'CategoryPageDetails.dart';
import 'ProductDetails.dart';
void main() => runApp(MaterialApp(
  home: Products(),
  color: Colors.white,
));
List<CategoryPageDetails> alldata = [];

class Products extends StatefulWidget {

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {

  getdata(){
    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("Category");
    reference.once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      alldata.clear();
      for (var key in keys) {
        CategoryPageDetails d = CategoryPageDetails(
            data[key]['id'],
            data[key]['cname'],
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
            data[key]["orderid"],
        );
        alldata.add(d);
      }
      setState(() {
        print(alldata.length);
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Divider(
                indent: 150.0,
                endIndent: 150.0,
              ),
              Text("All Products"),
              Divider(
                indent: 150.0,
                endIndent: 150.0,
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                child: GridView.builder(
                    itemCount: alldata == null ? 0 : alldata.length,
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Card(
                          child: Hero(
                              tag: '$index',
                              child: Material(
                                child: InkWell(
                                  child: GridTile(
                                    footer: Container(
                                      color: Colors.white,
                                      child: ListTile(
                                          title: Text(
                                            alldata[index].pname,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Row(
                                            children: <Widget>[
                                              Text("Rs."'${alldata[index].nprice}',
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.orange),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0),
                                                child: Text(
                                                  "Rs."'${alldata[index].oprice}',
                                                  style: TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                    child: Image.network(
                                      alldata[index].image,
                                      fit: BoxFit.fill,
                                      height: 300.0,
                                    ),
                                  ),
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
                                                alldata[index],
                                              ))),
                                ),
                              )),
                        ),
                      );
                    }),
              )
            ],
          )
        ],
      ),
    );
  }
}
