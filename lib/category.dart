import 'dart:async';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'CategoryDetails.dart';
import 'Categoryname.dart';
void main() => runApp(MaterialApp(
  home: Category(),
  color: Colors.white,
));
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
TextEditingController add = new TextEditingController();
String CategoryName;
Future<String> string;
List<Categoryname> alldata = [];
Categoryname categoryname;


class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}
class _CategoryState extends State<Category> {


  getdata(){
    DatabaseReference reference =  FirebaseDatabase.instance.reference().child("CategoryItems");
    reference.once().then((DataSnapshot snap){
      var keys = snap.value.keys;
      var data = snap.value;
      alldata.clear();
      for(var key in keys) {
        Categoryname d = Categoryname(data[key]["Categoryname"],data[key]["id"]);
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
        title: Text("Categories",
            style: TextStyle(fontFamily: 'Manzari-Bold', color: Colors.orange)),
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: alldata.length == 0? Center(child: Text("Loading..."),):
        ListView.builder(itemCount: alldata==null? 0 : alldata.length,
            itemBuilder: (_,int index){
               return ListTile(
                 title: Padding(
                   padding: const EdgeInsets.only(top: 15.0),
                   child: Text(alldata[index].name,style: TextStyle(fontSize: 20.0),),
                 ),
                 contentPadding: EdgeInsets.only(left: 60.0),
                 subtitle: Divider(),
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryDetails(alldata[index])));
                 },
               );
            }
        ),
      ),
    );
  }
}