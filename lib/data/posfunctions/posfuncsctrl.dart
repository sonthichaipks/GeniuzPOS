import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';
import 'package:com_csith_geniuzpos/data/wsHelper.dart';
import 'package:com_csith_geniuzpos/models/buttons/hive_tableusages.dart';
import 'package:com_csith_geniuzpos/models/possales/salesItemSummary.dart';
import 'package:com_csith_geniuzpos/models/possales/salesitem.dart';
import 'package:com_csith_geniuzpos/models/possales/salesitems.dart';
import 'package:com_csith_geniuzpos/data/possales/tableusagemodel.dart';
import 'package:com_csith_geniuzpos/data/possales/salesitemmodel.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/utility/hiveHelper.dart';
import 'package:com_csith_geniuzpos/utility/normal_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_js/extensions/fetch.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PosFunctionCtrl {
  HiveCtrl con = new HiveCtrl();
  final df = new NumberFormat("##0.00", "en_US");

  Future<String> posInput(
      String inputvalues, int shiftkey, int keyvalue) async {
    if (shiftkey == 0) {
      return inputvalues;
    } else if (shiftkey > 0) {
      return shiftkey.toString().trim() +
          ":" +
          keyvalue.toString().trim() +
          ":" +
          inputvalues.trim();
    } else {
      return "";
    }
  }

