import 'dart:typed_data';
import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/reports/pdfprinting/pdfprintctrl.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/resources/styles.dart';
import 'package:com_csith_geniuzpos/screens/mainmenus/posmenubtn.dart';
import 'package:com_csith_geniuzpos/services/response/escpos_response.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/actdo_buttons.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/curve_button.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/position_btnFix.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/position_button.dart';
import 'package:com_csith_geniuzpos/widgets/oldwidgets/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

Future<void> normalDialog(BuildContext context, String message) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(message),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.red),
                ))
          ],
        )
      ],
    ),
  );
}

Future<void> waitForDialog(
    BuildContext context, String message, Function actdo) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(message),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () {
                  actdo();
                  //Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.blue),
                )),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red),
                ))
          ],
        )
      ],
    ),
  );
}

int showAlertDialog(
    BuildContext context, String title, String subtitle, String detail) {
  // set up the buttons
  int result = -1;
  Widget remindButton = TextButton(
    child: Text(title),
    onPressed: () {
      return -1;
    },
  );
  Widget cancelButton = TextButton(
    child: Text("Calcel"),
    onPressed: () {
      return 0;
    },
  );
  Widget launchButton = TextButton(
    child: Text("O.K."),
    onPressed: () {
      Navigator.of(context).pop();
      return 1;
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(detail),
    actions: [
      // remindButton,
      cancelButton,
      launchButton,
    ],
  );
  // show the dialog
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Future<void> showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text('This is a demo alert dialog.'),
              Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Confirm'),
            onPressed: () {
              print('Confirmed');
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> pdfDialog(
    BuildContext context, String title, Uint8List pdfFile) async {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        insetAnimationDuration: const Duration(milliseconds: 100),
        child: Container(
          height: Palette.stdbutton_height * 9.8,
          width: Palette.stdbutton_width * 7.2,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  height: Palette.stdbutton_height * 9.8,
                  width: Palette.stdbutton_width * 7.2,
                  child: PdfPreview(
                    build: (format) => pdfFile,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'X',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )),
              )
            ],
          ),
        ),
      );
    },
  );
}

void specialDialog(BuildContext context, String message,
    POSprintResponse _responseEscPos, String checkPrintFormId) {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: Container(
        height: Palette.stdbutton_height * 2.8,
        width: Palette.stdbutton_height * 5.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.white, spreadRadius: 3),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              left: 50,
              top: -10,
              child: Text('ยอดทอนเงิน (CHANGE)\r\n',
                  style: TextStyle(
                    fontFamily: 'Tahoma',
                    fontWeight: FontWeight.w400,
                    fontSize: 36,
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
                  _responseEscPos.posPrint(context, PdfPrintCtrl().format80mm,
                      checkPrintFormId, 0, '');
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

void showToast(BuildContext context, String msg) {
  final scaffold = ScaffoldMessenger.of(context);

  scaffold.showSnackBar(
    SnackBar(
      content: Text(msg),
      // duration: const Duration(minutes: 1),
      action: SnackBarAction(
          label: 'SEE AGAIN', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}

showVoidBySelectDialog(BuildContext context, int salesitemIndex,
    PosFncCallResponse responseInput) {
  Widget voidTitle = Column(
    children: [
      Container(
        height: Palette.stdbutton_height * 0.6,
        width: Palette.stdbutton_width * 6.1,
        decoration: BoxDecoration(
          color: Palette.stdbutton_theme_5,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(color: Colors.white, spreadRadius: 6),
          ],
        ),
        child: Center(
          child: Text(Palette.lbl_voidTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Tahoma',
                fontWeight: FontWeight.w500,
                fontSize: 24,
                color: Colors.black,
              )),
        ),
      ),
    ],
  );

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        insetAnimationDuration: const Duration(milliseconds: 100),
        child: Container(
          height: Palette.stdbutton_height * 2.2,
          width: Palette.stdbutton_width * 6.26,
          child: Stack(
            children: [
              Positioned(
                top: 1,
                left: 6,
                child: voidTitle,
              ),
              positionPosButtons(
                  context, responseInput, stdButtuon9, 60, 20, 15),
              positionPosButtons(
                  context, responseInput, stdButtuon9, 60, 180, 16),
              positionPosButtons(
                  context, responseInput, stdButtuon9, 60, 340, 17),
            ],
          ),
        ),
      );
    },
  );
}

showConfirmDialog(BuildContext context, Function actdo) {
  Widget confirmTitle = Column(
    children: [
      Container(
        height: Palette.stdbutton_height * 0.6,
        width: Palette.stdbutton_width * 6.1,
        decoration: BoxDecoration(
          color: Palette.stdbutton_theme_5,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(color: Colors.white, spreadRadius: 6),
          ],
        ),
        child: Center(
          child: Text(Palette.lbl_voidConfirmTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Tahoma',
                fontWeight: FontWeight.w500,
                fontSize: 24,
                color: Colors.black,
              )),
        ),
      ),
    ],
  );

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        insetAnimationDuration: const Duration(milliseconds: 100),
        child: Container(
          height: Palette.stdbutton_height * 2.2,
          width: Palette.stdbutton_width * 6.26,
          child: Stack(
            children: [
              Positioned(
                top: 1,
                left: 6,
                child: confirmTitle,
              ),
              actdoButtons(context, actdo, stdButtuon0[3], 46, 60,
                  Palette.stdbutton_width, Palette.stdbutton_height * 1.5),
              actdoButtons(context, null, stdButtuon0[4], 46, 360,
                  Palette.stdbutton_width, Palette.stdbutton_height * 1.5),
            ],
          ),
        ),
      );
    },
  );
}

