import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Service(),
      color: Colors.white,
    ));

class Service extends StatefulWidget {
  @override
  _ServiceState createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          "Our Service",
          style: TextStyle(fontFamily: 'Manzari-Bold', color: Colors.orange),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Text(
                "Z I V A",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.orange,
                    fontFamily: 'Manzari-Bold',
                    fontWeight: FontWeight.bold,
                    fontSize: 35.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Text(
                "Ziva app aims to provide best customer service and support, here you can buy all kind of stationary items.",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                "Contact us",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ),
            Divider(
              indent: 30.0,
              endIndent: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                "1800 988 988",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                "Locate us",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ),
            Divider(
              indent: 30.0,
              endIndent: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                "Ground floor,zynth empire,nr.xender street,volvo street,Ahmedabad,Gujarat-380015",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Divider(
              indent: 30.0,
              endIndent: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                "Ziva app is property of Akshar stationary",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                "All right reserved 2019",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15.0),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
