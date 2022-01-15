import 'dart:typed_data';

import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';
import 'package:com_csith_geniuzpos/data/possales/bdcitemmodel.dart';
import 'package:com_csith_geniuzpos/data/possales/rcpitemmodel.dart';
import 'package:com_csith_geniuzpos/data/possales/salesitemmodel.dart';
import 'package:com_csith_geniuzpos/models/posmodels/csplu.dart';
import 'package:com_csith_geniuzpos/models/posmodels/pluPrice.dart';
import 'package:com_csith_geniuzpos/reports/pdfprinting/pdfprintctrl.dart';
import 'package:com_csith_geniuzpos/resources/csiconfig.dart';
import 'package:com_csith_geniuzpos/resources/fnccal.dart';
import 'package:com_csith_geniuzpos/services/response/escpos_response.dart';
import 'package:com_csith_geniuzpos/services/response/posdata_response.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:com_csith_geniuzpos/utility/normal_dialog.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/curve_button.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';

import 'package:com_csith_geniuzpos/resources/styles.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:provider/src/provider.dart';

import 'components/plu_searchresult.dart';

class PluInfoOkPages extends StatefulWidget {
  final String txtSearch;
  final PosFncAddNewCallResponse responseAddNew;

  final TextEditingController txtPlu;
  final TextEditingController txtQty;
  final GetPluResponse responsePlu;
  final double sellPriceNo;
  PluInfoOkPages(this.txtSearch, this.responseAddNew, this.txtPlu, this.txtQty,
      this.responsePlu, this.sellPriceNo);
  @override
  _PluInfoOkPages createState() => _PluInfoOkPages();
}

