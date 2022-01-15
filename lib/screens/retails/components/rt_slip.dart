import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/screens/fullsales/components/fs_salesitem.dart';
import 'package:com_csith_geniuzpos/screens/fullsales/components/fs_salhead.dart';
import 'package:com_csith_geniuzpos/screens/fullsales/components/fs_salthdtotal.dart';
import 'package:com_csith_geniuzpos/screens/fullsales/components/fs_title.dart';

class RtSlipPages extends StatefulWidget {
  @override
  _RtSlipPages createState() => _RtSlipPages();
}

class _RtSlipPages extends State<RtSlipPages> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  _RtSlipPages();

  @override
  void dispose() {
    _trackingScrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 28,
          left: 144,
          child: fssalhead(context),
        ),
        Positioned(
          top: 28,
          left: 144 + Palette.stdbutton_width * 4,
          child: fssalheadtotal(22805),
        ),
        Positioned(
          top: Palette.fullsalesheadcheight() + Palette.stdspacer_widht * 6,
          left: Palette.stdspacer_widht,
          child: fssalesTitle(),
        ),
        Positioned(
          top:
              Palette.fullsalesheadcheight() + Palette.stdspacer_widht * 6 + 30,
          left: Palette.stdspacer_widht,
          child: FullsaleItem(),
        ),
        // Positioned(
        //   top: Palette.fullsalesheadcheight() +
        //       Palette.fullsalesitemheigth() +
        //       Palette.stdspacer_widht * 2,
        //   left: Palette.stdspacer_widht,
        //   child: headBill(context),
        // ),
        // Positioned(
        //   top: Palette.fullsalesheadcheight() +
        //       Palette.fullsalesitemheigth() +
        //       Palette.promdescheigth(),
        //   left: Palette.stdspacer_widht,
        //   child: footTotalSales(),
        // ),
      ],
    );
  }
}
