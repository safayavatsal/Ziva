import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ziva/order.dart';
import 'CategoryPageDetails.dart';
import 'package:mailer2/mailer.dart';
List<CategoryPageDetails> alldata = [];
Key key;

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'Flutter Demo',
  theme: ThemeData(
    primarySwatch: Colors.grey,
    fontFamily: 'Manjari',
  ),
  home: SummaryDetails(null,null,null,null,null,null,null,null),
  color: Colors.white,
));

class SummaryDetails extends StatefulWidget {
  String id,cname,pname,sname,oprice,nprice,image,desc;
  SummaryDetails(this.id,this.cname,this.pname,this.sname,this.oprice,this.nprice,this.image,this.desc);
  @override
  _SummaryDetailsState createState() => _SummaryDetailsState();
}

class _SummaryDetailsState extends State<SummaryDetails> {

  String email,contact,address,name;
  @override
  void initState() {
    accessdata();
    // TODO: implement initState
    super.initState();
  }
  void accessdata() async {
    // TODO: implement initState
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    try {
      reference..child(
          "Users").child(user.uid).once().then((DataSnapshot snap) {
        setState(() {
          var data = snap.value;
          email =data['email'];
          contact = data['phone'];
          name = data['name'];
          address = data['address'];
        });
      });
    }

    catch (e) {}
  }
  int text = 1;
  int charges = 50;
  int price;
  int total;
  @override
  Widget build(BuildContext context) {

    void increment(){
      setState(() {
        text = text + 1;

      });
    }
    void decrement(){
      setState(() {
        if(text <= 1){
          text =1;
        }
        else{
          text = text -1;
        }

      });
    }
    void order() async {
      String id = widget.id;
      String cname = widget.cname;
      String productname = widget.pname;
      String sellername = widget.sname;
      String oldprice = widget.oprice;
      String newprice = widget.nprice;
      String image = widget.image;
      String description = widget.desc;
      int qty = text;
      int pprice = price;
      int ptotal = total;
      String username = name;
      String useremail = email;
      String usercontact = contact;
      String useraddress =address;
      DatabaseReference reference = FirebaseDatabase.instance.reference();
      String id1 = reference.push().key;
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      var data = {
        "id": id,
        "cname": cname,
        "pname": productname,
        "sname": sellername,
        "oprice": oldprice,
        "nprice": newprice,
        "image": image,
        "desc": description,
        "quantity":qty,
        "price": pprice,
        "total":ptotal,
        "name":username,
        "email":useremail,
        "contact": usercontact,
        "address":useraddress,
        "userid": user.uid,
        "orderid":id1
      };
      print(data);
      reference.child("Order").child(id1).set(data);
      Fluttertoast.showToast(
          msg: "Your Order is Confirmed",
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG);
      var options = new GmailSmtpOptions()
        ..username = 'ktrajkot@gmail.com'
        ..password = 'Mohammad@7752';
      var transport = new SmtpTransport(options);

      // Create the envelope to send.
      var envelope = new Envelope()
        ..from = 'ktrajkot@gmail.com'
        ..fromName = 'Ziva'
        ..recipients = ['${useremail}']
        ..subject = 'Your Order'
        ..text = 'Order id: '+id1 +'\nProduct: '+productname + '\nSeller Name :' +sellername +'\nPrice :' +price.toString() +'\nQty :' +qty.toString() + '\nTotal Price :' +ptotal.toString() + '\nImage :' +image;

      // Finally, send it!
      transport.send(envelope)
          .then((_) => print('email sent!'))
          .catchError((e) => print('Error: $e'));
    }

    return Scaffold(
        resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Order Page",
          style: TextStyle(
              color: Colors.orange, fontFamily: 'Manzari-Bold', fontSize: 25.0),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Card(
                child: ListTile(
                  leading: Image.network(widget.image,width: 60.0,),
                  title: Text(widget.pname),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Text(widget.sname),
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: Text("Rs."'${price=int.parse(widget.nprice) * text}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:8.0,top: 8.0),
                            child: Text("Rs."'${widget.oprice}',style: TextStyle(decoration: TextDecoration.lineThrough),),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Row(
                          children: <Widget>[
                            Text("Qty:"),
                            Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: CircleAvatar(maxRadius: 16.0,child: IconButton(icon: Icon(Icons.add,size: 16.0,), onPressed: increment)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: Text('${text}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: CircleAvatar(maxRadius: 16.0,child: IconButton(icon: Icon(Icons.remove,size: 16.0,), onPressed: decrement)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:15.0,left: 20.0,),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left:10.0),
                            child: Text("Name",style: TextStyle(decoration: TextDecoration.underline,fontSize: 20.0),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:15.0),
                            child: Text(name != null? name: '',style: TextStyle(fontSize: 17.0),),
                          ),

                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left:10.0,top: 10.0),
                            child: Text("Email",style: TextStyle(decoration: TextDecoration.underline,fontSize: 20.0),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:15.0),
                            child: Text(email != null? email: '',style: TextStyle(fontSize: 17.0),),
                          ),

                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left:10.0,top: 10.0),
                            child: Text("Contact",style: TextStyle(decoration: TextDecoration.underline,fontSize: 20.0),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:15.0),
                            child: Text(contact != null? contact: '',style: TextStyle(fontSize: 17.0),),
                          ),

                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left:10.0,top: 10.0),
                            child: Text("Address",style: TextStyle(decoration: TextDecoration.underline,fontSize: 20.0),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:15.0),
                            child: Text(address != null? address: '',style: TextStyle(fontSize: 17.0),),
                          ),

                        ],
                      ),

                    ],
                  ),
              )
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 150.0,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Subtotal : "'${price=int.parse(widget.nprice) * text}',style: TextStyle(fontSize: 18.0),),
              Text("Delievery Charges : "'${charges}',style: TextStyle(fontSize: 18.0),),
              Text("Total : "'${total = price + charges}',style: TextStyle(fontSize: 18.0),),
              Padding(
                padding: const EdgeInsets.only(left:70.0,right: 70.0,),
                child: MaterialButton(
                  height: 50.0,
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: (){
                    setState(() {
                      if(text < 10){
                        order();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Order()));
                      }
                      else{

                      }
                    });

                  },
                  color: Colors.orange,
                  child: Text(
                    text >= 10 ? "Get Quatation" : "Confirm Order",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      )
    );
  }
}