class _PluInfoOkPages extends State<PluInfoOkPages>
    implements
        PosFncCallBack,
        GetPluCallBack,
        GetPluListCallBack,
        GetPromoListCallBack,
        POSprintCallBack {
  PosFncCallResponse _responseInput;
  GetPluListResponse _reponsePluList;
  GetPromoListResponse _reponsePromoList;
  GetPluResponse _responsePlu;
  POSprintResponse _responseEscPos;
  TextEditingController activeTxt;
  List<CsPlu> getPluList;
  static final GlobalKey<FormFieldState<String>> _searchFormKey =
      GlobalKey<FormFieldState<String>>();

  final PosInput _posinput = new PosInput();
  _PluInfoOkPages() {
    _responseInput = new PosFncCallResponse(this);
    _responsePlu = new GetPluResponse(this);
    _reponsePluList = new GetPluListResponse(this);
    _reponsePromoList = new GetPromoListResponse(this);
    _responseEscPos = new POSprintResponse(this);
    csPlus = new CsPlu();
  }

  CsPlu csPlus;
  FocusNode fcn1, fcn2, fcn3, fcn4, fcn5, fcn6, fcn7, fcn8;
  String memberImgUrl, pluUrl;
  String thistitle;
  @override
  void initState() {
    fcn1 = FocusNode();
    fcn2 = FocusNode();

    memberImgUrl = "http://localhost:8080/icon-png/member.png";
    _posinput.txt1.text = widget.txtSearch;
    getCurPluUrl();
    //----auto serach get list when come from sales page,
    //----if more than one this will show selection list,
    //----but if have one will show detail.
    if (widget.responseAddNew != null ||
        widget.txtPlu != null ||
        widget.txtQty != null) {
      thistitle = Palette.plu_title;
    } else {
      thistitle = Palette.checkprice_title;
    }
    super.initState();
  }

  void getCurPluUrl() async {
    String url = PosControlFnc().getPLUurl(context);
    pluUrl = await PosControlFnc().getCurrentIP(url);

    PosControlFnc().checkCurIP_pluWSurl(context, pluUrl);
  }

  //----test values for printing
  String hl1, hl2, hl3, hl4, hl5, hl6;
  String fl1, fl2, fl3, fl4, fl5, fl6, fl7, fl8, fl9, flA;
  String posid, cashier, shopid, member, salesman, docno, pid;
  void getConfigValue(BuildContext context) {
    try {
      hl1 =
          PosControlFnc().getConfigValue(context, MyConfig().i_headerline1, '');
      hl2 =
          PosControlFnc().getConfigValue(context, MyConfig().i_headerline2, '');
      hl3 =
          PosControlFnc().getConfigValue(context, MyConfig().i_headerline3, '');
      hl4 =
          PosControlFnc().getConfigValue(context, MyConfig().i_headerline4, '');
      hl5 =
          PosControlFnc().getConfigValue(context, MyConfig().i_headerline5, '');
      hl6 =
          PosControlFnc().getConfigValue(context, MyConfig().i_headerline6, '');

      fl1 =
          PosControlFnc().getConfigValue(context, MyConfig().i_footerline1, '');
      fl2 =
          PosControlFnc().getConfigValue(context, MyConfig().i_footerline2, '');
      fl3 =
          PosControlFnc().getConfigValue(context, MyConfig().i_footerline3, '');
      fl4 =
          PosControlFnc().getConfigValue(context, MyConfig().i_footerline4, '');
      fl5 =
          PosControlFnc().getConfigValue(context, MyConfig().i_footerline5, '');
      fl6 =
          PosControlFnc().getConfigValue(context, MyConfig().i_footerline6, '');
      fl7 =
          PosControlFnc().getConfigValue(context, MyConfig().i_footerline7, '');
      fl8 =
          PosControlFnc().getConfigValue(context, MyConfig().i_footerline8, '');
      fl9 =
          PosControlFnc().getConfigValue(context, MyConfig().i_footerline9, '');
      flA =
          PosControlFnc().getConfigValue(context, MyConfig().i_footerlineA, '');

      docno = PosControlFnc()
          .getRunno(context, MyConfig().a_cycleRcptBegEnd); //'101214183125';
      shopid = PosControlFnc()
          .getConfigValue(context, MyConfig().i_configShopId, '');
      posid = PosControlFnc().getConfigValue(context, MyConfig().i_posId, '');
      pid = PosControlFnc().getConfigValue(context, MyConfig().i_pId, '');
      cashier = PosControlFnc()
          .getConfigValue(context, MyConfig().i_configCashier, '');
      member = PosControlFnc()
          .getConfigValue(context, MyConfig().i_configMember, '');
      salesman = PosControlFnc()
          .getConfigValue(context, MyConfig().i_configSaleman, '');
    } catch (e) {
      showToast(context, e.toString());
    }
  }

  //---end test

  void putPluValues(CsPlu _csPlus) {
    csPlus = _csPlus;
    String vqty = '';
    double price, sellPriceNo, discper;

    price = _csPlus.sellUnitPrice1;
    sellPriceNo = widget.sellPriceNo;
    if (sellPriceNo < 0) {
      discper = (-1) * sellPriceNo;
      vqty = pCcy.format(sellPriceNo);
      _posinput.txt4.text = oCcy.format(price - price * discper);
    } else {
      if (sellPriceNo == 2) {
        price = csPlus.sellUnitPrice2;
      } else if (sellPriceNo == 3) {
        price = csPlus.sellUnitPrice3;
      } else if (sellPriceNo == 4) {
        price = csPlus.sellUnitPrice4;
      } else if (sellPriceNo == 5) {
        price = csPlus.sellUnitPrice5;
      } else if (sellPriceNo == 6) {
        price = csPlus.sellUnitPrice6;
      }
      _posinput.txt4.text = oCcy.format(price);
    }

    _posinput.txt1.text = _csPlus.pluCode;
    _posinput.txt2.text = _csPlus.pluShortDesc;
    _posinput.txt3.text = _csPlus.sellUnit + ' ,' + vqty;
  }

  void putPromoValues(PluPrice _promoPrice) {
    if (_promoPrice.mbId != null &&
        _promoPrice.mbId.isNotEmpty &&
        _promoPrice.mbId != '') {
      double mbPrice = (_promoPrice.mbPrice > _promoPrice.basePriceByPos)
          ? _promoPrice.basePriceByPos
          : _promoPrice.mbPrice;
      _posinput.txt4.text = oCcy.format(mbPrice);
    }
    _posinput.txt5.text = _promoPrice.promoId;
    _posinput.txt6.text = oCcy.format(_promoPrice.promoPrice);
    _posinput.txt7.text = _promoPrice.promoDay;
  }

  void clsPromoValues() {
    _posinput.txt5.text = '';
    _posinput.txt6.text = '';
    _posinput.txt7.text = '';
  }

  void putMeberClearValues() {
    setState(() {
      _posinput.txt1.text = '';
      _posinput.txt2.text = '';
      _posinput.txt3.text = '';
      _posinput.txt4.text = '';
    });
  }

  @override
  void dispose() {
    PosInput().focusnode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<SalesItemHiveModel>().getItem();
    context.watch<BillDCItemHiveModel>().getItem();
    context.watch<ReceiptItemHiveModel>().getItem();
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
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.white, spreadRadius: 3),
        ],
      ),
      child: Stack(children: [
        Container(padding: EdgeInsets.fromLTRB(0, 0, 0, 0), child: pluTitle()),
        Container(child: barcodeForm()),
        Container(child: plunameForm()),
        Container(child: pluUnitForm()),
        Container(child: pluPriceForm()),
        Container(child: pmPriceForm()),
        Container(child: pluCommandForm()),
      ]),
    );
  }

  Future<void> showPopupTask(BuildContext context, String mnuName) async {
    switch (mnuName) {
      case "PLULIST":
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
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: Colors.white, spreadRadius: 3),
                        ],
                      ),
                      height: Palette.stdbutton_height * 6,
                      width: Palette.stdbutton_width * 7.3,
                      child: PluSearchListPages(
                          responsePlu: _responsePlu,
                          txt: _posinput.txt1,
                          actionDo: putMeberClearValues,
                          getPluList: getPluList),
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

  Widget pluTitle() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: Colors.white, spreadRadius: 3),
            ],
          ),
          child: Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: <TextSpan>[
                  TextSpan(
                      text: thistitle, //Palette.plu_title,
                      style: TextStyle(
                        fontFamily: 'Tahoma',
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
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

  Widget barcodeForm() {
    return Stack(
      children: [
        Positioned(
          top: 40,
          left: 320,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: Container(
                width: Palette.stdbutton_width * 5.6,
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
                                text: Palette.plu_f1,
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
          top: 60,
          left: 30,
          child: Container(
            width: Palette.stdbutton_width * 3.6,
            height: Palette.onelineheigth() * 0.8,
            //padding: const EdgeInsets.all(1),
            child: new TextFormField(
              autofocus: true,
              controller: _posinput.txt1,
              focusNode: fcn1,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8.0),
                labelStyle: TextStyle(color: Colors.grey),
                labelText: '[PluCode] or Entry search words here: ',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: CsiStyle().primaryColor)),
              ),
            ),
          ),
        ),
        curveButtons(context, _responseInput, stdButtuon0[2], 60, 320,
            Palette.stdbutton_width * 0.8, Palette.stdbutton_height * 1.05),
        curveButtons(context, _responseInput, stdButtuon0[10], 60, 410,
            Palette.stdbutton_width * 0.8, Palette.stdbutton_height * 1.05),
        curveButtons(context, _responseInput, stdButtuon0[11], 60, 500,
            Palette.stdbutton_width * 0.8, Palette.stdbutton_height * 1.05),
        //positionCurveButtons(context, _responseInput, stdButtuon7, 56, 782, 12)
      ],
    );
  }

  Widget plunameForm() {
    return Stack(
      children: [
        Positioned(
          top: 134,
          left: 10,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: Container(
                width: Palette.stdbutton_width * 4,
                height: Palette.stdbutton_height,
                child: Row(
                  children: [
                    Container(
                      width: Palette.stdbutton_width * 3.6,
                      height: Palette.stdbutton_height,
                      padding: const EdgeInsets.all(1),
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          text: '',
                          children: <TextSpan>[
                            TextSpan(
                                text: Palette.plu_f11,
                                style: TextStyle(
                                  fontFamily: 'Tahoma',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
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
          top: 120,
          left: 166,
          child: Container(
            width: Palette.stdbutton_width * 4.7,
            height: Palette.onelineheigth() * 0.8,
            // padding: const EdgeInsets.all(1),
            child: TextField(
              enabled: false,
              focusNode: fcn2,
              controller: _posinput.txt2,
              // onChanged: (text) {},
              // onSubmitted: (result) {
              //   //fcn3.requestFocus();
              // },
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                //  contentPadding: const EdgeInsets.all(10.0),
                labelStyle: TextStyle(color: Colors.grey),
                labelText: '',
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

  Widget pluUnitForm() {
    return Stack(
      children: [
        Positioned(
          top: 172,
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
                                text: Palette.plu_f111,
                                style: TextStyle(
                                  fontFamily: 'Tahoma',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
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
          top: 158,
          left: 166,
          child: Container(
            width: Palette.stdbutton_width * 3.6,
            height: Palette.onelineheigth() * 0.8,
            //padding: const EdgeInsets.all(1),
            child: TextField(
              enabled: false,
              focusNode: fcn3,
              controller: _posinput.txt3,
              // onChanged: (text) {},
              // onSubmitted: (result) {
              //  // fcn4.requestFocus();
              // },
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                // contentPadding: const EdgeInsets.all(10.0),
                labelStyle: TextStyle(color: Colors.grey),
                labelText: '',
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

  Widget mbExpireDateForm() {
    return Stack(
      children: [
        Positioned(
          top: 172,
          left: 480,
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
                                text: Palette.sales_member_f7,
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
          top: 178,
          left: 595,
          child: Container(
            width: Palette.stdbutton_width * 4.2,
            height: Palette.onelineheigth() * 0.8,
            //padding: const EdgeInsets.all(1)
            child: TextField(
              autofocus: true,
              focusNode: fcn8,
              controller: _posinput.txtMemberExpireDate,
              onChanged: (text) {},
              onSubmitted: (result) {
                fcn4.requestFocus();
              },
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                // contentPadding: const EdgeInsets.all(10.0),
                labelStyle: TextStyle(color: Colors.grey),
                labelText: 'Expire Date',
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

  Widget pluPriceForm() {
    return Stack(
      children: [
        Positioned(
          top: 215,
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
                                text: Palette.plu_f1111,
                                style: TextStyle(
                                  fontFamily: 'Tahoma',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.blue,
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
          top: 198,
          left: 166,
          child: Container(
            width: Palette.stdbutton_width * 3.6,
            height: Palette.onelineheigth() * 0.8,
            //padding: const EdgeInsets.all(1),
            child: TextField(
              enabled: false,
              focusNode: fcn4,
              controller: _posinput.txt4,
              style: TextStyle(
                fontFamily: 'Tahoma',
                fontWeight: FontWeight.w400,
                fontSize: 24,
                color: Colors.black,
              ),
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                // contentPadding: const EdgeInsets.all(10.0),
                labelStyle: TextStyle(color: Colors.grey),
                labelText: '',
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

  Widget pmPriceForm() {
    return Stack(
      children: [
        Positioned(
          top: 260,
          left: 10,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: Container(
                width: Palette.stdbutton_width * 3.6,
                height: Palette.stdbutton_height * 2.2,
                child: Row(
                  children: [
                    Container(
                      width: Palette.stdbutton_width * 3.6,
                      height: Palette.stdbutton_height * 2.2,
                      padding: const EdgeInsets.all(1),
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          text: '',
                          children: <TextSpan>[
                            TextSpan(
                                text: Palette.promo_f1,
                                style: TextStyle(
                                  fontFamily: 'Tahoma',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.red,
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
          top: 238,
          left: 166,
          child: Container(
            width: Palette.stdbutton_width * 3.6,
            height: Palette.onelineheigth() * 0.8,
            //padding: const EdgeInsets.all(1),
            child: TextField(
              enabled: false,
              focusNode: fcn4,
              controller: _posinput.txt5,
              // onChanged: (text) {},
              // onSubmitted: (result) {
              //   fcn5.requestFocus();
              // },
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                // contentPadding: const EdgeInsets.all(10.0),
                labelStyle: TextStyle(color: Colors.grey),
                labelText: '',
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
        Positioned(
          top: 278,
          left: 166,
          child: Container(
            width: Palette.stdbutton_width * 3.6,
            height: Palette.onelineheigth() * 0.8,
            //padding: const EdgeInsets.all(1),
            child: TextField(
              enabled: false,
              focusNode: fcn4,
              controller: _posinput.txt6,
              style: TextStyle(
                fontFamily: 'Tahoma',
                fontWeight: FontWeight.w400,
                fontSize: 24,
                color: Colors.black,
              ),
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                // contentPadding: const EdgeInsets.all(10.0),
                labelStyle: TextStyle(color: Colors.grey),
                labelText: '',
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
        Positioned(
          top: 318,
          left: 166,
          child: Container(
            width: Palette.stdbutton_width * 3.6,
            height: Palette.onelineheigth() * 0.8,
            //padding: const EdgeInsets.all(1),
            child: TextField(
              enabled: false,
              focusNode: fcn4,
              controller: _posinput.txt7,
              // onChanged: (text) {},
              // onSubmitted: (result) {
              //   fcn5.requestFocus();
              // },
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                // contentPadding: const EdgeInsets.all(10.0),
                labelStyle: TextStyle(color: Colors.grey),
                labelText: '',
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

  Widget mbPointForm() {
    return Stack(
      children: [
        Positioned(
          top: 288,
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
                                text: Palette.sales_member_f4,
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
          top: 296,
          left: 166,
          child: Container(
            width: Palette.stdbutton_width * 3.6,
            height: Palette.onelineheigth() * 0.8,
            //padding: const EdgeInsets.all(1),
            child: TextField(
              autofocus: true,
              focusNode: fcn5,
              controller: _posinput.txtMemberCurPoint,
              onChanged: (text) {},
              onSubmitted: (result) {
                fcn6.requestFocus();
              },
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                // contentPadding: const EdgeInsets.all(10.0),
                labelStyle: TextStyle(color: Colors.grey),
                labelText: 'Current Points',
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

  Widget mbCashCardForm() {
    return Stack(
      children: [
        Positioned(
          top: 346,
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
                                text: Palette.sales_member_f5,
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
          top: 356,
          left: 166,
          child: Container(
            width: Palette.stdbutton_width * 3.6,
            height: Palette.onelineheigth() * 0.8,
            //padding: const EdgeInsets.all(1),
            child: TextField(
              autofocus: true,
              focusNode: fcn6,
              controller: _posinput.txtMemebrCurCash,
              onChanged: (text) {},
              onSubmitted: (result) {
                fcn7.requestFocus();
              },
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                // contentPadding: const EdgeInsets.all(10.0),
                labelStyle: TextStyle(color: Colors.grey),
                labelText: 'Cash Card Amount',
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

  Widget mbMemoForm() {
    return Stack(
      children: [
        Positioned(
          top: 404,
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
                                text: Palette.sales_member_f6,
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
          top: 410,
          left: 166,
          child: Container(
            width: Palette.stdbutton_width * 3.6,
            height: Palette.onelineheigth() * 4.8,
            //padding: const EdgeInsets.all(1),
            child: TextField(
              autofocus: true,
              focusNode: fcn7,
              controller: _posinput.txtMemberMemory,
              keyboardType: TextInputType.text,
              maxLines: 5,
              onChanged: (text) {},
              onSubmitted: (result) {
                fcn8.requestFocus();
              },
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                // contentPadding: const EdgeInsets.all(10.0),
                labelStyle: TextStyle(color: Colors.grey),
                labelText: 'Note',
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

  Widget mbPhotoForm() {
    return Stack(
      children: [
        Positioned(
          top: 238,
          left: 484,
          child: Container(
            width: Palette.stdbutton_width * 5.6,
            height: Palette.stdbutton_height * 6.6,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Palette.stdbutton_theme_6,
            ),
            child: ClipOval(
                child: (memberImgUrl == '')
                    ? Image.network(
                        "http://localhost:8080/icon-png/member.png",
                        fit: BoxFit.fitHeight,
                        // width: 120.0,
                        // height: 120.0,
                      )
                    : Image.network(
                        memberImgUrl,
                        fit: BoxFit.fitHeight,
                        // width: 120.0,
                        // height: 120.0,
                      )),
          ),
        ),
      ],
    );
  }

  Widget pluCommandForm() {
    return Stack(
      children: [
        curveButtons(context, _responseInput, stdButtuon0[4], 364, 480,
            Palette.stdbutton_width * 0.8, Palette.stdbutton_height * 1.3),
        (widget.responseAddNew != null)
            ? curveButtons(context, _responseInput, stdButtuon0[3], 364, 40,
                Palette.stdbutton_width * 0.8, Palette.stdbutton_height * 1.3)
            : Container(),
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

  void showPluResult(List<CsPlu> _cspluslist) {
    getPluList = _cspluslist;
    //--------------
    if (_cspluslist.length > 1) {
      showPopupTask(context, "PLULIST");
    } else if (_cspluslist.length > 0) {
      csPlus = _cspluslist[0];
      getPromoPrice(csPlus);
      setState(() {
        putPluValues(csPlus);
      });
      // putPluValues(csPlus);
    } else {
      normalDialog(context, " Not found! ");
      putMeberClearValues();
    }
  }

  void getPromoPrice(CsPlu _csplus) {
    try {
      if (widget.responseAddNew != null) {
        String posMem = _posinput.getMemberIDname(context);
        if (posMem.isNotEmpty && posMem != ' ') {
          String url =
              pluUrl + '/PluPrices/i/' + posMem + '/' + _csplus.pluCode;
          _reponsePromoList.getPromoList(url);
          //  _reponsePluList.getPluList(url);
        } else {
          String url = pluUrl + '/PluPrices/' + _csplus.pluCode;
          _reponsePromoList.getPromoList(url);
          // _reponsePluList.getPluList(url);
        }
      } else {
        String url = pluUrl + '/PluPrices/' + _csplus.pluCode;
        _reponsePromoList.getPromoList(url);
      }
    } catch (e) {
      showToast(context, e.toString());
    }
  }

  void txtinputEntry(String result) {
    if (result != "") {
      if (result == "OK") {
        widget.responsePlu.getPlu(csPlus);
        Navigator.pop(context);
      } else if (result == "SEARCH") {
        String posMem = _posinput.getMemberIDname(context);

        if (posMem.isNotEmpty && posMem != ' ') {
          String url =
              pluUrl + '/getsaleitem/i/' + posMem + '/' + _posinput.txt1.text;

          _reponsePluList.getPluList(url);
        } else {
          String url = pluUrl + '/getsaleitem/' + _posinput.txt1.text;

          _reponsePluList.getPluList(url);
        }
      } else if (result == "SCHBYNAME") {
        String posMem = _posinput.getMemberIDname(context);

        if (posMem.isNotEmpty && posMem != ' ') {
          String url =
              pluUrl + '/getsaleitem/i/' + posMem + '/@' + _posinput.txt1.text;

          _reponsePluList.getPluList(url);
        } else {
          String url = pluUrl + '/getsaleitem/@' + _posinput.txt1.text;

          _reponsePluList.getPluList(url);
        }
      } else if (result == "SCHBYBOTH") {
        String posMem = _posinput.getMemberIDname(context);

        if (posMem.isNotEmpty && posMem != ' ') {
          String url =
              pluUrl + '/getsaleitem/i/' + posMem + '/_' + _posinput.txt1.text;

          _reponsePluList.getPluList(url);
        } else {
          String url = pluUrl + '/getsaleitem/_' + _posinput.txt1.text;

          _reponsePluList.getPluList(url);
        }
      } else if (result == "CANCEL") {
        if (widget.txtPlu != null && widget.txtQty != null) {
          widget.txtPlu.text = '';
          widget.txtQty.text = '';
        }
        Navigator.pop(context);
      } else {
        normalDialog(context, result);
      }
      //---member search by result (MemberID )then display data in forms here!
    }
  }

  @override
  void onPluError(String error) {}

  @override
  void onPluSuccess(CsPlu _csplus) {
    // ---- get Default Price from _csPlus
    // ---- get Promotion Price next! PluPrice
    //http://127.0.0.1:9393/PluPrices/i/[posid]/[memid]/[plu]]
    getPromoPrice(_csplus);
    // --- show default price / member price first
    setState(() {
      putPluValues(_csplus);
    });
  }

  @override
  void onPluListError(String error) {
    setState(() {
      putMeberClearValues();
    });
  }

  @override
  void onPluListSuccess(List<CsPlu> _cspluslist) {
    setState(() {
      showPluResult(_cspluslist);
    });
  }

  @override
  void onESCPOSSuccess(Uint8List pdfFile) {
    //PosControlFnc().nextRunno(context, MyConfig().a_cycleRcptBegEnd);
    //printOut(pdfFile);
  }

  void printOut(Uint8List pdfFile) async {
    pdfDialog(context, 'checkPrintFormId', pdfFile);
  }

  @override
  void onESCPOSError(String error) {}

  @override
  void onPromoListError(String error) {
    setState(() {
      clsPromoValues();
    });
  }

  @override
  void onPromoListSuccess(List<PluPrice> promoList) {
    setState(() {
      putPromoValues(promoList[0]);
    });
  }
}
