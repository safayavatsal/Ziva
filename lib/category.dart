import 'package:flutter/material.dart';
void main() => runApp(MaterialApp(
  home: Category(),
  color: Colors.white,
));
class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories",
        style: TextStyle(fontFamily: 'Manzari-Bold',color: Colors.orange)),
        backgroundColor: Colors.white,
        leading: Icon(Icons.category,color: Colors.orange,),
      ),
      body: Center(
        child: Text("Mitesh Vaghela"),
      ),
    );
  }
}

