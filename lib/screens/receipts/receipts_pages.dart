import 'dart:typed_data';
import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/possalesfnc.dart';
import 'package:com_csith_geniuzpos/models/ccps/ccp.dart';
import 'package:com_csith_geniuzpos/models/persons/psmember.dart';
import 'package:com_csith_geniuzpos/models/posmodels/vatExcluded.dart';
import 'package:com_csith_geniuzpos/models/possales/salesItemSummary.dart';
import 'package:com_csith_geniuzpos/models/possales/salesitems.dart';
import 'package:com_csith_geniuzpos/reports/pdfprinting/pdfprintctrl.dart';
import 'package:com_csith_geniuzpos/resources/csiconfig.dart';
import 'package:com_csith_geniuzpos/resources/fnccal.dart';
import 'package:com_csith_geniuzpos/screens/cardscoupons/components/ccp_searchresult.dart';
import 'package:com_csith_geniuzpos/services/response/posdata_response.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:promptpay/promptpay.dart';
import 'package:promptpay/promptpay_data.dart';
import 'package:com_csith_geniuzpos/services/response/ccp_response.dart';
import 'package:com_csith_geniuzpos/services/response/escpos_response.dart';
import 'package:com_csith_geniuzpos/services/response/posbdc_response.dart';
import 'package:com_csith_geniuzpos/services/response/poscontrol_response.dart';

import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:com_csith_geniuzpos/services/response/posrcp_response.dart';
import 'package:com_csith_geniuzpos/utility/normal_dialog.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/curve_button.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/resources/styles.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:promptpay/promptpay.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'components/receipts_btns.dart';
import 'components/receipts_list.dart';
import 'components/receipts_listtitle.dart';
import 'components/receipts_numpad.dart';

class ReceiptsPages extends StatefulWidget {
  final Function doact;
  ReceiptsPages(this.doact);
  @override
  _ReceiptsPages createState() => _ReceiptsPages();
}

