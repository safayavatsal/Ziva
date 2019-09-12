import 'package:flutter/material.dart';

import 'cart.dart';
void main() => runApp(MaterialApp(
  home: Wishlist(),
  color: Colors.white,
));

class Wishlist extends StatefulWidget {
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
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
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Card(
                child: ListTile(
                  leading: Image.asset('asset/bone.jpg',),
                  title: Text("Pen"),
                  trailing: CircleAvatar(child: IconButton(icon: Icon(Icons.add_shopping_cart,color: Colors.orange,), onPressed: null),),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Text("By Akshar Group Company"),
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: Text("Rs.50"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:8.0,top: 8.0),
                            child: Text("Rs.30",style: TextStyle(decoration: TextDecoration.lineThrough),),
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
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Card(
                child: ListTile(
                  leading: Image.asset('asset/bone.jpg',),
                  trailing: CircleAvatar(child: IconButton(icon: Icon(Icons.add_shopping_cart,color: Colors.orange,), onPressed: null,tooltip: "Add to Cart",),),
                  title: Text("Pen"),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Text("By Akshar Group Company"),
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: Text("Rs.50"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:8.0,top: 8.0),
                            child: Text("Rs.30",style: TextStyle(decoration: TextDecoration.lineThrough),),
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
        ),
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