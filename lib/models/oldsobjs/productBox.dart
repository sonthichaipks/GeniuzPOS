import 'package:com_csith_geniuzpos/resources/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

// ignore: non_constant_identifier_names
final f_decimal = new NumberFormat(" #,###.00##", "en_US");
//final FrmMain main = new FrmMain();

// ignore: must_be_immutable
class ProductBox extends StatelessWidget {
  ProductBox(
      {Key key,
      this.plu,
      this.description,
      this.itemcode,
      this.groupcode, // product Group,
      this.groupname, // group name,
      this.unit,
      this.showdecimal, // decimal to show out,
      this.price,
      this.realstock,
      this.realamout,
      this.image})
      : super(key: key);
  final String plu;
  final String description;
  final String itemcode;
  final String groupcode;
  final String groupname;
  final String unit;
  final int showdecimal;
  final double price;
  final double realstock;
  final double realamout;
  final String image;
  var txt = TextEditingController();

  // ignore: non_constant_identifier_names
  Widget PluForm(String _name, String _code, var context) {
    txt.text = _name;
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: TextField(
        // controller: txt,
        autofocus: true,
        enableInteractiveSelection: false,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        // // onChanged: (value) => _name = value.trim(),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.add_business_rounded,
            color: CsiStyle().darkColor,
          ),
          labelStyle: TextStyle(color: CsiStyle().darkColor),
          labelText: 'Item: ' + _code + ', Plu: ',
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: CsiStyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: CsiStyle().primaryColor)),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      child: Center(
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          shrinkWrap: true,
          children: <Widget>[
            Image.asset(
              'images/' + image,
              height:
                  (MediaQuery.of(context).orientation == Orientation.portrait)
                      ? 100
                      : ((kIsWeb) ? 100 : 0),
              width: 100,
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  PluForm(this.plu, this.itemcode, context),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 10, 3, 0),
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Text(this.description,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0)),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              (this.itemcode != null)
                                  ? SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Text(
                                          'Group : ' +
                                              this.groupcode +
                                              '   ' +
                                              this.groupname,
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    )
                                  : Text(''),
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Text(
                                      'Total Onhand.Qty:' +
                                          f_decimal.format(this.realstock) +
                                          ' ' +
                                          this.unit,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                              ]),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