class _ReceiptsPages extends State<ReceiptsPages>
    implements
        PosFncCallBack,
        GetSearchCCPCallBack,
        PosSumCallBack,
        PosSumBdcCallBack,
        PosRCPAddNew,
        PosFncVoidRCP,
        POSprintCallBack,
        GetSalSUmItemCallBack,
        GetVatExcludedCallBack,
        PosSaveCallBack {
  PosFncCallResponse _responseInput;
  GetSearchCCPResponse _responseCCP;
  PosSumSalesItemCallResponse _responseSumSalItem;
  PosSumBdcItemCallResponse _responseSumBdcItem;
  PosRCPAddNewCallResponse _responseAddNew;
  PosFncVoidRCPResponse _responseVoidAitem;
  POSprintResponse _responseEscPos;
  GetPSalSUmItemResponse _responseSafeSummary;
  GetVatExcludedResponse _responseVatExcluded;
  PosSaveCallResponse _responsePosSave;
  TextEditingController activeTxt;
  SalesItemSummary _sumSalesItems;
  SalesItems selectSalesitem;
  int _lastsalesitemid, currentitem;
  String checkPrintFormId;
  PosInput _posinput;
  String paytype, saledesc, receiptKeyIn, exVatDesc;
  double excRate, vatExCluded, netsales;
  int stepmode;
  //---setup variable ans response---
  _ReceiptsPages() {
    _responseInput = new PosFncCallResponse(this);
    _responseCCP = new GetSearchCCPResponse(this);
    _responseSumSalItem = new PosSumSalesItemCallResponse(this);
    _responseSumBdcItem = new PosSumBdcItemCallResponse(this);
    _responseAddNew = new PosRCPAddNewCallResponse(this);
    _responseVoidAitem = new PosFncVoidRCPResponse(this);
    _responseEscPos = new POSprintResponse(this);
    _responseSafeSummary = new GetPSalSUmItemResponse(this);
    _responseVatExcluded = new GetVatExcludedResponse(this);
    _responsePosSave = new PosSaveCallResponse(this);
    _posinput = new PosInput();
  }
  PsMember psMember;
  FocusNode fcn1, fcn2, fcn3, fcn4, fcn5, fcn6, fcn7, fcn8, fcn9;
  String memberImgUrl;
  int modeInputByType;
  String inmodeByType = '';
  //--SalesVatType
  //---I-inclusive vat (amount * vatrate / (100+vatrate))
  //---E-exclusive vat (amount * vatrate)
  String IEmode = 'I'; // = PosControlFnc().getSalesVateType(context)
  //-----Initial variables
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
    _responseSumSalItem.doCalSalesItemSum(context);
    _responseSumBdcItem.doCalBDCItemSum(context);
    //_responsePosSave.SavePosTrans(context, 20);
    stepmode = _posinput.bdcitemCount(context);
    modeInputByType = 0;
    inmodeByType = '';
    saledesc = '';
    excRate = 1;
    exVatDesc = '';
    vatExCluded = 0;
    IEmode = PosControlFnc().getSalesVateType(context);
    if (IEmode != 'I' && vatExCluded == 0) {
      widget.doact();
      String url = PosControlFnc().getVatExurl(context);
      _responseVatExcluded.getVatEx(url);
    }
    super.initState();
  }

  @override
  void onSearchCCPError(String error) {}

  @override
  void onSearchCCPSuccess(CardsCoupon cardsCoupon) {
    if (cardsCoupon != null) {
      putCCPValues(cardsCoupon);
    } else {
      //  putClearValues();
    }
  }

  @override
  void onCallSumSalesItemError(String error) {
    // normalDialog(context, error);
  }

  @override
  void onCallSumSalesItemSuccess(SalesItemSummary result) {
    setState(() {
      netsales = result.totalamount;
      rcpSetLoad(netsales);
    });
    _sumSalesItems = result;
    _responseSafeSummary.upACMSalSum(context, result);
  }

  @override
  void onCallSumBdcItemError(String error) {}

  @override
  void onCallSumBdcItemSuccess(SalesItemSummary result) {
    if (result != null) {
      setState(() {
        double _fixT = (_posinput.txt1.text.isEmpty)
            ? 0.0
            : double.parse(_posinput.txt1.text.replaceAll(',', ''));
        netsales = _fixT + result.totalamount;
        rcpSetLoad(netsales);
      });
      //_responseUpdateACM.upACMSalSum(context, result);
    }
  }

  @override
  void onCallPosFncAddNewError(String error) {}

  @override
  void onCallPosFncAddNewSuccess(double amount) {
    setState(() {
      bdcSetAdd(amount);
      //txtinputEntry(_posinput.txt8.text);
    });
  }

  @override
  void onCallPosFncVrcpError() {}

  @override
  void onCallPosFncVrcpSuccess(double amount) {
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
  void onCallPosFncError(String error) {}

  @override
  void onCallPosFncSuccess(String result) {
    setState(() {
      txtinputEntry(result);
    });
  }

  @override
  void onVatExcludedError(String error) {
    exVatDesc = '';
    setState(() {});
  }

  @override
  void onVatExcludedSuccess(List<VatExCluded> _vatExCluded) {
    if (_vatExCluded != null) {
      try {
        if (_vatExCluded.length > 0) {
          if (_vatExCluded[0].vatBillExClude != null) {
            vatExCluded = _vatExCluded[0].vatBillExClude;
          } else {
            vatExCluded = 0;
          }
          if (_vatExCluded[0].vatCharge != null) {
            vatExCluded += _vatExCluded[0].vatCharge;
          }
          exVatDesc = '\r\n[VATBASE:' +
              oCcy.format(netsales) +
              '+VAT:' +
              oCcy.format(vatExCluded) +
              ']';
          netsales += vatExCluded;
          rcpSetLoad(netsales);

          setState(() {});
        }
      } catch (e) {
        showToast(context, e.toString());
      }
    } else {
      exVatDesc = '\r\n               nocal.';
      setState(() {});
    }
  }

//-----------CAL FUNCITONS-------
  void rcpFixT(double loadamt) {
    double _fixT = (_posinput.txt1.text.isEmpty)
        ? 0.0
        : double.parse(_posinput.txt1.text.replaceAll(',', ''));
    _posinput.txt1.text = oCcy.format(loadamt);
  }

  void rcpTChg(double amt, int _even) {
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

  void rcpCalBalance() {
    double _fixT = (_posinput.txt1.text.isEmpty)
        ? 0.0
        : double.parse(_posinput.txt1.text.replaceAll(',', ''));
    double _tChg = (_posinput.txt2.text.isEmpty)
        ? 0.0
        : double.parse(_posinput.txt2.text.replaceAll(',', ''));
    double bal = _fixT - _tChg;
    _posinput.txt3.text = oCcy.format(bal);

    if (_fixT - _tChg < 0) {
      //saveData();
    }
  }

  void rcpSetLoad(double loadamt) {
    try {
      rcpFixT(loadamt);
      rcpTChg(0, 1);
      rcpCalBalance();
    } catch (e) {
      normalDialog(context, e.toString());
    }
  }

  void bdcSetAdd(double amount) {
    try {
      rcpTChg(amount, 2);
      rcpCalBalance();
    } catch (e) {
      normalDialog(context, e.toString());
    }
  }

  void bdcSetVoid(double amount) {
    try {
      rcpTChg(amount, 3);
      rcpCalBalance();
    } catch (e) {
      normalDialog(context, e.toString());
    }
  }

  void bdcSetRecal(double amount) {
    try {
      rcpTChg(amount, 4);
      rcpCalBalance();
    } catch (e) {
      normalDialog(context, e.toString());
    }
  }

  void printOut(Uint8List pdfFile) async {
    if (checkPrintFormId == '80mm_Pos') {
      await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => pdfFile);

      //----Clear  doc.items.all.type
      PosControlFnc().startSalesItem(context);
      //----NextRunning --- must check mode sales or refund ....
      _posinput.savePOSTrans(context, 0);

      PosControlFnc().nextRunno(context, MyConfig().a_cycleRcptBegEnd);
      //----
      Navigator.of(context).pop();
      try {
        // int stepmode = _posinput.bdcitemCount(context);
        if (stepmode > 0) {
          Navigator.of(context).pop();
        }
      } catch (e) {}
    } else if (checkPrintFormId == '80mm_Pos-V') {
      pdfDialog(context, checkPrintFormId, pdfFile);
    }
  }

  @override
  void onESCPOSSuccess(Uint8List pdfFile) {
    printOut(pdfFile);
  }

  @override
  void onESCPOSError(String error) {}

  @override
  void onGetSalSumError(String error) {
    //showToast(context, 'Saving error: ' + error);
  }

  @override
  void onGetSalSumSuccess(String ok) {}
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      // height: Palette.stdbutton_height * 9.6,
      // width: Palette.stdbutton_width * 13.6,
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
      // height: double.infinity,
      // width: double.infinity,
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
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0), child: receiptsTitle()),
        Container(child: totalDueForm()),
        Container(child: totalReceiptsForm()),
        Container(child: totalBalanceForm()),
        Container(
            child: (modeInputByType == 0) //blank
                ? Container()
                : (modeInputByType == 1) //2 credit card,3-debit card
                    ? mcardEntryForm()
                    : (modeInputByType == 2) //4 - cash coupon, 5-cash card
                        ? mcouponEntryForm()
                        : (modeInputByType ==
                                3) //3-exchange, ...next receipt other
                            ? mcurrencyEntryForm()
                            : mOtherEntryForm()),
        Container(child: rcvEntrytxt8Form()),
        Container(child: receiptlistTitle()),
        Container(child: receiptsList()),
        Positioned(
            top: 0, left: 360, child: receipts11Btns(context, _responseInput)),
        Positioned(
            top: 280,
            left: 360,
            child: receiptsNumpad(context, _responseInput)),
      ]),
    );
  }

  Widget receiptsTitle() {
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
                      text: Palette.receipts_title,
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

  Widget totalDueForm() {
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
                                text: Palette.receipts_totaldue,
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
                                text: Palette.receipts_totaldueE,
                                //   ? Palette.receipts_totaldueE
                                //  : Palette.receipts_totaldueE + exVatDesc,
                                style: TextStyle(
                                  fontFamily: 'Tahoma',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.black,
                                )),
                            TextSpan(
                                text: (IEmode == 'I') ? '' : exVatDesc,
                                style: TextStyle(
                                  fontFamily: 'Tahoma',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11,
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
              readOnly: true,
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

  Widget totalReceiptsForm() {
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
                                text: Palette.receipts_totalreceipts,
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
                                  text: Palette.receipts_totalreceiptsE,
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
              readOnly: true,
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

  Widget totalBalanceForm() {
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
                                text: Palette.receipts_balance,
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
                        width: Palette.stdbutton_width * 3.6,
                        height: Palette.stdbutton_height * 1.2,
                        padding: const EdgeInsets.all(1),
                        child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            text: '',
                            children: <TextSpan>[
                              TextSpan(
                                  text: Palette.receipts_balanceE,
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
              readOnly: true,
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

  Widget mcardEntryForm() {
    inmodeByType = 'DBCD';
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
                                        text: Palette.receipts_mcardtype,
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
                      focusNode: fcn5,
                      controller: _posinput.txt4,
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
                                        text: Palette.receipts_mcardid,
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
                      focusNode: fcn6,
                      controller: _posinput.txt5,
                      textAlignVertical: TextAlignVertical.top,
                      textAlign: TextAlign.right,
                      onChanged: (text) {},
                      onSubmitted: (result) {
                        fcn7.requestFocus();
                      },
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
                                        text: Palette.receipts_mcardexpd,
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
                      focusNode: fcn7,
                      controller: _posinput.txt6,
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
                                        text: Palette.receipts_mcardcode,
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
                      focusNode: fcn8,
                      controller: _posinput.txt7,
                      onChanged: (text) {},
                      onSubmitted: (result) {
                        fcn9.requestFocus();
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

  Widget mcouponEntryForm() {
    inmodeByType = 'COUPON';
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
                                        text: Palette.receipts_mcoupuntype,
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
                    width: Palette.stdbutton_width * 3.4,
                    height: Palette.onelineheigth() * 0.5,
                    child: TextField(
                      autofocus: true,
                      focusNode: fcn5,
                      controller: _posinput.txt4,
                      onChanged: (text) {},
                      onSubmitted: (result) {
                        fcn6.requestFocus();
                      },
                      textAlignVertical: TextAlignVertical.top,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.5,
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
                                        text: Palette.receipts_mcoupunid,
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
                      focusNode: fcn6,
                      controller: _posinput.txt5,
                      onChanged: (text) {},
                      onSubmitted: (result) {
                        fcn7.requestFocus();
                      },
                      textAlignVertical: TextAlignVertical.top,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.5,
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
                                        text: Palette.receipts_mcardexpd,
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
                      focusNode: fcn7,
                      controller: _posinput.txt6,
                      onChanged: (text) {},
                      onSubmitted: (result) {
                        fcn8.requestFocus();
                      },
                      textAlignVertical: TextAlignVertical.top,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.5,
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

  Widget mOtherEntryForm() {
    inmodeByType = 'COUPON';
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
                                        text: Palette.receipts_mOthertype,
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
                      focusNode: fcn5,
                      controller: _posinput.txt4,
                      onChanged: (text) {},
                      onSubmitted: (result) {
                        fcn6.requestFocus();
                      },
                      textAlignVertical: TextAlignVertical.top,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.5,
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
                                        text: Palette.receipts_mOtherid,
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
                      focusNode: fcn6,
                      controller: _posinput.txt5,
                      onChanged: (text) {},
                      onSubmitted: (result) {
                        fcn7.requestFocus();
                      },
                      textAlignVertical: TextAlignVertical.top,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.5,
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
                                        text: Palette.receipts_mOtherdate,
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
                      focusNode: fcn7,
                      controller: _posinput.txt6,
                      onChanged: (text) {},
                      onSubmitted: (result) {
                        fcn8.requestFocus();
                      },
                      textAlignVertical: TextAlignVertical.top,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.5,
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

  Widget mcurrencyEntryForm() {
    inmodeByType = 'CURRENCY';
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
                                        text: Palette.receipts_mcurrencytype,
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
                      focusNode: fcn5,
                      controller: _posinput.txt4,
                      textAlignVertical: TextAlignVertical.top,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.5,
                        color: Colors.black,
                      ),
                      onChanged: (text) {},
                      onSubmitted: (result) {
                        fcn6.requestFocus();
                      },
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
                                        text: Palette.receipts_mcurrencyRate,
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
                      focusNode: fcn6,
                      controller: _posinput.txt5,
                      onChanged: (text) {},
                      textAlignVertical: TextAlignVertical.top,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.red,
                      ),
                      onSubmitted: (result) {
                        fcn7.requestFocus();
                      },
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
                                        text: Palette.receipts_mcurrencydate,
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
                    height: Palette.onelineheigth() * 0.8,
                    child: TextField(
                      autofocus: true,
                      focusNode: fcn7,
                      controller: _posinput.txt6,
                      onChanged: (text) {},
                      onSubmitted: (result) {
                        // fcn8.requestFocus();
                      },
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.5,
                        color: Colors.black,
                      ),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        // contentPadding: const EdgeInsets.all(10.0),
                        labelStyle: TextStyle(color: Colors.grey),
                        labelText: '',
                        // fillColor: Colors.transparent,
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

  Widget receiptlistTitle() {
    return Stack(children: [
      Positioned(
        top: 378,
        left: 12,
        child: receiptsListTitle(),
      ),
    ]);
  }

  Widget receiptsList() {
    return Stack(children: [
      Positioned(
        top: 410,
        left: 12,
        child: ReceiptsItem(),
      ),
    ]);
  }

  Widget rcvEntrytxt8Form() {
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
                                text: Palette.receipts_label,
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
            width: Palette.stdbutton_width * 2.2,
            height: Palette.onelineheigth() * 0.8,
            //padding: const EdgeInsets.all(1)
            child: TextField(
              autofocus: true,
              focusNode: fcn9,
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

  void closeMe() async {
    try {
      PosControlFnc().startSalesItem(context);
      PosControlFnc().nextRunno(context, MyConfig().a_cycleRcptBegEnd);
    } catch (e) {
      showToast(context, 'closeMe:' + e.toString());
    }
  }

  Future<void> showPopupTask(BuildContext context, String ccpType) async {
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
                      ccType: ccpType),
                ),
              ],
            ),
          );
        });
  }

  void changeDialog(BuildContext context, String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => SimpleDialog(
        title: Container(
          height: Palette.stdbutton_height * 2.8,
          width: Palette.stdbutton_height * 5.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.white, spreadRadius: 20),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                left: 50,
                top: 0,
                child: Text('ยอดทอนเงิน (CHANGE)\r\n',
                    style: TextStyle(
                      fontFamily: 'Tahoma',
                      fontWeight: FontWeight.w400,
                      fontSize: 30,
                      color: Colors.black,
                    )),
              ),
              Positioned(
                left: 20,
                top: 75,
                child: Container(
                  width: Palette.stdbutton_height * 5.9,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: '',
                      children: <TextSpan>[
                        TextSpan(
                            text: message,
                            style: TextStyle(
                              fontFamily: 'Tahoma',
                              fontWeight: FontWeight.w400,
                              fontSize: 64,
                              color: Colors.black,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    savePosTran();
                    //printing();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'กรุณาปิดลิ้นชัก , คลิก หรือ กดปุ่มใดๆ เพื่อทำงานต่อไป',
                    style: TextStyle(
                      fontFamily: 'Tahoma',
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }

  void qrPayDialog(BuildContext context, double amount) {
    final String qrPayNumber = PosControlFnc().getQRPayNumber(context);
    // final qrData = PromptPay.generateQRData(qrPayNumber,
    //     amount: double.parse(amount.replaceAll(',', '')));
    // final qrData = PosControlFnc().getQrPayData(qrPayNumber, amount);
    // normalDialog(context, qrData);

    final qrData = PromptPay.generateQRData(qrPayNumber, amount: amount);
    // normalDialog(context, qrData);
    // bool isQRValid = PromptPay.isQRDataValid(newQRCode);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => SimpleDialog(
        title: Container(
          height: Palette.stdbutton_height * 3.8,
          width: Palette.stdbutton_height * 3.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.white, spreadRadius: 20),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                left: 40,
                top: 0,
                child: Container(
                  width: Palette.stdbutton_height * 3.2,
                  height: Palette.stdbutton_height * 3.2,
                  child: QrImage(
                    data: qrData,
                    version: QrVersions.auto,
                    size: 320.0,
                    gapless: true,
                    embeddedImage:
                        new ExactAssetImage('assets/menu-icon/menu-logo.png'),
                    embeddedImageStyle: QrEmbeddedImageStyle(
                      size: Size(40, 40),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'ยกเลิก   ',
                    style: TextStyle(
                      fontFamily: 'Tahoma',
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: Colors.red,
                    ),
                  )),
              Text(
                '   รับชำระเงิน ->\r\nด้วย QRpay  ',
                style: TextStyle(
                  fontFamily: 'Tahoma',
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                  color: Colors.green,
                ),
              ),
              TextButton(
                  onPressed: () {
                    receiptQrPay(qrPayNumber);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    '  ยืนยัน\r\nรับชำระเงิน',
                    style: TextStyle(
                      fontFamily: 'Tahoma',
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: Colors.blue,
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }

  void promptPayDialog(BuildContext context, String amount) {
    final String promptPayNumber = PosControlFnc().getPromptPayNumber(context);
    final qrData = PromptPay.generateQRData(promptPayNumber,
        amount: double.parse(amount.replaceAll(',', '')));

    // bool isQRValid = PromptPay.isQRDataValid(newQRCode);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => SimpleDialog(
        title: Container(
          height: Palette.stdbutton_height * 3.8,
          width: Palette.stdbutton_height * 3.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.white, spreadRadius: 20),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                left: 40,
                top: 0,
                child: Container(
                  width: Palette.stdbutton_height * 3.2,
                  height: Palette.stdbutton_height * 3.2,
                  child: QrImage(
                    data: qrData,
                    version: QrVersions.auto,
                    size: 320.0,
                    gapless: true,
                    embeddedImage:
                        new ExactAssetImage('assets/menu-icon/menu-logo.png'),
                    embeddedImageStyle: QrEmbeddedImageStyle(
                      size: Size(40, 40),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'ยกเลิก   ',
                    style: TextStyle(
                      fontFamily: 'Tahoma',
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: Colors.red,
                    ),
                  )),
              Text(
                '   รับชำระเงิน ->\r\nด้วยพร้อมพ์เพย์  ',
                style: TextStyle(
                  fontFamily: 'Tahoma',
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                  color: Colors.green,
                ),
              ),
              TextButton(
                  onPressed: () {
                    receiptPromptPay(promptPayNumber);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    '  ยืนยัน\r\nรับชำระเงิน',
                    style: TextStyle(
                      fontFamily: 'Tahoma',
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: Colors.blue,
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }

  void receiptPromptPay(String acno) {
    paytype = '8';
    double balance;
    if (_posinput.txt8.text.trim() == "") {
      balance = double.parse(_posinput.txt3.text.replaceAll(',', ''));
    } else {
      balance = double.parse(_posinput.txt8.text.replaceAll(',', ''));
    }
    addReceiptQR(balance,
        'PROMPTPAY#' + acno.replaceRange(acno.length - 4, acno.length, '****'));
  }

  void receiptQrPay(String acno) {
    paytype = '9';
    double balance;
    if (_posinput.txt8.text.trim() == "") {
      balance = double.parse(_posinput.txt3.text.replaceAll(',', ''));
    } else {
      balance = double.parse(_posinput.txt8.text.replaceAll(',', ''));
    }
    addReceiptQR(balance,
        'QRPAY#' + acno.replaceRange(acno.length - 4, acno.length, '****'));
  }

  void addReceiptQR(double befbal, String btncmd) {
    try {
      if (_responseAddNew != null) {
        currentitem += 1;
        SalesItems _result;

        List<String> chkmenu;
        if (btncmd != null) {
          chkmenu = btncmd.split('#');

          saledesc = btncmd;
        } else {
          chkmenu = null;
          btncmd = saledesc;
        }

        if (chkmenu != null && chkmenu.length > 1) {
          //---add paytype to unit!
          _result = SalesItems(
              btncmd, '', 0, 0, btncmd, 0, befbal, 'RCP', paytype, 0);
        }

        setState(() {
          PosSalesFnc().addReceitpItem(context, _responseAddNew, _result);

          _posinput.txt8.text = '';
        });
      }
    } catch (e) {
      showToast(context, e.toString() + ' @addReceiptQR');
    }
  }

  //---------FNC funxtions handles
  void txtinputEntry(String result) {
    if (result != "") {
      if (result == "ENTERCASH") {
        //---CASH RECEIPT BUTTONS -- this specific case to save data
        //---but Other is the event flow just start only
        paytype = '1';
        modeInputByType = 0;
        if (_posinput.txt8.text.trim() == "") {
          addCashEnd();
        } else {
          addCash();
        }
      } else if (result == "ENTER") {
        modeInputByType = 0;
        if (_posinput.txt8.text.trim() == "" ||
            !_posinput.isNumeric(_posinput.txt8.text)) {
          showToast(context, 'pls fill with numeric amount only!');
        }
      } else if (result == "OK") {
        //---use in receipt form by payment type
        //---when confirm ok
        modeInputByType = 0;
        if (_posinput.txt8.text.trim() == "") {
          addEnd();
        } else {
          addOk();
        }
      } else if (result == "CASHCARD") {
        paytype = '5';
        modeInputByType = 2;
        showPopupTask(context, paytype);
//mcardEntryForm
      } else if (result == "CASHCOUPON") {
        paytype = '4';
        modeInputByType = 2;
        showPopupTask(context, paytype);
//mcouponEntryForm
      } else if (result == "CURRENCY") {
        // 1-รับเงืนสด กรณี มีlist มีกรณีเดียว คือ exchange
        paytype = '1';
        modeInputByType = 3;
        showPopupTask(context, paytype);
//
      } else if (result == "OTHERCASH") {
        paytype = '7';
        modeInputByType = 4;
        showPopupTask(context, paytype);
//mcardEntryForm
      } else if (result == "CREDITCARD") {
        paytype = '2';
        modeInputByType = 1;
        showPopupTask(context, paytype);
//mcardEntryForm
      } else if (result == "DEBITCARD") {
        paytype = '3';
        modeInputByType = 1;
        showPopupTask(context, paytype);
        //mcardEntryForm
      } else if (PosSalesFnc().funcBillRCPCall(
          context,
          result,
          _posinput.txt8,
          _posinput.txt9,
          _posinput.txt1,
          _posinput.txt2,
          _responseVoidAitem,
          _lastsalesitemid,
          currentitem,
          checkSum)) {
      } else if (result == "50") {
        setBath(result);
      } else if (result == "100") {
        setBath(result);
      } else if (result == "500") {
        setBath(result);
      } else if (result == "1000") {
        setBath(result);
      } else if ((result.indexOf(":") > 0)) {
        var comm = result.split(":");
        if (comm[1] == '3') {
        } else {
          if (comm[2] == 'END') {
            saveData();
          } else if (comm[2] == 'PROMPTPAY') {
            // showToast(context, 'PROMPT PAY');
            promptPayDialog(context, _posinput.txt3.text);
          } else if (comm[2] == 'QRCODEBNK') {
            // showToast(context, 'QRCODE PAYMENT');
            double amt = double.parse(_posinput.txt3.text.replaceAll(',', ''));
            qrPayDialog(context, amt);
          }
        }
      } else {
        modeInputByType = 0;
        _posinput.txt8.text = _posinput.txt8.text + result;
        _posinput.setActiveTxt(_posinput.txt8, fcn8);
      }
    }
  }

  void setBath(String result) {
    if (_posinput.isNumeric(_posinput.txt8.text)) {
      if (_posinput.isNumeric(result)) {
        _posinput.txt8.text = cno
            .format(double.parse(_posinput.txt8.text) + double.parse(result));
      } else {
        _posinput.txt8.text = '';
      }
    } else {
      _posinput.txt8.text = result;
    }
  }

  void saveData() {
    //---send data to server (boxsales,boxbdc,boxreceipt)
    //--(print when save success or before print?

    //--Specification :
    //--allocateBillDiscProcess()
    //--CalculateMemberPoint() --not implement now!
    //--CalculateBillVat(...)... Calvat()
    //--InsertPosTrans() [Total ->HD]sum() [Item -DT] ->DereiveComponentFromLineItem(...sales,discount, charge..)
    //--UpdateSalesToPosShiftControl()
    //--If PosProcessMode='I' ;
    //----if SalesMode = 1 (sales bill) =>PostSalesTransToStock()--not implement now
    //----els (return bill) => PostSalesRetnTranToStock() --not implement now
    //--if EjournalFg = 1 => SaveEjournal() --not implement now

    //--Design for Specification to Server Side
    //--Receive Trans Data -> (Salesitems(+ Discount, Charge) , BillItems, ReceiptItems)
    //--Start receive date...till end of data
    //----Receive Start Bill Save Status...
    //-------Temp Bill Recording...
    //----------Temp sales item (+discount, charge)
    //------------start/end ... Processing sales summary Data
    //-------------------- pack data to data string and will extract at receive data port!
    //@PosId+ ] + @Cashier+ ] + @saleItems+ ] +@plu +] +@qty
    //+]+ @price +]+ @discode +] +@amount +]+ @vatcode +]+ @unit

    //----------Temp bill disc/charge items
    //------------start/end ... Processing bill disc/charge summary Data
    //@PosId+ ] + @Cashier+ ] + @saleItems+ ] +@plu +] +@qty
    //+]+ @price +]+ @discode +] +@amount +]+ @vatcode +]+ @unit

    //----------Temp receipt items
    //------------start/end ... Processing receipts summary Data
    //@PosId+ ] + @Cashier+ ] + @saleItems+ ] +@plu +] +@qty
    //+]+ @price +]+ @discode +] +@amount +]+ @vatcode +]+ @unit

    //----Receive End Bill Save Status...
    //--when receipt finished will end of that bill then
    //--AllocateBillDiscProcess()
    //----action on UI process--must same as on slip printing out!
    //--Save to POS TRANSACTIONS (psPosTranHd,psPosTranDt,psPosTranDisc,psPosTranRecv)
    //--Update that PosShiftCtrl records with Total/Summary
    //--Write Ejournal (not implement now)

    //--SalesVatType
    //---I-inclusive vat (amount * vatrate / (100+vatrate))
    //---E-exclusive vat (amount * vatrate)
    // String IEmode = PosControlFnc().getSalesVateType(context);
    // if (IEmode == 'I') {
    String balstr = _posinput.txt3.text.replaceAll(',', '');
    double balance = double.parse(balstr);
    if (balance < 0) {
      changeDialog(context, oCcy.format((-1) * balance));
    } else {
      if (balance <= 0) {
        //save data to server request//
        savePosTran();
      } else {
        //  showToast(context, 'Not receipt finished!, please receipt more item.');
      }
    }
    // } else {
    //   //--must get salesitem  vat amount to add for balance!
    //   //(IEmode == 'I') ? 1 : 2
    //   double vatamt =
    //       _posinput.getVatAmountForExclusive(context, (IEmode == 'I') ? 1 : 2);
    //   String balstr = _posinput.txt3.text.replaceAll(',', '');
    //   double balance = double.parse(balstr) + vatamt;
    //   if (balance < 0) {
    //     changeDialog(context, oCcy.format((-1) * balance));
    //   } else {
    //     if (balance == 0) {
    //       //save data to server request//
    //       savePosTran();
    //     } else {
    //       showToast(
    //           context, 'Not receipt finished!, please receipt more item.');
    //     }
    //   }
    // }
  }

  void savePosTran() {
    try {
      _responsePosSave.SavePosTrans(context, 40);
    } catch (e) {
      showToast(context, e.toString() + ':savePosTran');
    }
    printing();
  }

  void printing() {
    checkPrintFormId = "80mm_Pos";
    _responseEscPos.posPrint(
        context, PdfPrintCtrl().format80mm, checkPrintFormId, 0, '');
  }

//---------------------
  void putCCPValues(CardsCoupon _cardcoupon) {
    //this data received from PaymentInfo List
    //  CardsCoupon cardsCoupon = CardsCoupon(
    //     ccpid: paymentInfo.code,
    //     ccpName: paymentInfo.detail,
    //     ccpType: paymentInfo.paytype, --- this use to run it's process
    //     ประเภทการรับชำระเงิน  แบ่งประเภทการชำระเงิน ดังนี้
    //  1 - เงินสด ทั้งสกุลบาท และ สกุลต่างประเทศ
    //      get exchange rate and fill to form , when ok will calculate to bath and keep currency to it's data
    //  2 - บัตรเครดิต
    //  3 - บัตรเดบิต
    //  4 - คูปองเงินสด
    //  5 - บัตรเงินสด
    //  6 - แต้มสะสม
    //  7 - อื่นๆ
    //--basic for all change form to it's form
    if (_cardcoupon != null) {
      String _paytype = _cardcoupon.ccpType;
      paytype = _cardcoupon.ccpType;
      putClearValues();
      saledesc = _cardcoupon.ccpName.trim();
      setState(() {
        if (_paytype == '1') {
          //Exchange
          //showToast(context, _cardcoupon.ccpName + ',' + _cardcoupon.expireDate);
          _posinput.txt4.text = _cardcoupon.ccpName;
          _posinput.txt5.text = oCcy.format(_cardcoupon.ccpAmount);
          receiptKeyIn = _posinput.txt8.text;
          double value = double.parse(_posinput.txt8.text.replaceAll(',', ''));
          excRate = _cardcoupon.ccpAmount;
          _posinput.txt6.text = _cardcoupon.expireDate;
        } else if (_paytype == '2') {
          //credit card
          _posinput.txt4.text = _cardcoupon.ccpName;
          _posinput.txt5.text = '';
          _posinput.txt6.text = '';
          _posinput.txt7.text = '';
        } else if (_paytype == '3') {
          //debit card
          _posinput.txt4.text = _cardcoupon.ccpName;
          _posinput.txt5.text = '';
          _posinput.txt6.text = '';
          _posinput.txt7.text = '';
        } else if (_paytype == '4') {
          //--cash coupon
          _posinput.txt4.text = _cardcoupon.ccpName;
          // saledesc = _cardcoupon.ccpName.trim() +
          //     '#' +
          //     oCcy.format(_cardcoupon
          //         .ccpAmount); // + ':' + oCcy.format(_cardcoupon.ccpAmount);
          if (_cardcoupon.ccpNumber == '2') {
            //value is percent of payment from balance
            double value =
                double.parse(_posinput.txt3.text.replaceAll(',', ''));
            if (value != null) {
              _posinput.txt8.text =
                  oCcy.format(value * _cardcoupon.ccpAmount / 100);
            }
          } else if (_cardcoupon.ccpNumber == '1') {
            _posinput.txt8.text = oCcy.format(_cardcoupon.ccpAmount);
          } else {
            _posinput.txt8.text = '';
          }

          _posinput.txt6.text = _cardcoupon.expireDate;
          _posinput.txt7.text = '';
        } else if (_paytype == '5') {
          //--cash card
          _posinput.txt4.text = _cardcoupon.ccpName;
          _posinput.txt8.text = oCcy.format(_cardcoupon.ccpAmount);
          _posinput.txt6.text = _cardcoupon.expireDate;
          _posinput.txt7.text = '';
        } else if (_paytype == '7') {
          //--other receipt
          _posinput.txt4.text = _cardcoupon.ccpName;
          _posinput.txt5.text = '';
          _posinput.txt6.text = '';
          _posinput.txt7.text = '';
          // } else if (_paytype == '8') { //prompt pay
          //  } else if (_paytype == '9') { //qr code pay

        }
      });
    }
  }

  void putClearValues() {
    saledesc = '';
    setState(() {
      _posinput.txt4.text = '';
      _posinput.txt5.text = '';
      _posinput.txt6.text = '';
      _posinput.txt7.text = '';
    });
  }

  bool checkSum() {
    return (_posinput.rcpitemCount(context) > 0);
  }

  void addCash() {
    double balance = double.parse(_posinput.txt3.text.replaceAll(',', ''));
    if (balance <= 0) {
      showToast(context, 'Cannot  receipt more! ');
    } else {
      double receiptAmt;
      paytype = '1';

      selectSalesitem = null;
      receiptAmt = double.parse(_posinput.txt8.text.replaceAll(',', ''));
      if (!verifyRA(balance, receiptAmt)) {
        saledesc = 'CASH' + '#';
        selectSalesitem = SalesItems(
            saledesc, 'CASH', 0, 0, '', 0, receiptAmt, 'RCP', paytype, 0);
      } else {
        showToast(
            context, 'Over amount of receipt! (>1000) please fill again.');
      }
      if (selectSalesitem != null) {
        setState(() {
          PosSalesFnc()
              .addReceitpItem(context, _responseAddNew, selectSalesitem);

          _posinput.txt8.text = '';
        });
      }
      if (receiptAmt >= balance) {
        saveData();
      }
    }
  }

  void addCashEnd() {
    double balance = double.parse(_posinput.txt3.text.replaceAll(',', ''));
    if (balance <= 0) {
      showToast(context, 'Cannot  receipt more! ');
    } else {
      double receiptAmt;
      selectSalesitem = null;
      paytype = '1';
      _posinput.txt8.text = _posinput.txt3.text;
      receiptAmt = double.parse(_posinput.txt8.text.replaceAll(',', ''));
      if (!verifyRA(balance, receiptAmt)) {
        //--paytype in {2,3,4,5,6,7}
        saledesc = 'CASH' + '#';
        selectSalesitem = SalesItems(
            saledesc, 'CASH', 0, 0, '', 0, receiptAmt, 'RCP', paytype, 0);
      } else {
        showToast(
            context, 'Over amount of receipt! (>1000)  please fill again.');
      }
      if (selectSalesitem != null) {
        setState(() {
          PosSalesFnc()
              .addReceitpItem(context, _responseAddNew, selectSalesitem);

          _posinput.txt8.text = '';
        });
      }
      if (receiptAmt >= balance) {
        saveData();
      }
    }
  }

  void addOk() {
    double balance = double.parse(_posinput.txt3.text.replaceAll(',', ''));
    if (balance <= 0) {
      showToast(context, 'Cannot  receipt more! ');
    } else {
      double receiptAmt;
      selectSalesitem = null;
      if (paytype == '1') {
        //exchange save
        receiptAmt =
            double.parse(_posinput.txt8.text.replaceAll(',', '')) * excRate;
        if (!verifyRA(balance, receiptAmt)) {
          saledesc = _posinput.txt4.text +
              '#' +
              _posinput.txt5.text +
              '@' +
              _posinput.txt8.text;
          selectSalesitem = SalesItems(saledesc, _posinput.txt4.text, 0, 0,
              _posinput.txt5.text, 0, receiptAmt, 'RCP', paytype, 0);
        } else {
          showToast(
              context, 'Over amount of receipt! (>1000) please fill again.');
        }
      } else {
        receiptAmt = double.parse(_posinput.txt8.text.replaceAll(',', ''));
        if (!verifyRA(balance, receiptAmt)) {
          //--paytype in {2,3,4,5,6,7}
          saledesc = _posinput.txt4.text + '#' + _posinput.txt5.text;
          selectSalesitem = SalesItems(saledesc, _posinput.txt4.text, 0, 0,
              _posinput.txt5.text, 0, receiptAmt, 'RCP', paytype, 0);
        } else {
          showToast(
              context, 'Over amount of receipt! (>1000)  please fill again.');
        }
      }
      if (selectSalesitem != null) {
        setState(() {
          PosSalesFnc()
              .addReceitpItem(context, _responseAddNew, selectSalesitem);

          _posinput.txt8.text = '';
        });
      }
      if (receiptAmt >= balance) {
        saveData();
      }
    }
  }

  bool verifyRA(double balance, double receiptAmt) {
    return (receiptAmt - balance > 1000);
  }

  void addEnd() {
    double balance = double.parse(_posinput.txt3.text.replaceAll(',', ''));
    if (balance <= 0) {
      showToast(context, 'Cannot  receipt more! ');
    } else {
      double receiptAmt;
      selectSalesitem = null;
      if (paytype == '1') {
        //exchange save
        _posinput.txt8.text = _posinput.txt3.text;
        String excAmt = c2rnd.format(
            double.parse(_posinput.txt8.text.replaceAll(',', '')) / excRate);
        receiptAmt = double.parse(_posinput.txt8.text.replaceAll(',', ''));
        saledesc =
            _posinput.txt4.text + '#' + _posinput.txt5.text + '@' + excAmt;
        selectSalesitem = SalesItems(saledesc, _posinput.txt4.text, 0, 0,
            _posinput.txt5.text, 0, receiptAmt, 'RCP', paytype, 0);
      } else {
        _posinput.txt8.text = _posinput.txt3.text;
        receiptAmt = double.parse(_posinput.txt8.text.replaceAll(',', ''));
        if (!verifyRA(balance, receiptAmt)) {
          //--paytype in {2,3,4,5,6,7}
          saledesc = _posinput.txt4.text + '#' + _posinput.txt5.text;
          selectSalesitem = SalesItems(saledesc, _posinput.txt4.text, 0, 0,
              _posinput.txt5.text, 0, receiptAmt, 'RCP', paytype, 0);
        } else {
          showToast(
              context, 'Over amount of receipt! (>1000)  please fill again.');
        }
      }
      if (selectSalesitem != null) {
        setState(() {
          PosSalesFnc()
              .addReceitpItem(context, _responseAddNew, selectSalesitem);

          _posinput.txt8.text = '';
        });
      }
      if (receiptAmt >= balance) {
        saveData();
      }
    }
  }

  @override
  void onCallPosSaveError(String error) {}

  @override
  void onCallPosSaveSuccess(int result) {}
}
