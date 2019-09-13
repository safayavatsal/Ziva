import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ziva/category.dart';
import 'package:ziva/main.dart';
import 'package:ziva/profile.dart';
import 'package:ziva/service.dart';
import 'package:ziva/wishlist.dart';

import 'Products.dart';
import 'cart.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        fontFamily: 'Manjari',
      ),
      home: HomePage(),
      color: Colors.white,
    ));

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Home", Icons.home),
    new DrawerItem("Category", Icons.home),
    new DrawerItem("My Cart", Icons.home),
    new DrawerItem("My Order", Icons.home),
    new DrawerItem("My wish list", Icons.home),
    new DrawerItem("Profile", Icons.home),
    new DrawerItem("Customer Service", Icons.home),
    new DrawerItem("Logout", Icons.home),
  ];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void logout() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
  }

  @override
  Widget build(BuildContext context) {

    Widget carousel = new Container(
      height: 200.0,
      child: Carousel(
        boxFit: BoxFit.fill,
        images: [
          AssetImage('asset/bone.jpg'),
          AssetImage('asset/btwo.jpg'),
          AssetImage('asset/bthree.jpg'),
        ],
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(microseconds: 100),
        dotSize: 4.0,
        dotSpacing: 15.0,
        indicatorBgPadding: 4.0,
        dotPosition: DotPosition.bottomCenter,
      ),
    );
    return Scaffold(
      drawer: Drawer(
        elevation: 10.0,
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text(
                "Z I V A",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.orange,
                    fontFamily: 'Manzari-Bold',
                    fontSize: 35.0),
              ),
            ),
            Divider(),
            ListTile(
              selected: true,
              contentPadding: EdgeInsets.only(left: 40.0),
              title: Text(
                "Home",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              leading: CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Icon(
                    Icons.home,
                    color: Colors.white,
                  )),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Category()));
              },
              contentPadding: EdgeInsets.only(left: 40.0),
              title: Text(
                "Category",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              leading: CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Icon(
                    Icons.category,
                    color: Colors.white,
                  )),
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.only(left: 40.0),
              title: Text(
                "My Cart",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Cart()));
              },
              leading: CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  )),
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.only(left: 40.0),
              title: Text(
                "My Order",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              leading: CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Icon(
                    Icons.add_shopping_cart,
                    color: Colors.white,
                  )),
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.only(left: 40.0),
              title: Text(
                "My wish list",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Wishlist()));
              },
              leading: CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Icon(
                    Icons.favorite,
                    color: Colors.white,
                  )),
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.only(left: 40.0),
              title: Text(
                "Profile",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
              },
              leading: CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  )),
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.only(left: 40.0),
              title: Text(
                "Customer Service",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Service()));
              },
              leading: CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Icon(
                    Icons.question_answer,
                    color: Colors.white,
                  )),
            ),
            Divider(),
            ListTile(
              onTap: logout,
              contentPadding: EdgeInsets.only(left: 40.0),
              title: Text(
                "Logout",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              leading: CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Icon(
                    Icons.power_settings_new,
                    color: Colors.white,
                  )),
            ),
            Divider(),
          ],
        ),
      ),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.search,
                  size: 25.0,
                  color: Colors.orange,
                ),
              ),
              onPressed: null)
        ],
        backgroundColor: Colors.white,
        title: Text(
          "Z I V A",
          style: TextStyle(
              color: Colors.orange, fontFamily: 'Manzari-Bold', fontSize: 25.0),
        ),
      ),
      body: ListView(
        children: <Widget>[
          carousel,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                child: Products(),
              )
            ],
          )

        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          elevation: 10.0,
          tooltip: "Cart",
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Cart()));
          },
          backgroundColor: Colors.orange,
          child: Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
