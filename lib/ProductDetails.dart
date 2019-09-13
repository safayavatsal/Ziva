import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CategoryPageDetails.dart';

void main() => runApp(MaterialApp(
  title: 'Flutter Demo',
  theme: ThemeData(
      primarySwatch: Colors.deepOrange[600],
      fontFamily: 'Manjari',
  ),
  home: ProductDetails(null,null,null,null,null,null),
  color: Colors.white,
));

class ProductDetails extends StatefulWidget {
  CategoryPageDetails pname,sname,oprice,nprice,image,desc;
  ProductDetails(this.pname,this.sname,this.oprice,this.nprice,this.image,this.desc);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.pname.pname,
            style: TextStyle(fontFamily: 'Manzari-Bold', color: Colors.orange)),
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: <Widget>[
            Container(
              height: 300.0,
              child: Image.network(widget.image.image),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            widget.pname.pname,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            widget.sname.sname,
                            style: TextStyle(fontSize: 18.0),
                          ),
                        )
                      ],
                    ),
                    subtitle: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                          child: Text(
                            "Rs."'${widget.nprice.nprice}',
                            style:
                            TextStyle(fontSize: 20.0, color: Colors.orange),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                          child: Text(
                            "Rs."'${widget.nprice.oprice}',
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            MaterialButton(
              onPressed: (){},
              height: 50.0,
              child: Text(
                "Add to cart",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}
