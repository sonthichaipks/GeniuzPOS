import 'dart:typed_data';

// import 'package:com_csith_geniuzpos/config/palette.dart';
// import 'package:com_csith_geniuzpos/reports/pdfprinting/pdfprintctrl.dart';
// import 'package:com_csith_geniuzpos/services/response/escpos_response.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/screens/poscontrol/posctrl_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:geniuzpos/services/response/escpos_response.dart';
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

void showAlertDialog(BuildContext context, String title, String subtitle,
    String detail, PosInput posresult) {
  // set up the buttons
  int result = -1;
  Widget remindButton = TextButton(
    child: Text(title),
    onPressed: () {
      result = -1;
      Navigator.of(context).pop();
    },
  );
  Widget cancelButton = TextButton(
    child: Text("Calcel"),
    onPressed: () {
      posresult.txt1.text = '0';
      Navigator.of(context).pop();
    },
  );
  Widget launchButton = TextButton(
    child: Text("O.K."),
    onPressed: () {
      result = -1;
      Navigator.of(context).pop();
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
  // return result;
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
                  // height: Palette.stdbutton_height * 9.6,
                  // width: Palette.stdbutton_width * 13.6,
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

void specialDialog(
    BuildContext context, String message, String checkPrintFormId) {
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
                  // _responseEscPos.PosPrint(context, PdfPrintCtrl().format80mm,
                  //     checkPrintFormId, 0, '');
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
      duration: const Duration(minutes: 1),
      action: SnackBarAction(
          label: 'SEE AGAIN', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}

// Image iconShow(int index) {
//   final CusIcon cusicon = cusIcons[0];
//   return Image.asset(cusicon.imageUrl,
//       height: cusicon.btnXwid, width: cusicon.btnXwid);
// }

Container showLogo() {
  return Container(
      child: Image.asset(
    'assets/Logo_csi.jpg',
    height: 130,
    width: 150,
  ));
}

Container showSMTLogo() {
  return Container(
      height: Palette.stdbutton_height * 8.4,
      width: Palette.stdbutton_width * 8.4,
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: ExactAssetImage('assets/imgs/display2_front.png'),
          fit: BoxFit.fill,
        ),
        shape: BoxShape.rectangle,
      ));
}

Container showConfigf1(BuildContext context) {
  return Container(
      child: GestureDetector(
    onTap: () {
      showPopupTask(context, "ACCUM");
    },
    child: Image.asset(
      'assets/main_config.png',
      height: 130,
      width: 150,
    ),
  ));
}

Container showLogof1(BuildContext context) {
  return Container(
      child: GestureDetector(
    onTap: () {
      showPopupTask(context, "CONFIG");
    },
    child: Image.asset(
      'assets/logo_frontmain.png',
      height: 130,
      width: 150,
    ),
  ));
}

Future<void> showPopupTask(BuildContext context, String mnuName) async {
  switch (mnuName) {
    case "CONFIG":
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
                    // use container to change width and height
                    height: Palette.stdbutton_height * 8,
                    width: Palette.stdbutton_width * 10.5,
                    child: PosCtrlPages(),
                  ),
                ],
              ),
            );
          },
        );
      }
      break;
    // case "START":
    //   {
    //     showDialog(
    //       context: context,
    //       builder: (context) {
    //         return Dialog(
    //           backgroundColor: Colors.white,
    //           insetAnimationDuration: const Duration(milliseconds: 100),
    //           child: Stack(
    //             children: [
    //               Container(
    //                 height: double.infinity,
    //                 width: double.infinity,
    //                 child: RefreshScreen(),
    //               ),
    //             ],
    //           ),
    //         );
    //       },
    //     );
    //   }
    //   break;
  }
}
