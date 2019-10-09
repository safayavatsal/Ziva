import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'CategoryPageDetails.dart';
import 'Categoryname.dart';
import 'ProductDetails.dart';

List<CategoryPageDetails> alldata = [];

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        fontFamily: 'Manjari',
      ),
      home: CategoryDetails(null),
      color: Colors.white,
    ));

class CategoryDetails extends StatefulWidget {
  Categoryname categoryname;
  CategoryDetails(this.categoryname);

  @override
  _CategoryDetailsState createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {


  getdata(){
    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("Category");
    reference.orderByChild("cname").equalTo(widget.categoryname.name).once().then((DataSnapshot snap) {
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
  void initState() {
    // TODO: implement initState
    getdata();
    alldata.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.categoryname.name,
          style: TextStyle(
              color: Colors.orange, fontFamily: 'Manzari-Bold', fontSize: 25.0),
        ),
      ),
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
              Text(widget.categoryname.name),
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
                                              Text(
                                                "Rs."'${alldata[index].nprice}',
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
