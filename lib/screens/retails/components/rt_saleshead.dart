import 'package:com_csith_geniuzpos/resources/csiconfig.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';
import 'package:com_csith_geniuzpos/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';

Widget salesHead(BuildContext context) {
  //---get running no ---
  int mode = PosControlFnc().getBillmode(context);
  String docno = PosControlFnc()
      .getRunno(context, MyConfig().a_cycleRcptBegEnd); //'101214183125';
  return Container(
    height: Palette.fullsalesheadcheight(),
    width: Palette.stdbutton_width * 8, // Palette.stdbutton_width * 10.6,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(
        top: BorderSide(width: 1.0, color: Colors.grey),
        left: BorderSide(width: 1.0, color: Colors.white),
        right: BorderSide(width: 1.0, color: Colors.white),
        bottom: BorderSide(width: 1.0, color: Colors.grey),
      ),
    ),
    child: Stack(children: [
      Positioned(
        top: 0,
        left: 0,
        child: Row(
          //  shrinkWrap: true,
          children: [
            Column(
              children: [
                Container(
                  width: Palette.stdbutton_width * 10,
                  padding: const EdgeInsets.fromLTRB(
                      Palette.stdspacer_widht, 12, 0, 0),
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      text: '',
                      children: <TextSpan>[
                        TextSpan(
                            text: (mode == 1)
                                ? Palette.lbl_billno + docno
                                : Palette.lbl_refundno + '\r\nอ้างถึง#',
                            style: TextStyle(
                              fontFamily: 'Micrsoft Sans Serif',
                              fontWeight: FontWeight.bold,
                              fontSize: 11.5,
                              height: 1.0,
                              letterSpacing: 0.1,
                              color: Colors.black,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Positioned(
        top: 0,
        left: 70,
        child: Row(
          //  shrinkWrap: true,
          children: [
            Column(
              children: [
                Container(
                  width: Palette.stdbutton_width * 10,
                  padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      text: '',
                      children: <TextSpan>[
                        TextSpan(
                            text: (mode == 2) ? docno : '',
                            style: TextStyle(
                              fontFamily: 'Micrsoft Sans Serif',
                              fontWeight: FontWeight.bold,
                              fontSize: 11.5,
                              height: 1.0,
                              letterSpacing: 0.1,
                              color: Colors.black,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Positioned(
        top: 25,
        left: -10,
        child: Row(
          //  shrinkWrap: true,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(18, 5, 0, 5),
                  child: RichText(
                    textAlign: TextAlign.right,
                    text: TextSpan(
                      text: '',
                      children: <TextSpan>[
                        TextSpan(
                            text: 'รวมราคาทั้งสิ้น',
                            style: TextStyle(
                              fontFamily: 'Micrsoft Sans Serif',
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                              height: 1.8,
                              letterSpacing: 0.4,
                              color: Colors.black,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ]),
  );

  // Container(
  //   height: Palette.fullsalesheadcheight(),
  //   width: Palette.stdbutton_width * 6.6,
  //   decoration: BoxDecoration(
  //     color: Colors.white,
  //     border: Border(
  //       top: BorderSide(width: 1.0, color: Colors.grey),
  //       left: BorderSide(width: 1.0, color: Colors.white),
  //       right: BorderSide(width: 1.0, color: Colors.white),
  //       bottom: BorderSide(width: 1.0, color: Colors.grey),
  //     ),
  //   ),
  //   child: Padding(
  //     padding: const EdgeInsets.fromLTRB(4, 10, 4, 8),
  //     child: RichText(
  //       textAlign: TextAlign.left,
  //       text: TextSpan(
  //         text: '',
  //         children: <TextSpan>[
  //           TextSpan(
  //               text: (mode == 1)
  //                   ? Palette.lbl_billno + docno + '\r\n'
  //                   : Palette.lbl_refundno + docno,
  //               // 'เลขที่ใบเสร็จฯ : ' + docno + '\r\n',
  //               style: TextStyle(
  //                 fontFamily: 'Micrsoft Sans Serif',
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 11.5,
  //                 height: 1.0,
  //                 letterSpacing: 0.1,
  //                 color: Colors.black,
  //               )),
  //           TextSpan(
  //               text: 'รวมราคาทั้งสิ้น',
  //               style: TextStyle(
  //                 fontFamily: 'Micrsoft Sans Serif',
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 19,
  //                 height: 1.8,
  //                 letterSpacing: 0.4,
  //                 color: Colors.black,
  //               )),
  //         ],
  //       ),
  //     ),
  //   ),
  // );
  // );

  // Row(children: [
  //   GestureDetector(
  //     onPanUpdate: (details) {
  //       if (details.delta.dx > 0) {
  //         MaterialPageRoute route =
  //             MaterialPageRoute(builder: (value) => NavScreen(screenmenu: 2));
  //         Navigator.push(context, route);
  //       } else {
  //         MaterialPageRoute route =
  //             MaterialPageRoute(builder: (value) => NavScreen(screenmenu: 1));
  //         Navigator.push(context, route);
  //       }
  //     },
  //     child: Row(
  //       children: [
  //         Container(
  //           height: Palette.fullsalesheadcheight(),
  //           width: Palette.stdbutton_width * 4.6,
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             border: Border(
  //               top: BorderSide(width: 1.0, color: Colors.grey),
  //               left: BorderSide(width: 1.0, color: Colors.white),
  //               right: BorderSide(width: 1.0, color: Colors.white),
  //               bottom: BorderSide(width: 1.0, color: Colors.grey),
  //             ),
  //           ),
  //           child: Padding(
  //             padding: const EdgeInsets.fromLTRB(4, 10, 4, 8),
  //             child: RichText(
  //               textAlign: TextAlign.left,
  //               text: TextSpan(
  //                 text: '',
  //                 children: <TextSpan>[
  //                   TextSpan(
  //                       text: (mode == 1)
  //                           ? Palette.lbl_billno + docno + '\r\n'
  //                           : Palette.lbl_refundno + docno,
  //                       style: TextStyle(
  //                         fontFamily: 'Micrsoft Sans Serif',
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 11.5,
  //                         height: 1.0,
  //                         letterSpacing: 0.1,
  //                         color: Colors.black,
  //                       )),
  //                   // TextSpan(
  //                   //     text: Palette.lbl_totalBill,
  //                   //     style: TextStyle(
  //                   //       fontFamily: 'Micrsoft Sans Serif',
  //                   //       fontWeight: FontWeight.bold,
  //                   //       fontSize: 19,
  //                   //       height: 1.8,
  //                   //       letterSpacing: 0.4,
  //                   //       color: Colors.black,
  //                   //     )),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //         Container(
  //           height: Palette.fullsalesheadcheight(),
  //           width: Palette.stdbutton_width * 2.6,
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             border: Border(
  //               top: BorderSide(width: 1.0, color: Colors.grey),
  //               left: BorderSide(width: 1.0, color: Colors.white),
  //               right: BorderSide(width: 1.0, color: Colors.white),
  //               bottom: BorderSide(width: 1.0, color: Colors.grey),
  //             ),
  //           ),
  //           child: Padding(
  //             padding: const EdgeInsets.fromLTRB(4, 10, 4, 8),
  //             child: RichText(
  //               textAlign: TextAlign.left,
  //               text: TextSpan(
  //                 text: '',
  //                 children: <TextSpan>[
  //                   // TextSpan(
  //                   //     text: (mode == 1)
  //                   //         ? Palette.lbl_billno + docno + '\r\n'
  //                   //         : Palette.lbl_refundno + docno,
  //                   //     style: TextStyle(
  //                   //       fontFamily: 'Micrsoft Sans Serif',
  //                   //       fontWeight: FontWeight.bold,
  //                   //       fontSize: 11.5,
  //                   //       height: 1.0,
  //                   //       letterSpacing: 0.1,
  //                   //       color: Colors.black,
  //                   //     )),
  //                   TextSpan(
  //                       text: Palette.lbl_totalBill,
  //                       style: TextStyle(
  //                         fontFamily: 'Micrsoft Sans Serif',
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 19,
  //                         height: 1.8,
  //                         letterSpacing: 0.4,
  //                         color: Colors.black,
  //                       )),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   ),
  // ]);
}
