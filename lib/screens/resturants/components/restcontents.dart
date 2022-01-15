import 'package:flutter/widgets.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/screens/resturants/components/rest_pluinput.dart';
import 'package:com_csith_geniuzpos/screens/resturants/components/rest_saleshead.dart';
import 'package:com_csith_geniuzpos/screens/resturants/components/rest_salesitem.dart';
import 'package:com_csith_geniuzpos/screens/retails/components/rt_ft_totalsales.dart';

Widget resturantContents(TrackingScrollController scrollController) {
  return Builder(builder: (context) {
    return ListView(shrinkWrap: true, children: <Widget>[
      const Spacer(),
      Container(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Row(
          children: [
            restsalesHead(context),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Row(
          children: [
            RestsaleItem(),
          ],
        ),
      ),
      const Spacer(),
      const Spacer(),
      Container(
        padding: const EdgeInsets.fromLTRB(Palette.stdspacer_widht, 10, 0, 0),
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
            resttxtInputline(),
          ],
        ),
      ),
    ]);
  });
}
