import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/button.dart';
import 'package:com_csith_geniuzpos/widgets/poswidgets/poshead.dart';

Widget restframeBUtton(TrackingScrollController scrollController) {
  return CustomScrollView(controller: scrollController, slivers: <Widget>[
    //-----Sale Titles Line
    // UI: Branch, POS STATION, CASHIER, SALESMAN, MEMBER, DATE TIME
    //---------------------
    SliverAppBar(
      toolbarHeight: 30,
      pinned: true,
      flexibleSpace: Container(
        child: PosHead(
          posheaditems: posHeadItems[0],
        ),
      ),
    ),

    //-----buttons : layout of SalesItem Windows
    // Horison : 12.5 stdbox.buttons.height + btnspaces
    // Vertical : 10  std.buttons.width + btnspaces
    //--------------------------------------------
    SliverPadding(
      padding: const EdgeInsets.fromLTRB(
          0.0, 0.0, Palette.stdspacer_widht, Palette.stdspacer_widht),
      sliver: SliverToBoxAdapter(
        child: PosButtons(
          // posbtns: stdButtuon1r,
          posbtns: stdButtuon0,
        ),
      ),
    ),
    SliverPadding(
      padding: const EdgeInsets.fromLTRB(
          0.0, 0.0, Palette.stdspacer_widht, Palette.stdspacer_widht),
      sliver: SliverToBoxAdapter(
        child: PosButtons(
          posbtns: stdButtuon0,
        ),
      ),
    ),
    SliverPadding(
      padding: const EdgeInsets.fromLTRB(
          0.0, 0.0, Palette.stdspacer_widht, Palette.stdspacer_widht),
      sliver: SliverToBoxAdapter(
        child: PosButtons(
          posbtns: stdButtuon0,
        ),
      ),
    ),
    SliverPadding(
      padding: const EdgeInsets.fromLTRB(
          0.0, 0.0, Palette.stdspacer_widht, Palette.stdspacer_widht),
      sliver: SliverToBoxAdapter(
        child: PosButtons(
          posbtns: stdButtuon0,
        ),
      ),
    ),
    SliverPadding(
      padding: const EdgeInsets.fromLTRB(
          0.0, 0.0, Palette.stdspacer_widht, Palette.stdspacer_widht),
      sliver: SliverToBoxAdapter(
        child: PosButtons(
          posbtns: stdButtuon0,
        ),
      ),
    ),
    SliverPadding(
      padding: const EdgeInsets.fromLTRB(
          0.0, 0.0, Palette.stdspacer_widht, Palette.stdspacer_widht),
      sliver: SliverToBoxAdapter(
        child: PosButtons(
          //posbtns: stdButtuon6r,
          posbtns: stdButtuon0,
        ),
      ),
    ),
    SliverPadding(
      padding: const EdgeInsets.fromLTRB(
          0.0, 0.0, Palette.stdspacer_widht, Palette.stdspacer_widht),
      sliver: SliverToBoxAdapter(
        child: PosButtons(
          posbtns: stdButtuon0,
        ),
      ),
    ),
    SliverPadding(
      padding: const EdgeInsets.fromLTRB(
          0.0, 0.0, Palette.stdspacer_widht, Palette.stdspacer_widht),
      sliver: SliverToBoxAdapter(
        child: PosButtons(
          posbtns: stdButtuon0,
        ),
      ),
    ),
    // SliverPadding(
    //   padding: const EdgeInsets.fromLTRB(
    //       0.0, 0.0, Palette.stdspacer_widht, Palette.stdspacer_widht),
    //   sliver: SliverToBoxAdapter(
    //     child: PosButtons(
    //       posbtns: stdButtuon9,
    //     ),
    //   ),
    // ),
    // SliverPadding(
    //   padding: const EdgeInsets.fromLTRB(
    //       0.0, 0.0, Palette.stdspacer_widht, Palette.stdspacer_widht),
    //   sliver: SliverToBoxAdapter(
    //     child: PosButtons(
    //       posbtns: stdButtuon10,
    //     ),
    //   ),
    // )
  ]);
}
