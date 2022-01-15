import 'package:com_csith_geniuzpos/resources/fnccal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//final f_decimal = new NumberFormat("#,###.00##", "en_US");

class ProductLocalBox extends StatelessWidget {
  ProductLocalBox(
      {Key key,
      this.location,
      this.description,
      this.realstock,
      this.realamout,
      this.image})
      : super(key: key);
  final String location;
  final String description;
  final String realstock;
  final String realamout;
  final String image;

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      height: 60,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
                child: Container(
              padding: EdgeInsets.all(1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    width: 100,
                    child: Text(this.location,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(this.description,
                        style: TextStyle(fontWeight: FontWeight.normal)),
                  ),
                  SizedBox(
                    width: 130,
                    child: Text(this.realstock,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class OnhandLocalBox extends StatelessWidget {
  OnhandLocalBox(
      {Key key,
      this.location,
      this.description,
      this.realstock,
      this.realamout,
      this.image})
      : super(key: key);
  final String location;
  final String description;
  final double realstock;
  final double realamout;
  final String image;

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      height: 60,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
                child: Container(
              padding: EdgeInsets.all(1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    width: 100,
                    child: Text(this.location,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(this.description,
                        style: TextStyle(fontWeight: FontWeight.normal)),
                  ),
                  SizedBox(
                    width: 90,
                    child: Text(df.format(this.realstock),
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
