import 'package:com_csith_geniuzpos/data/posfunctions/posfuncsctrl.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/data/wsHelper.dart';
import 'package:com_csith_geniuzpos/models/posmodels/getPosTranDisc.dart';
import 'package:com_csith_geniuzpos/models/posmodels/getPosTranDt.dart';
import 'package:com_csith_geniuzpos/models/posmodels/getPosTranHd.dart';
import 'package:com_csith_geniuzpos/models/posmodels/getPosTranReceipt.dart';
import 'package:com_csith_geniuzpos/models/possales/salesItemSummary.dart';
import 'package:com_csith_geniuzpos/models/possales/salesitems.dart';
import 'package:flutter/cupertino.dart';

class PosFuncionRequest {
  PosFunctionCtrl fnc = new PosFunctionCtrl();

  Future<String> entryInput(String inputvalues, int shiftkey, int keyvalue) {
    var result = fnc.posInput(inputvalues, shiftkey, keyvalue);
    return result;
  }

//----------------SALES SUMMARY FUNCTION-----------------------
  Future<SalesItemSummary> sumSalesItem(BuildContext context) {
    return fnc.salesItemSummary(context);
  }

  Future<SalesItemSummary> sumSalesItemList(BuildContext context) {
    return PosInput().getSalesSUMItems(context);
  }

  Future<int> savePosTrans(BuildContext context, int mode) {
    return PosInput().savePOSTrans(context, mode);
  }

  //----Add getPosTranHD, getPosTranDt, getPosTranDisc, getPosTranRecv
  //----Send request ALL in a times
  //-----------SALES ITEM REFUND REQUEST HERE------------------
  //
  //----Clear SalesItemHiveModel, BillDCHiveModel, ReceiptItemHiveModel, move to Success EventsHandler
  //
  //http://127.0.0.1:9393/savePosTrans/1GS00200122000037 - for getPosTranHD
  //http://127.0.0.1:9393/savePosTrans/1GS00200122000037/2/3 - for getPosTranDt
  //http://127.0.0.1:9393/savePosTrans/1GS00200122000037/2/3/4 - for getPosTranDisc
  //http://127.0.0.1:9393/savePosTrans/1GS00200122000037/2/3/4/5/6 - for getPosTranReceipt
  //-----
  //http://127.0.0.1:9393/savePosTrans/1GS00200122000037 - for getPosTranHD
  //http://127.0.0.1:9393/savePosTrans/1GS00200122000037/2/3 - for getPosTranDt
  //http://127.0.0.1:9393/savePosTrans/1GS00200122000037/2/3/4 - for getPosTranDisc
  //http://127.0.0.1:9393/savePosTrans/1GS00200122000037/2/3/4/5/6 - for getPosTranReceipt
  Future<List<GetPosTranHd>> getBillForRefundHD(String plu) async {
    List<GetPosTranHd> list;
    //---edit List<getPosTranHD, Dt,Disc,Receipt here!
    var data = await wsList(plu);
    if (data != null) {
      list = getPosTranHdFromJson(data);
    }
    return list;
  }

  Future<List<GetPosTranDt>> getBillForRefundDT(String plu) async {
    List<GetPosTranDt> list;
    //---edit List<getPosTranHD, Dt,Disc,Receipt here!
    var data = await wsList(plu);
    if (data != null) {
      list = getPosTranDtFromJson(data);
    }
    return list;
  }

  Future<List<GetPosTranDisc>> getBillForRefundDisc(String plu) async {
    List<GetPosTranDisc> list;
    //---edit List<getPosTranHD, Dt,Disc,Receipt here!
    var data = await wsList(plu);
    if (data != null) {
      list = getPosTranDiscFromJson(data);
    }
    return list;
  }

  Future<List<GetPosTranReceipt>> getBillForRefundRecv(String plu) async {
    List<GetPosTranReceipt> list;
    //---edit List<getPosTranHD, Dt,Disc,Receipt here!
    var data = await wsList(plu);
    if (data != null) {
      list = getPosTranReceiptFromJson(data);
    }
    return list;
  }

//----------------SALES FUNCTION-----------------------
  Future<String> addTable(BuildContext context, String zoneno, String tableno,
      String info, double _x, double _y) {
    var result = fnc.addTableAtPosition(context, zoneno, tableno, info, _x, _y);
    return result;
  }

  Future<String> updateTable(BuildContext context, String zoneno,
      String tableno, String info, double _x, double _y) {
    var result =
        fnc.updateTableAtPosition(context, zoneno, tableno, info, _x, _y);
    return result;
  }

  Future<String> salesitemAdd(BuildContext context, SalesItems sales) {
    var result = fnc.addSalesItem(context, sales);
    return result;
  }

  Future<String> entryFree(BuildContext context) {
    var result = fnc.salesItemFree(context);
    return result;
  }

  Future<String> salesItemAdd(BuildContext context, SalesItems sales) {
    // debugPrint('posfnc_request: salesItemAdd ');
    var result = fnc.addSalesItem(context, sales);
    //var result = fnc.salesItemAdd(sales);
    return result;
  }

  Future<void> salesItemVoidAll(BuildContext context) {
    return fnc.voidSalesItem(context);
  }

  Future<void> salesItemVoidAitem(BuildContext context, int index) {
    return fnc.voidASalesItem(context, index);
  }

  Future<double> bDCBVoidAitem(BuildContext context, int index) {
    return fnc.voidABDCBItem(context, index);
  }

  Future<SalesItems> salesItemGetAitem(BuildContext context, int index) {
    return fnc.getASalesItem(context, index);
  }

  Future<double> discChgBalAmount(
      double sumsalesitem, double discount, double charge) {
    return fnc.getDiscChgBalAmount(sumsalesitem, discount, charge);
  }

//-------------------------------------------
  Future<String> salesHold() {
    var result = fnc.salesHold();
    return result;
  }

  Future<String> salesReturn() {
    var result = fnc.salesReturn();
    return result;
  }

  Future<String> salesDeposit(double amtDeposit) {
    var result = fnc.salesDeposit(amtDeposit);
    return result;
  }

  Future<String> salesAmtDisc(double amtDisc) {
    var result = fnc.amtDisc(amtDisc);
    return result;
  }

  Future<String> salesPercDisc(double percDisc) {
    var result = fnc.percDisc(percDisc);
    return result;
  }

  Future<String> salesAmtCharge(double amtCharge) {
    var result = fnc.amtCharge(amtCharge);
    return result;
  }

  Future<String> salesPercCharge(double percCharge) {
    var result = fnc.percCharge(percCharge);
    return result;
  }

  Future<String> salesCouponDisce(double amtCouponDisc) {
    var result = fnc.couponDisc(amtCouponDisc);
    return result;
  }

  Future<String> salesCashIn(double amtCashIn) {
    var result = fnc.cashIn(amtCashIn);
    return result;
  }

  Future<String> salesCashOut(double amtCashOut) {
    var result = fnc.cashOut(amtCashOut);
    return result;
  }
}
