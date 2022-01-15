import 'package:flutter/widgets.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/screens/retails/components/rt_ft_totalsales.dart';
import 'package:com_csith_geniuzpos/screens/retails/components/rt_headbill.dart';
import 'package:com_csith_geniuzpos/screens/retails/components/rt_pluinputline.dart';
import 'package:com_csith_geniuzpos/screens/retails/components/rt_salesitem.dart';

import 'rt_saleshead.dart';

Widget retailsContents() {
  return Builder(builder: (context) {
    return ListView(shrinkWrap: true, children: <Widget>[
      const Spacer(),
      Container(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Row(
          children: [
            salesHead(context),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Row(
          children: [
            RtsaleItem(),
          ],
        ),
      ),
      const Spacer(),
      Container(
        padding: const EdgeInsets.fromLTRB(Palette.stdspacer_widht, 20, 0, 0),
        child: Row(
          children: [
            // headBill(context),
            headBill(context),
          ],
        ),
      ),
      const Spacer(),
      Container(
        padding: const EdgeInsets.fromLTRB(Palette.stdspacer_widht, 0, 0, 0),
        child: Row(
          children: [
            footTotalSales(22805, 5, 11),
          ],
        ),
      ),
      const Spacer(),
      Container(
        padding: const EdgeInsets.fromLTRB(Palette.stdspacer_widht, 0, 0, 0),
        child: Row(
          children: [
            txtInputline(),
          ],
        ),
      ),
    ]);
  });
}
