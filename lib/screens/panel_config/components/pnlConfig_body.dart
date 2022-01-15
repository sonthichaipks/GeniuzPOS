import 'package:com_csith_geniuzpos/screens/panel_config/components/pnlConfig_head.dart';
import 'package:com_csith_geniuzpos/screens/panel_config/components/pnlConfig_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/screens/fullsales/components/fs_logo.dart';

class PnlConfigBodyPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 28,
          left: 0,
          child: logohead(context, 0),
        ),
        pnlConfigHead(),
        Positioned(
          top: Palette.fullsalesheadcheight() + Palette.stdspacer_widht * 6,
          left: Palette.stdspacer_widht,
          child: pnlConfigTitle(),
        ),
      ],
    );
  }
}
