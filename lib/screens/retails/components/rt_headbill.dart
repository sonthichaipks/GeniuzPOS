import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';

import '../rt_message.dart';

Widget headBill(BuildContext context) {
  String promoDesc, pmd1, pmd2;
  promoDesc = PosControlFnc().getPromoDesc(context);

  promoDesc = promoDesc.replaceAll('\r\n', '|').trim();
  List<String> pmdetail = promoDesc.split('|');
  // List<String> pmdetail = promoDesc.split('|');
  if (pmdetail.length > 1) {
    pmd1 = promoDesc.split('|')[0];
    pmd2 = promoDesc.split('|')[1];
  }
  if (promoDesc.length > 50) {
    pmd1 = promoDesc.substring(0, 49);
    pmd2 = promoDesc.substring(49, promoDesc.length - 1);
  }
  if (promoDesc.split('@').length > 1) {
    pmd1 = promoDesc.split('@')[0];
    pmd2 = promoDesc.split('@')[1];
  }
  // 'มันมัน Original 250ml.\r\nซื้อ 1 แถม 1 ในสินค้ารหัสเดียวกัน';
  return Row(
    children: [
      Container(
        width: Palette.promdescwidth(),
        height: Palette.promdescheigth(),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
              width: 1,
            )),
        child: Stack(
          children: [
            Positioned(
              top: 2,
              left: 2,
              child: Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      text: '',
                      children: <TextSpan>[
                        TextSpan(
                            text: (pmdetail.length > 1)
                                ? pmd1 + '\r\n' + pmd2
                                : (promoDesc.length > 50)
                                    ? pmd1 + '\r\n' + pmd2
                                    : promoDesc,
                            style: TextStyle(
                              fontFamily: 'Leelawadee',
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                              height: 2,
                              letterSpacing: 0.03,
                              color: Colors.black,
                            )),
                      ],
                    ),
                  )),
            ),
            Positioned(
                top: 2,
                right: 10,
                child: Align(
                    alignment: Alignment.topRight, child: msgshow(context))),
          ],
        ),
      ),
    ],
  );
}
