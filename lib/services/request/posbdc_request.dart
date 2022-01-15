import 'package:com_csith_geniuzpos/data/posfunctions/posbdcctrl.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/models/possales/salesItemSummary.dart';
import 'package:com_csith_geniuzpos/models/possales/salesitems.dart';
import 'package:flutter/cupertino.dart';

class PosBillDCRequest {
  PosBDCCtrl fnc = new PosBDCCtrl();

//----------------SALES SUMMARY FUNCTION-----------------------
  Future<SalesItemSummary> sumBDCItem(BuildContext context) {
    return fnc.salesItemSummary(context);
  }

  Future<SalesItemSummary> sumBDCItemList(BuildContext context) {
    return PosInput().getBdcSUMItems(context);
  }

//----------------SALES FUNCTION-----------------------

  Future<String> entryFree(BuildContext context) {
    var result = fnc.salesItemFree(context);
    return result;
  }

  Future<double> bdcItemAdd(BuildContext context, SalesItems sales) {
    var result = fnc.addSalesItem(context, sales);
    return result;
  }

  Future<void> bdcItemVoidAll(BuildContext context) {
    return fnc.voidSalesItem(context);
  }

  Future<void> bdcItemVoidAitem(BuildContext context, int index) {
    return fnc.voidASalesItem(context, index);
  }

  Future<double> discChgBalAmount(
      double sumsalesitem, double discount, double charge) {
    return fnc.getDiscChgBalAmount(sumsalesitem, discount, charge);
  }

  Future<double> bDCBVoidAitem(BuildContext context, int index) {
    return fnc.voidABDCBItem(context, index);
  }

  Future<void> bDCBVoidALL(BuildContext context) {
    return fnc.voidALLItem(context);
  }
}
