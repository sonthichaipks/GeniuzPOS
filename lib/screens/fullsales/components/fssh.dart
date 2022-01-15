import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/models/possales/salesItemSummary.dart';
import 'package:com_csith_geniuzpos/screens/fullsales/components/fs_components.dart';
import 'package:com_csith_geniuzpos/screens/retails/components/rt_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';

class FullSalesSummaryPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SalesItemSummary _salesitemsum;
    _salesitemsum = PosInput().getSalesSUM(context);
    return Stack(
      children: [
        Positioned(
          top: 28,
          left: 0,
          child: logohead(context, 1),
        ),
        Positioned(
          top: 30,
          left: 132,
          child: fssalhead(context),
        ),
        Positioned(
          top: 30,
          left: 144 + Palette.stdbutton_width * 4,
          child: (_salesitemsum == null)
              ? fssalheadtotal(0)
              : fssalheadtotal(_salesitemsum.totalamount),
        ),
        Positioned(
          top: Palette.fullsalesheadcheight() + Palette.stdspacer_widht * 6,
          left: Palette.stdspacer_widht,
          child: fssalesTitle(),
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