showRefundEnterDialog(BuildContext context, int salesitemIndex,
    PosInput _posinput, PosFncCallResponse responseInput, String docno) {
  int mode = PosControlFnc().getBillmode(context);
  if (_posinput.txt9 == null) {
    _posinput.txt9 = new TextEditingController();
  }
  _posinput.txt9.text = docno;
  Widget refundTitle = Column(
    children: [
      Container(
        height: Palette.stdbutton_height * 0.6,
        width: Palette.stdbutton_width * 6.1,
        decoration: BoxDecoration(
          color: Palette.stdbutton_theme_5,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(color: Colors.white, spreadRadius: 6),
          ],
        ),
        child: Center(
          child: Text(Palette.lbl_refundTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Tahoma',
                fontWeight: FontWeight.w500,
                fontSize: 24,
                color: Colors.black,
              )),
        ),
      ),
    ],
  );
  Widget refundEnter = Column(
    children: [
      Container(
        height: Palette.stdbutton_height * 0.6,
        width: Palette.stdbutton_width * 6.1,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(color: Colors.white, spreadRadius: 6),
          ],
        ),
        child: new TextFormField(
          autofocus: true,
          controller: _posinput.txt9,
          //   focusNode: fcn1,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(8.0),
            labelStyle: TextStyle(color: Colors.grey),
            labelText: Palette.lbl_billno,
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: CsiStyle().primaryColor)),
          ),
        ),
      ),
    ],
  );

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        insetAnimationDuration: const Duration(milliseconds: 100),
        child: Container(
          height: Palette.stdbutton_height * 3,
          width: Palette.stdbutton_width * 6.26,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 6,
                child: refundTitle,
              ),
              Positioned(
                top: 60,
                left: 6,
                child: refundEnter,
              ),
              (mode == 1)
                  ? positionPosButtons(
                      context, responseInput, stdButtuon9, 120, 20, 18)
                  : Container(),
              (mode == 1)
                  ? positionPosButtons(
                      context, responseInput, stdButtuon9, 120, 180, 19)
                  : Container(),
              positionFixButtons(
                  context, responseInput, stdButtuon9, 120, 340, 17),
            ],
          ),
        ),
      );
    },
  );
}
