import 'package:flutter/material.dart';

import 'ProductDetails.dart';
void main() => runApp(MaterialApp(
  home: Products(),
  color: Colors.white,
));
class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var product_list = [
    {
      "name":"Stapler Small",
      "subtitle":"By Akshar Company",
      "image":"asset/stapler/stapler1.jpg",
      "old_price":"Rs.50",
      "new_price":"Rs.30",
      "desc":"This is an Stapler provide a best company and valuable product,it is very scalable and provide more efficiency",
    },
    {
      "name":"Stapler Medium",
      "subtitle":"By Mitesh Company",
      "image":"asset/stapler/stapler2.jpg",
      "old_price":"Rs.80",
      "new_price":"Rs.40",
      "desc":"This is an Stapler provide a best company and valuable product,it is very scalable and provide more efficiency",
    },
    {
      "name":"Stapler Large",
      "subtitle":"By Anand Company",
      "image":"asset/stapler/stapler3.jpg",
      "old_price":"Rs.80",
      "new_price":"Rs.60",
      "desc":"This is an Stapler provide a best company and valuable product,it is very scalable and provide more efficiency",
    },
    {
      "name":"Stapler Very Large",
      "subtitle":"By Viren Company",
      "image":"asset/stapler/stapler4.jpg",
      "old_price":"Rs.100",
      "new_price":"Rs.90",
      "desc":"This is an Stapler provide a best company and valuable product,it is very scalable and provide more efficiency",
    }
  ];
  
  
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
        itemBuilder: (BuildContext context,int index){
          return Single_product(product_list[index]['name'],
              product_list[index]['subtitle'], product_list[index]['image'], product_list[index]['old_price'],
              product_list[index]['new_price'], product_list[index]['desc']);
        });
  }
}

class Single_product extends StatelessWidget {
  var prod_name;
  var prod_subtitle;
  var prod_image;
  var prod_old;
  var prod_new;
  var prod_desc;
  
  Single_product(this.prod_name,this.prod_subtitle,this.prod_image,this.prod_old,this.prod_new,this.prod_desc);
  
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        child: Hero(tag: prod_subtitle, child: Material(
          child: InkWell(
            child: GridTile(
              footer: Container(
                color: Colors.white,
                child: ListTile(
                  title: Text(prod_name,style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Row(
                    children: <Widget>[
                      Text(prod_new,style: TextStyle(fontSize: 15.0,color: Colors.orange),),
                      Padding(
                        padding: const EdgeInsets.only(left:15.0),
                        child: Text(prod_old,style: TextStyle(decoration: TextDecoration.lineThrough),),
                      ),
                    ],
                  )
                ),
              ),
              child: Image.asset(prod_image,fit: BoxFit.fill,height: 300.0,),
            ),
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => ProductDetails(
              prod_name,prod_subtitle,prod_image,prod_old,prod_new,prod_desc
            ))),
          ),
        )),
      ),
    );
  }
}