//----------------SAVE POS A TRANSACTION----
  Future<void> savePosTranWS(String url, int mode) async {
    //---loop for saving posTranDt, posTranBdc, posTranRecv
    //http://127.0.0.1:9393/savePosTrans/
    //00123/00123GS001211119001/B/1/
    //00123GS001211119001]002]SPACE X TESLA]BC0010101]1]1500]]1500]V]pcs]
    //  String dataurl =
    //         'http://127.0.0.1:9393/savePosTrans/[POSID]/[DOCNO]/B/1/';
    //     dataurl = dataurl + '[DOCNO]][CASHIER]][SI]][PLU]][QTY]][PRICE]][DISC]][AMT]][VC]][UNIT]]';
    try {
      await Future.delayed(const Duration(milliseconds: 1), () {
        wsExec(url);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  //----------------SALES ITEM SUMMARY--------
  Future<SalesItemSummary> salesItemSummary(BuildContext context) async {
    return await PosInput().getSalesSUMItems(context);
  }

  //----------------SALES ITEM----------------
  Future<String> salesItemFree(BuildContext context) async {
    var model = Provider.of<SalesItemHiveModel>(context, listen: false);
    SalesItem salesLastX = model.inventoryList[model.inventoryList.length - 1];
    SalesItems salesLast = PosInput().getSalesItem(salesLastX);
    if (salesLast.price > 0) {
      addSalesItem(
          context,
          SalesItems(
              salesLast.salesitem,
              salesLast.plu,
              salesLast.qty,
              (-1) * salesLast.price,
              '',
              0,
              (-1) * salesLast.amount,
              salesLast.vatcode,
              'Pcs',
              0));
    }

    return "";
  }

  Future<String> addSalesItem(BuildContext context, SalesItems sales) async {
    var inventoryDb = Provider.of<SalesItemHiveModel>(context, listen: false);
    String plu, itemtype, salesitem, disccode, vatcode, unit;
    //---unit : use in refund is RefLineItemNo , for link back to update QtyRefund!
    double qty, price, amount, disc;
    //-----------
    if (sales.plu != '') {
      plu = sales.plu.trim();
    } else {
      plu = '';
    }
    List<String> chkPlu = plu.split(':');
    //---------Check ItemType Code---
    if (chkPlu.length > 0) {
      // plu = '';
      if (chkPlu[0] == Palette.btncmd_CHGP) {
        itemtype = '31'; //--ChargePercent
      } else if (chkPlu[0] == Palette.btncmd_CHGB) {
        itemtype = '32'; //--ChargeAmount
      } else if (chkPlu[0] == Palette.btncmd_DISCM) {
        itemtype = '20'; //--DiscountMember
      } else if (chkPlu[0] == Palette.btncmd_DISCP) {
        itemtype = '21'; //--DiscountPercent
      } else if (chkPlu[0] == Palette.btncmd_DISCB) {
        itemtype = '22'; //--DiscountAmount
      } else if (chkPlu[0] == Palette.btncmd_DISCCP) {
        itemtype = '23'; //--DiscountCouponPercent
      } else if (chkPlu[0] == Palette.btncmd_DISCCB) {
        itemtype = '24'; //--DiscountCouponAmount
      } else if (chkPlu[0] == Palette.btncmd_DISCPM) {
        itemtype = '25'; //--DiscountPromotion
      } else {
        //   plu = sales.plu.trim();
        itemtype = '10';
      }
    } else {
      itemtype = '10';
    }
    if (sales.plu != '') {
      plu = sales.plu.trim();
    } else {
      plu = '';
    }
    if (sales.salesitem != '') {
      salesitem = sales.salesitem;
    } else {
      salesitem = '';
    }
    if (sales.disccode != '') {
      disccode = sales.disccode;
    } else {
      disccode = '';
    }
    if (sales.vatcode != '') {
      vatcode = sales.vatcode.trim();
    } else {
      vatcode = '';
    }
    if (sales.qty != null) {
      qty = sales.qty;
    } else {
      qty = 1;
    }
    if (sales.price != null) {
      price = sales.price;
    } else {
      price = 0;
    }
    if (sales.amount != null) {
      amount = sales.amount;
    } else {
      amount = qty * price;
    }
    if (sales.disc != null) {
      disc = sales.disc;
    } else {
      disc = 0;
    }
    //----unit use in salesitem ,
    //----lineitemtype = 10 : is unit
    //----lineitemtype = 2x,3x : is ''
    //----use in refund ,
    //----lineitemtype = 10 : is reflineitemno
    if (sales.refline != null) {
      unit = sales.refline.toString();
    } else {
      unit = '';
    }
    // await Future.delayed(const Duration(seconds: 1), () {
    inventoryDb.addItem(SalesItem(
        saleskey: plu + ']' + itemtype + ']' + unit + ']',
        salesinfo: salesitem + ']' + disccode + ']' + vatcode + ']',
        salesdata: df.format(qty) +
            ']' +
            df.format(price) +
            ']' +
            df.format(amount) +
            ']' +
            df.format(disc) +
            ']'));
    inventoryDb.getItem();
    // });

    //---send data to Server for SecondMonitor , only sales item!
    // PosInput().savePOSTrans(context, 10);
    return "OK";
  }

  Future<void> voidSalesItem(BuildContext context) async {
    var inventoryDb = Provider.of<SalesItemHiveModel>(context, listen: false);
    return await inventoryDb.deleteAllItem();
  }

  Future<SalesItems> voidASalesItem(BuildContext context, int index) async {
    var inventoryDb = Provider.of<SalesItemHiveModel>(context, listen: false);
    return await inventoryDb.deleteItem(index);
  }

  Future<SalesItems> getASalesItem(BuildContext context, int index) async {
    var inventoryDb = Provider.of<SalesItemHiveModel>(context, listen: false);
    return await inventoryDb.getLastPluItem();
  }

  Future<double> getDiscChgBalAmount(
      double sumsalesitem, double discount, double charge) async {
    return sumsalesitem + charge - discount;
  }

  Future<double> voidABDCBItem(BuildContext context, int index) async {
    var inventoryDb = Provider.of<SalesItemHiveModel>(context, listen: false);
    double amount;
    if (index == -1) {
      //void all
      amount = 0;
      await inventoryDb.deleteAllItem();
    } else if (index == -2) {
      var sallist = inventoryDb.inventoryList
          .where((element) => PosControlFnc().checkSIT(element))
          .toList();
      //void all Bill DISCOUNT/CHARGE
      await inventoryDb.deleteAllItem();
      int lastindex = sallist.length;
      amount = 0;
      for (int i = 0; i < lastindex - 1; i++) {
        await inventoryDb.addItem(sallist[i]);
      }
      //await inventoryDb.deleteAlltype(Palette.modeType_BDC);
    } else if (index == -3) {
      var sallist = inventoryDb.inventoryList
          .where((element) => PosControlFnc().checkSITBDC(element))
          .toList();
      //void all Bill DISCOUNT/CHARGE
      await inventoryDb.deleteAllItem();
      int lastindex = sallist.length;
      amount = 0;
      for (int i = 0; i < lastindex - 1; i++) {
        await inventoryDb.addItem(sallist[i]);
      }
      //void all receipt
      // amount = 0;
      // await inventoryDb.deleteAlltype(Palette.modeType_RCP);
    } else {
      amount = await inventoryDb.getLastBDCBamount(index);
      await inventoryDb.deleteItem(index);
    }

    return amount;
  }

  //------------------------TABLE FUNCTION--------------------------------------
  Future<void> addTableAtPosition(BuildContext context, String zoneno,
      String tableno, String info, double _x, double _y) async {
    var inventoryDb = Provider.of<RestTableUsageModel>(context, listen: false);
    String dfx = df.format(_x);
    String dfy = df.format(_y);

    await inventoryDb.addItem(TableUsage(
      tablekey: zoneno + ']' + tableno + ']',
      tableinfo: 'txtInput]middle room]4]',
      tabledata: dfx + ',' + dfy + ']Color(0xffa6e4ff)]14]',
    ));
  }

  Future<void> updateTableAtPosition(BuildContext context, String zonenno,
      String tableno, String info, double _x, double _y) async {
    int tableid = checkNo(
        Provider.of<RestTableUsageModel>(context, listen: false).inventoryList,
        'Z02',
        tableno);
    var inventoryDb = Provider.of<RestTableUsageModel>(context, listen: false);
    String dfx = df.format(_x);
    String dfy = df.format(_y);
    await inventoryDb.updateItem(
        tableid,
        TableUsage(
          tablekey: zonenno + ']' + tableno + ']',
          tableinfo: 'txtInput]middle room]4]',
          tabledata: dfx + ',' + dfy + ']Color(0xffa6e4ff)]14]',
        ));
  }

  int checkNo(List<TableUsage> tableusageList, String zoneno, String tableno) {
    int i = 0;
    while (i < tableusageList.length) {
      if (zoneno + ']' + tableno + ']' == tableusageList[i].tablekey) {
        return i;
      }
      i = i + 1;
    }
    return i;
  }

  //-----------------------Unimplement Functions-----------------------------
  Future<void> salesHold() async {
    return "";
  }

  Future<void> salesReturn() async {
    return "";
  }

  Future<void> salesDeposit(double depositAmount) async {
    return "";
  }

  Future<void> couponDisc(double couponAmount) async {
    return "";
  }

  Future<void> amtDisc(double amountDisc) async {
    return "";
  }

  Future<void> percDisc(double percDisc) async {
    return "";
  }

  Future<void> amtCharge(double amountChrg) async {
    return "";
  }

  Future<void> percCharge(double percChrg) async {
    return "";
  }

  Future<void> cashIn(double amountCashIn) async {
    return "";
  }

  Future<void> cashOut(double amountCashOut) async {
    return "";
  }
}

mixin Posinput {}
