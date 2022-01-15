import 'package:com_csith_geniuzpos/resources/fnccal.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/data/possales/bdcitemmodel.dart';
import 'package:com_csith_geniuzpos/models/possales/salesItemSummary.dart';
import 'package:com_csith_geniuzpos/models/possales/salesitem.dart';
import 'package:com_csith_geniuzpos/models/possales/salesitems.dart';
import 'package:com_csith_geniuzpos/utility/hiveHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class PosBDCCtrl {
  HiveCtrl con = new HiveCtrl();

  //----------------SALES ITEM SUMMARY--------
  Future<SalesItemSummary> salesItemSummary(BuildContext context) async {
    return await PosInput().getSalesSUMItems(context);
  }

  //----------------SALES ITEM----------------
  Future<String> salesItemFree(BuildContext context) async {
    var model = Provider.of<BillDCItemHiveModel>(context, listen: false);
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

  Future<double> addSalesItem(BuildContext context, SalesItems sales) async {
    var inventoryDb = Provider.of<BillDCItemHiveModel>(context, listen: false);
    String plu, itemtype, salesitem, disccode, vatcode;
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
    await inventoryDb.addItem(SalesItem(
        saleskey: plu + ']' + itemtype + ']',
        salesinfo: salesitem + ']' + disccode + ']' + vatcode + ']',
        salesdata: df.format(qty) +
            ']' +
            df.format(price) +
            ']' +
            df.format(amount) +
            ']' +
            df.format(disc) +
            ']'));
    return amount;
  }

  Future<void> voidSalesItem(BuildContext context) async {
    var inventoryDb = Provider.of<BillDCItemHiveModel>(context, listen: false);
    return await inventoryDb.deleteAllItem();
  }

  Future<SalesItems> voidASalesItem(BuildContext context, int index) async {
    var inventoryDb = Provider.of<BillDCItemHiveModel>(context, listen: false);
    return await inventoryDb.deleteItem(index);
  }

  Future<SalesItems> getASalesItem(BuildContext context, int index) async {
    var inventoryDb = Provider.of<BillDCItemHiveModel>(context, listen: false);
    return await inventoryDb.getLastPluItem();
  }

  Future<double> getDiscChgBalAmount(
      double sumsalesitem, double discount, double charge) async {
    return sumsalesitem + charge - discount;
  }

  Future<double> voidABDCBItem(BuildContext context, int index) async {
    var inventoryDb = Provider.of<BillDCItemHiveModel>(context, listen: false);
    double amount;
    if (index == -1) {
      //void all
      amount = 0;
      await inventoryDb.deleteAllItem();
    } else {
      int lastindex = inventoryDb.inventoryList.length - 1;
      amount = await inventoryDb.getLastBDCBamount();
      await inventoryDb.deleteItem(lastindex);
    }

    return amount;
  }

  Future<void> voidALLItem(BuildContext context) async {
    var inventoryDb = Provider.of<BillDCItemHiveModel>(context, listen: false);
    await inventoryDb.deleteAllItem();
    // return null;
  }

  bool checkBDC(SalesItem ss) {
    String vatcode;

    vatcode = '';
    var f = ss.salesinfo.split(']');
    if (f.length > 2) {
      vatcode = f[2];
      if (vatcode.isEmpty || vatcode == '') {
      } else {
        if (vatcode == Palette.modeType_BDC) {
          return true;
        } else {
          return false;
        }
      }
    }

    return true;
  }
}
