import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/models/possales/salesItemSummary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/screens/fullsales/components/fs_logo.dart';
import 'package:com_csith_geniuzpos/screens/resturants/components/rest_pluinput.dart';
import 'package:com_csith_geniuzpos/screens/resturants/components/rest_saleshead.dart';
import 'package:com_csith_geniuzpos/screens/resturants/components/rest_salheadtoral.dart';
import 'package:com_csith_geniuzpos/screens/resturants/components/rest_title.dart';
import 'package:com_csith_geniuzpos/screens/retails/components/rt_ft_totalsales.dart';
import 'package:com_csith_geniuzpos/screens/retails/rt_message.dart';

class ResturantSalesSummaryPages extends StatelessWidget {
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
          top: 28,
          left: 132,
          child: restsalesHead(context),
        ),
        Positioned(
          top: 28,
          left: 336,
          child: msgshow(context),
        ),
        Positioned(
          top: 32,
          left: 130,
          child: (_salesitemsum == null)
              ? restsalheadtotal(0)
              : restsalheadtotal(_salesitemsum.totalamount),
        ),
        Positioned(
          top: Palette.fullsalesheadcheight() + Palette.stdspacer_widht * 6,
          left: Palette.stdspacer_widht,
          child: restsalesTitle(),
        ),
        // Positioned(
        //   top: Palette.fullsalesheadcheight() + Palette.stdspacer_widht * 6 + 26,
        //   left: Palette.stdspacer_widht,
        //   child: RestsaleItem(),
        // ),
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
          child: resttxtInputline(),
        ),
      ],
    );
  }
}
