import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/models/ccps/ccp.dart';
import 'package:com_csith_geniuzpos/models/persons/salman.dart';
import 'package:com_csith_geniuzpos/services/response/ccp_response.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:com_csith_geniuzpos/utility/normal_dialog.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/curve_button.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';

import 'components/ccp_searchresult.dart';

class CcpIsOkPages extends StatefulWidget {
  final String txtValue;
  final PosFncGetAitemCallResponse responseGetItem;
  final TextEditingController entBtnCmd;
  CcpIsOkPages(this.txtValue, this.responseGetItem, this.entBtnCmd);
  @override
  _CcpIsOkPages createState() => _CcpIsOkPages();
}

class _CcpIsOkPages extends State<CcpIsOkPages>
    implements PosFncCallBack, GetSearchCCPCallBack {
  PosFncCallResponse _responseInput;
  GetSearchCCPResponse _responseCCP;
  TextEditingController activeTxt;
  final PosInput _posinput = new PosInput();
  _CcpIsOkPages() {
    _responseInput = new PosFncCallResponse(this);
    _responseCCP = new GetSearchCCPResponse(this);

    _responseInput.doEntry('DISCCOUP', 0, 0);
  }

  Salesman psMember;
  FocusNode fcn1, fcn2, fcn3, fcn4, fcn5, fcn6, fcn7, fcn8;
  String memberImgUrl;
  @override
  void initState() {
    fcn1 = FocusNode();
    fcn2 = FocusNode();
    fcn3 = FocusNode();
    fcn4 = FocusNode();
    // fcn5 = FocusNode();
    // fcn6 = FocusNode();
    // fcn7 = FocusNode();
    // fcn8 = FocusNode();
    //fcn1.requestFocus();
    _posinput.txt2.text = widget.txtValue;
    memberImgUrl = "http://localhost:8080/icon-png/member.png";
    super.initState();
  }

  void putCCPValues(CardsCoupon _cardcoupon) {
    setState(() {
      _posinput.txt1.text = _cardcoupon.ccpName;
      _posinput.txt2.text = widget.txtValue;
      fcn3.requestFocus();
    });
  }

  void putMeberClearValues() {
    setState(() {
      _posinput.txt1.text = '';
      _posinput.txt2.text = '';
    });
  }

  @override
  void dispose() {
    fcn1.dispose();
    fcn2.dispose();
    fcn3.dispose();
    fcn4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(width: 0, color: Palette.scaffold),
            left: BorderSide(width: 0, color: Palette.scaffold),
            right: BorderSide(width: 0, color: Palette.scaffold),
            bottom: BorderSide(width: 0, color: Colors.white),
          )),
      child: Scaffold(body: registereScreenDesktop(context)),
    );
  }

  Widget registereScreenDesktop(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(width: 0, color: Palette.scaffold),
            left: BorderSide(width: 0, color: Palette.scaffold),
            right: BorderSide(width: 0, color: Palette.scaffold),
            bottom: BorderSide(width: 0, color: Colors.white),
          )),
      child: Stack(children: [
        Container(padding: EdgeInsets.fromLTRB(0, 0, 0, 0), child: ccpTitle()),
        Container(child: couponDischgEntryForm()),
        // Container(child: smnameForm()),
        Container(child: smCommandForm()),
      ]),
    );
  }

  Future<void> showPopupTask(BuildContext context, String mnuName) async {
    switch (mnuName) {
      case "DISCCOUP":
        {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.white,
                insetAnimationDuration: const Duration(milliseconds: 100),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: Colors.white, spreadRadius: 3),
                        ],
                      ),
                      height: Palette.stdbutton_height * 4.9,
                      width: Palette.stdbutton_width * 4.3,
                      child: CCPSearchListPages(
                          responseCCP: _responseCCP,
                          responseInput: _responseInput,
                          actionDo: putCCPValues,
                          ccType: "3"),
                    ),
                  ],
                ),
              );
            },
          );
        }
        break;

      default:
        normalDialog(context, mnuName);
        break;
    }
  }

  Widget ccpTitle() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 30,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(width: 1.0, color: Colors.white),
                left: BorderSide(width: 1.0, color: Colors.white),
                right: BorderSide(width: 1.0, color: Colors.white),
                bottom: BorderSide(width: 1.0, color: Colors.white),
              )),
          child: Center(
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                text: '',
                children: <TextSpan>[
                  TextSpan(
                      text: Palette.dischg_coupontitle,
                      style: TextStyle(
                        fontFamily: 'Tahoma',
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.black,
                      )),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget couponDischgEntryForm() {
    return Stack(
      children: [
        Positioned(
          top: 50,
          left: 22,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.white, spreadRadius: 3),
              ],
            ),
            width: Palette.stdbutton_width * 5.2,
            height: Palette.stdbutton_height * 2.2,
            child: Stack(
              children: [
                Positioned(
                  top: 8,
                  left: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: Container(
                        width: Palette.stdbutton_width * 3.6,
                        height: Palette.stdbutton_height * 1.2,
                        child: Row(
                          children: [
                            Container(
                              width: Palette.stdbutton_width * 3.6,
                              height: Palette.stdbutton_height * 1.2,
                              padding: const EdgeInsets.all(1),
                              child: RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  text: '',
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: Palette.billdischg_coupontype,
                                        style: TextStyle(
                                          fontFamily: 'Tahoma',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Colors.black,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 116,
                  child: Container(
                    width: Palette.stdbutton_width * 2.0,
                    height: Palette.onelineheigth() * 0.5,
                    child: TextField(
                      // autofocus: true,
                      //  focusNode: fcn1,
                      controller: _posinput.txt1,
                      onChanged: (text) {},
                      onSubmitted: (result) {
                        // fcn2.requestFocus();
                      },
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        // contentPadding: const EdgeInsets.all(10.0),
                        labelStyle: TextStyle(color: Colors.grey),
                        labelText: '',
                        fillColor: Colors.transparent,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 42,
                  left: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: Container(
                        width: Palette.stdbutton_width * 3.6,
                        height: Palette.stdbutton_height * 1.2,
                        child: Row(
                          children: [
                            Container(
                              width: Palette.stdbutton_width * 3.6,
                              height: Palette.stdbutton_height * 1.2,
                              padding: const EdgeInsets.all(1),
                              child: RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  text: '',
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: Palette.billdischg_coupondisc,
                                        style: TextStyle(
                                          fontFamily: 'Tahoma',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Colors.black,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 42,
                  left: 116,
                  child: Container(
                    width: Palette.stdbutton_width * 2.0,
                    height: Palette.onelineheigth() * 0.5,
                    child: TextField(
                      autofocus: true,
                      focusNode: fcn2,
                      controller: _posinput.txt2,
                      onChanged: (text) {},
                      onSubmitted: (result) {
                        fcn3.requestFocus();
                      },
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        // contentPadding: const EdgeInsets.all(10.0),
                        labelStyle: TextStyle(color: Colors.grey),
                        labelText: '',
                        fillColor: Colors.transparent,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 76,
                  left: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: Container(
                        width: Palette.stdbutton_width * 3.6,
                        height: Palette.stdbutton_height * 1.2,
                        child: Row(
                          children: [
                            Container(
                              width: Palette.stdbutton_width * 3.6,
                              height: Palette.stdbutton_height * 1.2,
                              padding: const EdgeInsets.all(1),
                              child: RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  text: '',
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: Palette.billdischg_couponnumber,
                                        style: TextStyle(
                                          fontFamily: 'Tahoma',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Colors.black,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 76,
                  left: 116,
                  child: Container(
                    width: Palette.stdbutton_width * 2.0,
                    height: Palette.onelineheigth() * 0.5,
                    child: TextField(
                      autofocus: true,
                      focusNode: fcn3,
                      controller: _posinput.txt3,
                      onChanged: (text) {},
                      onSubmitted: (result) {
                        fcn4.requestFocus();
                      },
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        // contentPadding: const EdgeInsets.all(10.0),
                        labelStyle: TextStyle(color: Colors.grey),
                        labelText: '',
                        fillColor: Colors.transparent,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 110,
                  left: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: Container(
                        width: Palette.stdbutton_width * 3.6,
                        height: Palette.stdbutton_height * 1.2,
                        child: Row(
                          children: [
                            Container(
                              width: Palette.stdbutton_width * 3.6,
                              height: Palette.stdbutton_height * 1.2,
                              padding: const EdgeInsets.all(1),
                              child: RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  text: '',
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: Palette.billdischg_couponexpd,
                                        style: TextStyle(
                                          fontFamily: 'Tahoma',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Colors.black,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 110,
                  left: 116,
                  child: Container(
                    width: Palette.stdbutton_width * 2.0,
                    height: Palette.onelineheigth() * 0.5,
                    child: TextField(
                      autofocus: true,
                      focusNode: fcn4,
                      controller: _posinput.txt4,
                      onChanged: (text) {},
                      onSubmitted: (result) {
                        // fcn8.requestFocus();
                      },
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        // contentPadding: const EdgeInsets.all(10.0),
                        labelStyle: TextStyle(color: Colors.grey),
                        labelText: '',
                        fillColor: Colors.transparent,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        //------------

        // curveButtons(context, _responseInput, stdButtuon0[3], 290, 310,
        //     Palette.stdbutton_width * 1.1, Palette.stdbutton_height * 1.1),
      ],
    );
  }

  Widget smCommandForm() {
    return Stack(
      children: [
        curveButtons(context, _responseInput, stdButtuon0[4], 224, 30,
            Palette.stdbutton_width * 1.3, Palette.stdbutton_height * 1.3),
        curveButtons(context, _responseInput, stdButtuon0[3], 224, 200,
            Palette.stdbutton_width * 1.3, Palette.stdbutton_height * 1.3),
      ],
    );
  }

  void closeMe() {
    Navigator.pop(context);
  }

  @override
  void onCallPosFncError(String error) {}

  @override
  void onCallPosFncSuccess(String result) {
    setState(() {
      txtinputEntry(result);
    });
  }

  void txtinputEntry(String result) {
    // normalDialog(context, result);
    if (result != "") {
      if (result == "OK") {
        if (_posinput.txt2.text.indexOf('%') > 0) {
          widget.entBtnCmd.text = Palette.btncmd_DISCCP +
              ':' +
              _posinput.txt2.text.replaceAll('%', '') +
              ':' +
              _posinput.txt3.text;
          // +
          // (_posinput.txt2.text);
        } else {
          widget.entBtnCmd.text = Palette.btncmd_DISCCB +
              ':' +
              _posinput.txt2.text +
              ':' +
              _posinput.txt3.text;
          //  +
          // (_posinput.txt2.text);
        }

        widget.responseGetItem.doGetAitem(context, 1);
        closeMe();
      } else if (result == "DISCCOUP") {
        showPopupTask(context, result);
      } else if (result == "CANCEL") {
        closeMe();
      }
    }
  }

  @override
  void onSearchCCPError(String error) {}

  @override
  void onSearchCCPSuccess(CardsCoupon cardsCoupon) {
    //normalDialog(context, cardsCoupon.ccpid);
    putCCPValues(cardsCoupon);
  }
}
