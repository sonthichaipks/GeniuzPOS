import 'dart:typed_data';
import 'package:com_csith_geniuzpos/data/posfunctions/fncitems.dart';
import 'package:com_csith_geniuzpos/models/posmodels/posshiftlogin.dart';
import 'package:com_csith_geniuzpos/reports/pdfprinting/pdfprintctrl.dart';
import 'package:com_csith_geniuzpos/resources/fnccal.dart';
import 'package:com_csith_geniuzpos/screens/searchplu/plu_info_ok.dart';
import 'package:com_csith_geniuzpos/services/response/escpos_response.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:com_csith_geniuzpos/utility/normal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/resources/styles.dart';

import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'components/cashio_numpad.dart';

class CashinoutPages extends StatefulWidget {
  final Function doact;
  final PosShiftLogin activeposShift;
  int mode; //1-Begin cash in, 2-cash in, 3-cash out
  CashinoutPages(this.doact, this.activeposShift, this.mode);
  @override
  _CashinoutPages createState() => _CashinoutPages();
}

class _CashinoutPages extends State<CashinoutPages>
    implements PosFncCallBack, POSprintCallBack {
  PosFncCallResponse _responseInput;
  TextEditingController activeTxt;
  POSprintResponse _responseEscPos;
  String checkPrintFormId;
  PosInput _posinput;

  _CashinoutPages() {
    _responseInput = new PosFncCallResponse(this);
    _responseEscPos = new POSprintResponse(this);
    _posinput = new PosInput();

    activeTxt = new TextEditingController();
  }

  FocusNode fcn8;

  @override
  void initState() {
    fcn8 = FocusNode();
    fcn8.requestFocus();
    checkPrintFormId = '';
    super.initState();
  }

  @override
  void dispose() {
    PosInput().focusnode.dispose();
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
        Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0), child: cashinoutTitle()),
        Container(child: cshEntryForm()),
        Positioned(
            top: 66, left: 0, child: cashioNumpad(context, _responseInput)),
      ]),
    );
  }

  Widget cashinoutTitle() {
    String _title = (widget.mode == 1)
        ? Palette.cashbeg_title
        : (widget.mode == 2)
            ? Palette.cashin_title
            : Palette.cashout_title;

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
                      text: _title,
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

  Widget cshEntryForm() {
    String _label = (widget.mode == 1)
        ? Palette.cashbeg_label
        : (widget.mode == 2)
            ? Palette.cashin_label
            : Palette.cashout_label;
    return Stack(
      children: [
        Positioned(
          top: 70,
          left: 80,
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
                                text: _label,
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
          top: 60,
          left: 240,
          child: Container(
            width: Palette.stdbutton_width * 4.1,
            height: Palette.onelineheigth() * 0.8,
            //padding: const EdgeInsets.all(1)
            child: TextField(
              autofocus: true,
              focusNode: fcn8,
              controller: activeTxt,
              onChanged: (text) {},
              onSubmitted: (result) {},
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
  }

  void txtinputEntry(String result) {
    if (result != "") {
      if (result == "OK") {
      } else if (result == "ENTER") {
        if (activeTxt.text != "" && _posinput.isNumeric(activeTxt.text)) {
          //  setBalance(double.parse(activeTxt.text));
          if (FncItems().isNumeric(activeTxt.text)) {
            // --- print slip by mode --
            // --- 1 - cash begin, 2-cash in, 3- cash out
            String docitemlabel;
            docitemlabel = (widget.mode == 1)
                ? Palette.lbl_cashbeg
                : (widget.mode == 2)
                    ? Palette.lbl_cashin
                    : Palette.lbl_cashout;
            checkPrintFormId = "80mm_CashIO";
            // PdfPageFormat format = new PdfPageFormat(
            //     Palette.stdbutton_width * 2.67, double.infinity,
            //     marginAll: 4);
            _responseEscPos.posPrint(context, PdfPrintCtrl().format80mm,
                checkPrintFormId, double.parse(activeTxt.text), docitemlabel);

            // --- then update
            widget.doact(widget.activeposShift, double.parse(activeTxt.text));
          }
        }
      } else if (result == "BACKSPACE") {
        var tl = activeTxt.text.length;
        if (tl > 0) {
          activeTxt.text = activeTxt.text.substring(0, tl - 1);
        } else {}
      } else if (result == "CLS") {
        activeTxt.text = "";
      } else if (result == "50") {
        setBath(result);
      } else if (result == "100") {
        setBath(result);
      } else if (result == "500") {
        setBath(result);
      } else if (result == "1000") {
        setBath(result);
      } else {
        activeTxt.text = activeTxt.text + result;
        //  _posinput.setActiveTxt(activeTxt, fcn8);
      }
    }
  }

  void setBath(String result) {
    if (_posinput.isNumeric(activeTxt.text)) {
      if (_posinput.isNumeric(result)) {
        activeTxt.text =
            cno.format(double.parse(activeTxt.text) + double.parse(result));
      } else {
        activeTxt.text = '';
      }
    } else {
      activeTxt.text = result;
    }
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
  void onESCPOSError(String error) {}

  @override
  void onESCPOSSuccess(Uint8List pdfFile) {
    //  pdfDialog(context, 'Hello world PDF', pdfFile);
    printOut(pdfFile);
  }

  void printOut(Uint8List pdfFile) async {
    if (checkPrintFormId == '80mm_CashIO') {
      await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => pdfFile);
    } else if (checkPrintFormId == '80mm_CashIO-V') {
      pdfDialog(context, checkPrintFormId, pdfFile);
    }
  }
}
