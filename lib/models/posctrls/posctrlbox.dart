import 'package:com_csith_geniuzpos/resources/configs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class PosCtrlBox extends StatelessWidget {
  PosCtrlBox(
      {Key key,
      this.itemcode,
      this.description,
      this.groupcode,
      this.valuetext, // product Group,
      this.valueint, // group name,
      this.valuedbl,
      this.image})
      : super(key: key);
  final String itemcode;
  final String description;
  final String groupcode;
  final String valuetext;
  final int valueint;
  final double valuedbl;

  final String image;
  var txt = TextEditingController();

  // ignore: non_constant_identifier_names
  Widget PluForm(String _name, String _code, var context) {
    txt.text = _name;
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: TextField(
        controller: txt,
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
          labelText: 'Item: ' + _code,
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
                  PluForm(this.valuetext, this.itemcode, context),
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
                                      child: Text('Group : ' + this.groupcode,
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
                                      'value:' + cno.format(this.valueint),
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
