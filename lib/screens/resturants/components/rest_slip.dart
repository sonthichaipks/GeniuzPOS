import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/screens/retails/components/rt_saleshead.dart';
import 'package:com_csith_geniuzpos/screens/retails/components/rt_salheadtotal.dart';
import 'package:com_csith_geniuzpos/screens/retails/components/rt_slip.dart';
import 'package:com_csith_geniuzpos/screens/retails/components/rt_title.dart';

class RestSlipPages extends StatefulWidget {
  @override
  _RestSlipPages createState() => _RestSlipPages();
}

class _RestSlipPages extends State<RestSlipPages> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  _RestSlipPages();

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
          child: salesHead(context),
        ),
        Positioned(
          top: 28,
          left: 144 + Palette.stdbutton_width * 2.3,
          child: rtsalheadtotal(22805),
        ),
        Positioned(
          top: Palette.fullsalesheadcheight() + Palette.stdspacer_widht * 6,
          left: Palette.stdspacer_widht,
          child: rtsalesTitle(),
        ),
        Positioned(
          top:
              Palette.fullsalesheadcheight() + Palette.stdspacer_widht * 6 + 30,
          left: Palette.stdspacer_widht,
          child: RtSlipPages(),
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
