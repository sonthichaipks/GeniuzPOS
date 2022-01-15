import 'package:com_csith_geniuzpos/utility/hiveHelper.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/models/possales/salesitem.dart';
import 'package:com_csith_geniuzpos/models/possales/salesitems.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ReceiptItemHiveModel with ChangeNotifier {
  HiveCtrl con = new HiveCtrl();
  List _salesItemList = <SalesItem>[];
  SalesItems _salesAItem;
  List get inventoryList => _salesItemList;
  get salesAItem => _salesAItem;
  List<Box> boxes;

  addItem(SalesItem saleitem) async {
    boxes[4].add(saleitem);
    notifyListeners();
  }

  getItem() async {
    boxes = await con.openBox();
    _salesItemList = boxes[4].values.toList();

    notifyListeners();
  }

  Future<void> updateItem(int index, SalesItem saleitem) async {
    boxes[4].putAt(index, saleitem);

    notifyListeners();
  }

  deleteItem(int index) async {
    try {
      int lastindex = inventoryList.length - 1;
      if (lastindex >= index) {
        boxes[4].delete(index);
      } else {
        boxes[4].clear();
      }
    } catch (e) {
      boxes[4].clear();
    }

    notifyListeners();
  }

  deleteAllItem() {
    boxes[4].clear();

    notifyListeners();
  }

  Future<SalesItems> getAItem(int index) async {
    boxes = await con.openBox();
    return PosInput().getSalesItem(boxes[4].get(index));
  }

//--------POS BU FLOW-: Last Plu Item --------------
  Future<SalesItems> getLastPluItem() async {
    int index = -1;
    int lastindex = inventoryList.length;
    double netamt = 0;
    SalesItems _s;
    if (lastindex > 0) {
      // index = lastindex - 1;
      for (int i = lastindex - 1; i > -1; i--) {
        _s = PosInput().getSalesItem(boxes[4].get(i));
        netamt += _s.amount;
        if (PosInput().checkLastSalesItem(boxes[4].get(i)) == 10) {
          index = i;
          break; //will loop all to the end list.
        }
      }
    }
    if (index < 0) {
      return PosInput().getNullSalesItem();
    }
    return new SalesItems(_s.salesitem, _s.plu, _s.qty, _s.price, _s.disccode,
        _s.amount - netamt, netamt, _s.vatcode, 'Pcs', 0);
  }

  Future<double> getLastRCPamount() async {
    try {
      SalesItems _s;
      int lastindex = inventoryList.length;
      if (lastindex > 1) {
        _s = PosInput().getSalesItem(boxes[4].get(lastindex - 1));
        return _s.amount;
      }
    } catch (e) {}

    return 0.0;
  }

  Future<void> updateLastPluItem(SalesItem saleitem) async {
    int index = -1;
    int lastindex = inventoryList.length;
    if (lastindex > 0) {
      for (int i = 0; i < lastindex - 1; i++) {
        if (PosInput().checkLastSalesItem(boxes[4].get(i)) == 10) {
          index = i;
        }
      }
    }

    if (index >= 0) {
      boxes[4].putAt(index, saleitem);
    }

    notifyListeners();
  }
}
