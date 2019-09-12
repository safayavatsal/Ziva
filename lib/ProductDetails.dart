import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange[600],
        fontFamily: 'Manjari',
        buttonColor: Colors.orange
      ),
      home: ProductDetails(1, 2, 3, 4, 5, 6),
      color: Colors.white,
    ));

class ProductDetails extends StatefulWidget {
  var prod_detail_name;
  var prod_detail_subtitle;
  var prod_detail_image;
  var prod_detail_oldprice;
  var prod_detail_newprice;
  var prod_detail_desc;
  ProductDetails(
      this.prod_detail_name,
      this.prod_detail_subtitle,
      this.prod_detail_image,
      this.prod_detail_oldprice,
      this.prod_detail_newprice,
      this.prod_detail_desc);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.prod_detail_name,
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
              child: Image.asset(widget.prod_detail_image),
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
                            widget.prod_detail_name,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            widget.prod_detail_subtitle,
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
                            widget.prod_detail_newprice,
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.orange),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                          child: Text(
                            widget.prod_detail_oldprice,
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
            RaisedButton(
              onPressed: null,
              child: Text(
                "Add to cart",
                style: TextStyle(color: Colors.orange),
              ),
              color: Theme.of(context).accentColor,
              highlightColor: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}
