import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/possalesfnc.dart';
import 'package:com_csith_geniuzpos/models/ccps/ccp.dart';
import 'package:com_csith_geniuzpos/models/persons/psmember.dart';
import 'package:com_csith_geniuzpos/models/possales/salesItemSummary.dart';
import 'package:com_csith_geniuzpos/models/possales/salesitems.dart';
import 'package:com_csith_geniuzpos/resources/fnccal.dart';
import 'package:com_csith_geniuzpos/screens/billdischgs/components/billdischg_btns.dart';
import 'package:com_csith_geniuzpos/screens/billdischgs/components/billdischg_numpad.dart';
import 'package:com_csith_geniuzpos/screens/cardscoupons/components/ccp_searchresult.dart';
import 'package:com_csith_geniuzpos/screens/searchmember/member_info_ok.dart';
import 'package:com_csith_geniuzpos/services/response/ccp_response.dart';
import 'package:com_csith_geniuzpos/services/response/person_reponse.dart';
import 'package:com_csith_geniuzpos/services/response/posbdc_response.dart';
import 'package:com_csith_geniuzpos/services/response/poscontrol_response.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:com_csith_geniuzpos/services/services.dart';
import 'package:com_csith_geniuzpos/utility/normal_dialog.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/curve_button.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/resources/styles.dart';

import 'components/billdischg_list.dart';
import 'components/billdischg_listtitle.dart';

class BilldischgPages extends StatefulWidget {
  @override
  _BilldischgPages createState() => _BilldischgPages();
}

