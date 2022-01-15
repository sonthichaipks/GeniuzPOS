import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/models/possales/salesItemSummary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/screens/retails/components/rt_ft_totalsales.dart';
import 'package:com_csith_geniuzpos/screens/retails/components/rt_headbill.dart';
import 'package:com_csith_geniuzpos/screens/retails/components/rt_pluinputline.dart';
import 'package:com_csith_geniuzpos/screens/retails/components/rt_saleshead.dart';
import 'package:com_csith_geniuzpos/screens/retails/components/rt_salheadtotal.dart';
import 'package:com_csith_geniuzpos/screens/retails/components/rt_title.dart';
import 'package:com_csith_geniuzpos/screens/retails/components/rtlogo.dart';

class RetailSalesSummaryPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SalesItemSummary _salesitemsum;
    _salesitemsum = PosInput().getSalesSUM(context);
    return Stack(
      children: [
        Positioned(
          top: 28,
          left: 0,
          child: rtlogohead(context),
        ),
        Positioned(
          top: 28,
          left: 132,
          child: salesHead(context),
        ),
        Positioned(
            top: 28,
            left: 144 + Palette.stdbutton_width * 2.3,
            child: (_salesitemsum == null)
                ? rtsalheadtotal(0)
                : rtsalheadtotal(_salesitemsum.totalamount)),
        Positioned(
          top: Palette.fullsalesheadcheight() + Palette.stdspacer_widht * 6,
          left: Palette.stdspacer_widht,
          child: rtsalesTitle(),
        ),
        Positioned(
          top: Palette.fullsalesheadcheight() +
              Palette.fullsalesitemheigth() +
              Palette.stdspacer_widht * 2,
          left: Palette.stdspacer_widht,
          child: headBill(context),
        ),
        Positioned(
          top: Palette.fullsalesheadcheight() +
              Palette.fullsalesitemheigth() +
              Palette.promdescheigth(),
          left: Palette.stdspacer_widht,
          child: (_salesitemsum == null)
              ? footTotalSales(0, 0, 0)
              : footTotalSales(_salesitemsum.totalamount,
                  _salesitemsum.itemcount, _salesitemsum.totalqty),
        ),
        Positioned(
          top: Palette.fullsalesheadcheight() +
              Palette.fullsalesitemheigth() +
              Palette.promdescheigth() +
              Palette.onelineheigth(),
          left: Palette.stdspacer_widht,
          child: txtInputline(),
        ),
      ],
    );
  }
}
