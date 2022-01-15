import 'package:com_csith_geniuzpos/data/posfunctions/posbdcctrl.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posrcpctrl.dart';
import 'package:com_csith_geniuzpos/models/possales/salesItemSummary.dart';
import 'package:com_csith_geniuzpos/models/possales/salesitems.dart';
import 'package:flutter/cupertino.dart';

class PosBillRCPRequest {
  PosRCPCtrl fnc = new PosRCPCtrl();

//----------------SALES SUMMARY FUNCTION-----------------------
  Future<SalesItemSummary> sumBDCItem(BuildContext context) {
    return fnc.salesItemSummary(context);
  }

  Future<SalesItemSummary> sumBDCItemList(BuildContext context) {
    return PosInput().getSalesSUMItems(context);
  }

//----------------SALES FUNCTION-----------------------

  Future<String> entryFree(BuildContext context) {
    var result = fnc.salesItemFree(context);
    return result;
  }

  Future<double> rcpItemAdd(BuildContext context, SalesItems sales) {
    var result = fnc.addSalesItem(context, sales);
    return result;
  }

  Future<void> rcpItemVoidAll(BuildContext context) {
    return fnc.voidSalesItem(context);
  }

  Future<void> rcpItemVoidAitem(BuildContext context, int index) {
    return fnc.voidASalesItem(context, index);
  }

  Future<double> rcpBalAmount(
      double sumsalesitem, double discount, double charge) {
    return fnc.getDiscChgBalAmount(sumsalesitem, discount, charge);
  }

  Future<double> rcpVoidAitem(BuildContext context, int index) {
    return fnc.voidARCPItem(context, index);
  }
}