class _BilldischgPages extends State<BilldischgPages>
    implements
        PosFncCallBack,
        GetSearchCCPCallBack,
        PosSumCallBack,
        PosSumBdcCallBack,
        GetSalSUmItemCallBack,
        PosBDCAddNew,
        PosBDCGetBDCBalance,
        PosBDCVoidBDCB,
        PosInitBdcCallBack,
        GetSearchMemberCallBack,
        PosSaveCallBack {
  PosFncCallResponse _responseInput;
  GetSearchCCPResponse _responseCCP;
  PosSumSalesItemCallResponse _responseSumSalItem;
  PosSumBdcItemCallResponse _responseSumBdcItem; //use sales provider ..org
  GetPSalSUmItemResponse _responseUpdateACM; // user poscontrol provider ..org
  PosDBCAddNewCallResponse _responseAddNew; // user bill provider ..new
  PosBDCGetBDCBResponse _responseGetBDCB; // user bill provider ..new
  PosBDCVoidBDCBResponse _responseVoidAitem;
  PosSumInitBdcResponse _responseInitBdc; // user bill provider ..new
  GetSearchMemberResponse _responseMember;
  PosSaveCallResponse _responsePosSave;
  TextEditingController activeTxt;
  PosInput _posinput;
  SalesItemSummary _sumSalesItems;
  SalesItems selectSalesitem;
  int _lastsalesitemid, currentitem;
  _BilldischgPages() {
    _responseInput = new PosFncCallResponse(this);
    _responseCCP = new GetSearchCCPResponse(this);
    _responseSumSalItem = new PosSumSalesItemCallResponse(this);
    _responseSumBdcItem = new PosSumBdcItemCallResponse(this);
    _responseUpdateACM = new GetPSalSUmItemResponse(this);
    _responseAddNew = new PosDBCAddNewCallResponse(this);
    _responseGetBDCB = new PosBDCGetBDCBResponse(this);
    _responseVoidAitem = new PosBDCVoidBDCBResponse(this);
    _responseInitBdc = new PosSumInitBdcResponse(this);
    _responseMember = new GetSearchMemberResponse(this);
    _responsePosSave = new PosSaveCallResponse(this);
    _posinput = new PosInput();
    // psMember = new PsMember();
  }
  PsMember psMember;
  FocusNode fcn1, fcn2, fcn3, fcn4, fcn5, fcn6, fcn7, fcn8, fcn9;
  String memberImgUrl;
  int modeInputByType;
  String inmodeByType;
  @override
  void initState() {
    fcn1 = FocusNode();
    fcn2 = FocusNode();
    fcn3 = FocusNode();
    fcn4 = FocusNode();
    fcn5 = FocusNode();
    fcn6 = FocusNode();
    fcn7 = FocusNode();
    fcn8 = FocusNode();
    fcn9 = FocusNode();
    fcn1.requestFocus();
    memberImgUrl = "http://localhost:8080/icon-png/member.png";
    currentitem = 0;
    _lastsalesitemid = 0;
    _responseSumSalItem.doCalSalesItemSum(context);
    // _responsePosSave.SavePosTrans(context, 10);
    _responseInitBdc.doInitBdc(context);
    modeInputByType = 0;
    inmodeByType = '';

    super.initState();
  }

  @override
  void dispose() {
    PosInput().focusnode.dispose();
    fcn1.dispose();
    fcn2.dispose();
    fcn3.dispose();
    fcn4.dispose();
    fcn5.dispose();
    fcn6.dispose();
    fcn7.dispose();
    fcn8.dispose();
    fcn9.dispose();
    super.dispose();
  }

  void recalsum() {
    _responseSumBdcItem.doCalBDCItemSum(context);
  }

  void putCCPValues(CardsCoupon _cardcoupon) {
    setState(() {
      _posinput.txt4.text = _cardcoupon.ccpName;
      _posinput.txt5.text = '';
      _posinput.txt6.text = '';
      _posinput.txt7.text = '';
      fcn8.requestFocus();
    });
  }

  void putClearValues() {
    setState(() {
      _posinput.txt4.text = '';
      _posinput.txt5.text = '';
      _posinput.txt6.text = '';
      _posinput.txt7.text = '';
    });
  }

  void txtinputEntry(String result) {
    if (result != "") {
      if (result == "OK") {
        modeInputByType = 0;
        String diccoupName = _posinput.txt4.text;
        String disccamt = _posinput.txt5.text.replaceAll(',', '');
        SalesItems _result = SalesItems(diccoupName, '', 0, 0, diccoupName, 0,
            (-1) * double.parse(disccamt), 'BDC', 'Pcs', 0);

        PosSalesFnc().addDiscChrgFromBDCItem(context, _responseAddNew, _result);

        _posinput.txt8.text = '';
      } else if (result == Palette.btncmd_DISCCP) {
        modeInputByType = 1;
        showPopupTask(context, "DISCCOUP");
      } else if (result == "F4") {
        //---check mbDiscMethod =1 (bill disc only) before popup!
        showPopSearchMember(context, _responseMember, '');
      } else if (PosSalesFnc().funcBillDCCall(
          context,
          result,
          _posinput.txt8,
          _posinput.txt9,
          _posinput.txt1,
          _posinput.txt2,
          _responseAddNew,
          _responseGetBDCB,
          _responseVoidAitem,
          _lastsalesitemid,
          currentitem,
          checkSum,
          dispose)) {
        modeInputByType = 0;
      } else if ((result.indexOf(":") > 0)) {
      } else {
        modeInputByType = 0;
        _posinput.txt8.text = _posinput.txt8.text + result;
        _posinput.setActiveTxt(_posinput.txt8, fcn8);
      }
    }
  }

  void addDiscChrgItem(double befbal, String btncmd) {
    try {
      if (_responseAddNew != null || _posinput.txt8 != null) {
        currentitem += 1;
        SalesItems _result = PosSalesFnc().btncmdresult(
            context,
            SalesItems(btncmd, '', 0, 0, btncmd, 0, befbal, 'BDC', 'Pcs', 0),
            btncmd);
        // setState(() {
        PosSalesFnc().addDiscChrgFromBDCItem(context, _responseAddNew, _result);

        _posinput.txt8.text = '';
        //  });
      }
    } catch (e) {
      normalDialog(context, e.toString() + ' @addDiscChrgItem');
    }
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
        Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0), child: billDisChgTitle()),
        Container(child: totalSalesForm()),
        Container(child: totalDiscChgForm()),
        Container(child: totalDuePayForm()),
        Container(
            child:
                (modeInputByType == 0) ? Container() : couponDischgEntryForm()),
        Container(child: bdcEntryForm()),
        Container(child: bildischgTitle()),
        Container(child: bildischgList()),
        Positioned(
            top: 0,
            left: 360,
            child: billdischg11Btns(context, _responseInput, FncItems().dummy)),
        Positioned(
            top: 280,
            left: 360,
            child: billdischgNumpad(context, _responseInput, recalsum)),
      ]),
    );
  }

  Future<void> showPopSearchMember(BuildContext context,
      GetSearchMemberResponse _responseMember, String values) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetAnimationDuration: const Duration(milliseconds: 100),
          child: Stack(
            children: [
              Container(
                // use container to change width and height
                height: Palette.stdbutton_height * 11,
                width: Palette.stdbutton_width * 13.6,
                child: MemberInfoOkPages(_responseMember, values),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> showPopupTask(BuildContext context, String mnuName) async {
    switch (mnuName) {
      case "DISCCOUP":
        {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.white,
                insetAnimationDuration: const Duration(milliseconds: 100),
                child: Stack(
                  children: [
                    Container(
                      // use container to change width and height
                      height: Palette.stdbutton_height * 6.4,
                      width: Palette.stdbutton_width * 5,
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

  Widget billDisChgTitle() {
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
                      text: Palette.billdischg_title,
                      style: TextStyle(
                        fontFamily: 'Tahoma',
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
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

  Widget totalSalesForm() {
    return Stack(
      children: [
        Positioned(
          top: 66,
          left: 40,
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
                                text: Palette.billdischg_totalsales,
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
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 90,
          left: 40,
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
                                text: Palette.billdischg_totalsalesE,
                                style: TextStyle(
                                  fontFamily: 'Tahoma',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
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
          top: 75,
          left: 216,
          child: Container(
            decoration: BoxDecoration(
              color: Palette.stdbutton_theme_c,
              border: Border(
                top: BorderSide(width: 1.0, color: Colors.transparent),
                left: BorderSide(width: 1.0, color: Colors.transparent),
                right: BorderSide(width: 1.0, color: Colors.transparent),
                bottom: BorderSide(width: 1.0, color: Colors.transparent),
              ),
            ),
            width: Palette.stdbutton_width * 2.4,
            height: Palette.onelineheigth() * 0.7,
            //padding: const EdgeInsets.all(1),
            child: TextField(
              autofocus: true,
              focusNode: fcn1,
              controller: _posinput.txt1,
              onChanged: (text) {},
              onSubmitted: (result) {
                fcn2.requestFocus();
              },
              textAlignVertical: TextAlignVertical.top,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: 'Tahoma',
                fontWeight: FontWeight.w400,
                fontSize: 24,
                color: Colors.black,
              ),
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
        // curveButtons(context, _responseInput, stdButtuon0[2], 50, 447,
        //     Palette.stdbutton_width * 0.8, Palette.stdbutton_height * 1.05),
        // positionCurveButtons(context, _responseInput, stdButtuon7, 56, 782, 12)
      ],
    );
  }

  Widget totalDiscChgForm() {
    return Stack(
      children: [
        Positioned(
          top: 116,
          left: 40,
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
                                text: Palette.billdischg_totaldischg,
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
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
            top: 140,
            left: 40,
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
                                  text: Palette.billdischg_totaldischgE,
                                  style: TextStyle(
                                    fontFamily: 'Tahoma',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
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
            )),
        Positioned(
          top: 125,
          left: 216,
          child: Container(
            decoration: BoxDecoration(
              color: Palette.stdbutton_theme_b,
              border: Border(
                top: BorderSide(width: 1.0, color: Colors.transparent),
                left: BorderSide(width: 1.0, color: Colors.transparent),
                right: BorderSide(width: 1.0, color: Colors.transparent),
                bottom: BorderSide(width: 1.0, color: Colors.transparent),
              ),
            ),
            width: Palette.stdbutton_width * 2.4,
            height: Palette.onelineheigth() * 0.7,
            //padding: const EdgeInsets.all(1),
            child: TextField(
              autofocus: true,
              focusNode: fcn2,
              controller: _posinput.txt2,
              onChanged: (text) {},
              onSubmitted: (result) {
                fcn3.requestFocus();
              },
              textAlignVertical: TextAlignVertical.top,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: 'Tahoma',
                fontWeight: FontWeight.w400,
                fontSize: 24,
                color: Colors.black,
              ),
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
        // curveButtons(context, _responseInput, stdButtuon0[2], 50, 447,
        //     Palette.stdbutton_width * 0.8, Palette.stdbutton_height * 1.05),
        // positionCurveButtons(context, _responseInput, stdButtuon7, 56, 782, 12)
      ],
    );
  }

  Widget totalDuePayForm() {
    return Stack(
      children: [
        Positioned(
          top: 166,
          left: 40,
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
                                text: Palette.billdischg_totalduepay,
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
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
            top: 190,
            left: 40,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Center(
                child: Container(
                  width: Palette.stdbutton_width * 3.6,
                  height: Palette.stdbutton_height * 1.2,
                  child: Row(
                    children: [
                      Container(
                        width: Palette.stdbutton_width * 2.6,
                        height: Palette.stdbutton_height * 1.2,
                        padding: const EdgeInsets.all(1),
                        child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            text: '',
                            children: <TextSpan>[
                              TextSpan(
                                  text: Palette.billdischg_totalduepayE,
                                  style: TextStyle(
                                    fontFamily: 'Tahoma',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
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
            )),
        Positioned(
          top: 175,
          left: 216,
          child: Container(
            decoration: BoxDecoration(
              color: Palette.stdbutton_theme_a,
              border: Border(
                top: BorderSide(width: 1.0, color: Colors.transparent),
                left: BorderSide(width: 1.0, color: Colors.transparent),
                right: BorderSide(width: 1.0, color: Colors.transparent),
                bottom: BorderSide(width: 1.0, color: Colors.transparent),
              ),
            ),
            width: Palette.stdbutton_width * 2.4,
            height: Palette.onelineheigth() * 0.7,
            //padding: const EdgeInsets.all(1),
            child: TextField(
              autofocus: true,
              focusNode: fcn3,
              controller: _posinput.txt3,
              onChanged: (text) {},
              onSubmitted: (result) {
                fcn4.requestFocus();
              },
              textAlignVertical: TextAlignVertical.top,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: 'Tahoma',
                fontWeight: FontWeight.w400,
                fontSize: 24,
                color: Colors.black,
              ),
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
        // curveButtons(context, _responseInput, stdButtuon0[2], 50, 447,
        //     Palette.stdbutton_width * 0.8, Palette.stdbutton_height * 1.05),
        // positionCurveButtons(context, _responseInput, stdButtuon7, 56, 782, 12)
      ],
    );
  }

  Widget couponDischgEntryForm() {
    return Stack(
      children: [
        Positioned(
          top: 226,
          left: 15,
          child: Container(
            width: Palette.stdbutton_width * 5.2,
            height: Palette.stdbutton_height * 2.2,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 1.0, color: Colors.grey),
                left: BorderSide(width: 1.0, color: Colors.grey),
                right: BorderSide(width: 1.0, color: Colors.grey),
                bottom: BorderSide(width: 1.0, color: Colors.grey),
              ),
            ),
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
                      autofocus: true,
                      focusNode: fcn4,
                      controller: _posinput.txt4,
                      onChanged: (text) {},
                      onSubmitted: (result) {
                        fcn5.requestFocus();
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
                      focusNode: fcn5,
                      controller: _posinput.txt5,
                      onChanged: (text) {},
                      onSubmitted: (result) {
                        fcn6.requestFocus();
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
                      focusNode: fcn6,
                      controller: _posinput.txt6,
                      onChanged: (text) {},
                      onSubmitted: (result) {
                        fcn7.requestFocus();
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
                      focusNode: fcn7,
                      controller: _posinput.txt7,
                      onChanged: (text) {},
                      onSubmitted: (result) {
                        fcn8.requestFocus();
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

        curveButtons(context, _responseInput, stdButtuon0[3], 290, 310,
            Palette.stdbutton_width * 1.1, Palette.stdbutton_height * 1.1),
      ],
    );
  }

  Widget bildischgTitle() {
    return Stack(children: [
      Positioned(
        top: 378,
        left: 12,
        child: billdischgTitle(),
      ),
    ]);
  }

  Widget bildischgList() {
    return Stack(children: [
      Positioned(
        top: 410,
        left: 12,
        child: BillDisChgItem(lastsalesitem: _lastsalesitemid),
      ),
    ]);
  }

  Widget bdcEntryForm() {
    return Stack(
      children: [
        Positioned(
          top: 296,
          left: 450,
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
                                text: Palette.billdischg_label,
                                style: TextStyle(
                                  fontFamily: 'Tahoma',
                                  fontWeight: FontWeight.bold,
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
          top: 300,
          left: 615,
          child: Container(
            width: Palette.stdbutton_width * 4.1,
            height: Palette.onelineheigth() * 0.8,
            //padding: const EdgeInsets.all(1)
            child: TextField(
              autofocus: true,
              focusNode: fcn8,
              controller: _posinput.txt8,
              onChanged: (text) {},
              onSubmitted: (result) {
                //
              },
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                // contentPadding: const EdgeInsets.all(10.0),
                labelStyle: TextStyle(color: Colors.grey),
                labelText: 'Entry here',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: CsiStyle().primaryColor),
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void closeMe() {
    Navigator.of(context).pop();
    dispose();
  }

  @override
  void onCallPosFncError(String error) {}

  @override
  void onCallPosFncSuccess(String result) {
    setState(() {
      txtinputEntry(result);
    });
  }

  @override
  void onSearchCCPError(String error) {}

  @override
  void onSearchCCPSuccess(CardsCoupon cardsCoupon) {
    putCCPValues(cardsCoupon);
  }

  @override
  void onCallSumSalesItemError(String error) {}

  bool checkSum() {
    // try {
    // _responsePosSave.SavePosTrans(context, 20);
    //_posinput.savePOSTrans(context, 20);
    //   // _posinput.savePOSTrans(context, 22);
    // } catch (e) {
    //   showToast(context, e.toString() + ':checkSum:savePosTran:22');
    // }
    txtinputEntry("ENTER");
    return (_posinput.bdcitemCount(context) > 0);
  }

  @override
  void onCallSumSalesItemSuccess(SalesItemSummary result) {
    if (result != null) {
      _sumSalesItems = result;
      _responseUpdateACM.upACMSalSum(context, result);
      setState(() {
        bdcSetLoad(result.totalamount);
      });
    }
  }

  @override
  void onGetSalSumError(String error) {}

  @override
  void onGetSalSumSuccess(String ok) {}

  @override
  void onCallPosBDCBError() {}

  @override
  void onCallPosBDCBSuccess(double bdcbalance) {
    //---adding ...
    setState(() {
      addDiscChrgItem(double.parse(_posinput.txt3.text.replaceAll(',', '')),
          _posinput.txt9.text);
    });
  }

  @override
  void onCallPosFncVbdcbError() {}

  @override
  void onCallPosFncVbdcbSuccess(double amount) {
    //---void event
    txtinputEntry("ENTER");
    setState(() {
      if (amount == 0) {
        double _balChg = (_posinput.txt2.text.isEmpty)
            ? 0.0
            : double.parse(_posinput.txt2.text.replaceAll(',', ''));
        bdcSetVoid(_balChg);
      } else {
        bdcSetVoid(amount);
      }
    });
  }

  @override
  void onCallSumBdcItemError(String error) {}

  @override
  void onCallSumBdcItemSuccess(SalesItemSummary result) {
    //---recal envet
    setState(() {
      if (result != null) {
        bdcSetRecal(result.totalamount);
      }
    });
  }

  @override
  void onCallPosBDCAddNewError(String error) {}

  @override
  void onCallPosBDCAddNewSuccess(double amount) {
    //---add event
    txtinputEntry("ENTER");
    setState(() {
      bdcSetAdd(amount);
    });
  }

  @override
  void onCallInitBdcError(String error) {}

  @override
  void onCallInitBdcSuccess() {
    normalDialog(context, 'inital');
  }

//-----------CAL FUNCITONS-------
  void bdcFixT(double loadamt) {
    double _fixT = (_posinput.txt1.text.isEmpty)
        ? 0.0
        : double.parse(_posinput.txt1.text.replaceAll(',', ''));
    _posinput.txt1.text = oCcy.format(loadamt);
  }

  void bdcTChg(double amt, int _even) {
    double _tChg = (_posinput.txt2.text.isEmpty)
        ? 0.0
        : double.parse(_posinput.txt2.text.replaceAll(',', ''));
    if (_even == 1) {
      _posinput.txt2.text = oCcy.format(0.0);
    } else if (_even == 2) {
      _posinput.txt2.text = oCcy.format(_tChg + amt);
    } else if (_even == 3) {
      _posinput.txt2.text = oCcy.format(_tChg - amt);
    } else if (_even == 4) {
      _posinput.txt2.text = oCcy.format(amt);
    }
  }

  void bdcCalBalance() {
    double _fixT = (_posinput.txt1.text.isEmpty)
        ? 0.0
        : double.parse(_posinput.txt1.text.replaceAll(',', ''));
    double _tChg = (_posinput.txt2.text.isEmpty)
        ? 0.0
        : double.parse(_posinput.txt2.text.replaceAll(',', ''));
    _posinput.txt3.text = oCcy.format(_fixT + _tChg);
  }

  void bdcSetLoad(double loadamt) {
    try {
      bdcFixT(loadamt);
      bdcTChg(0, 1);
      bdcCalBalance();
    } catch (e) {
      normalDialog(context, e.toString());
    }
  }

  void bdcSetAdd(double amount) {
    try {
      bdcTChg(amount, 2);
      bdcCalBalance();
    } catch (e) {
      normalDialog(context, e.toString());
    }
  }

  void bdcSetVoid(double amount) {
    try {
      bdcTChg(amount, 3);
      bdcCalBalance();
    } catch (e) {
      normalDialog(context, e.toString());
    }
  }

  void bdcSetRecal(double amount) {
    try {
      bdcTChg(amount, 4);
      bdcCalBalance();
    } catch (e) {
      normalDialog(context, e.toString());
    }
  }

  @override
  void onSearchMemberError(String error) {}

  @override
  void onSearchMemeberSuccess(PsMember psMember) {
    _posinput.txt8.text = (psMember.mbDiscPs / 100).toString();
    PosSalesFnc().funcBillDCCall(
        context,
        Palette.btncmd_DISCM,
        _posinput.txt8,
        _posinput.txt9,
        _posinput.txt1,
        _posinput.txt2,
        _responseAddNew,
        _responseGetBDCB,
        _responseVoidAitem,
        _lastsalesitemid,
        currentitem,
        checkSum,
        dispose);
    txtinputEntry("ENTER");
  }

  @override
  void onCallPosSaveError(String error) {}

  @override
  void onCallPosSaveSuccess(int result) {}
}
