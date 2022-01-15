import 'package:com_csith_geniuzpos/models/buttons/hive_tableusages.dart';
import 'package:com_csith_geniuzpos/utility/hiveHelper.dart';

//import 'package:com_csith_geniuzpos/utility/my_config.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class RestTableUsageModel with ChangeNotifier {
  // String _tableusageBox = MyConfig().tablesUsageName;
  HiveCtrl con = new HiveCtrl();

  List<Box> boxes;

  List _tableusageList = <TableUsage>[];

  List get inventoryList => _tableusageList;

  addItem(TableUsage inventory) async {
    // var box = await Hive.openBox<TableUsage>(_tableusageBox);

    // box.add(inventory);

    boxes[1].add(inventory);

    notifyListeners();
  }

  getItem() async {
    // final box = await Hive.openBox<TableUsage>(_tableusageBox);

    // _tableusageList = box.values.toList();

    boxes = await con.openBox();
    _tableusageList = boxes[1].values.toList();

    debugPrint('RestTableUsageModel:getItem: OK = ' +
        _tableusageList.length.toString());
    notifyListeners();
  }

  updateItem(int index, TableUsage inventory) {
    // final box = Hive.box<TableUsage>(_tableusageBox);

    // box.putAt(index, inventory);
    boxes[1].putAt(index, inventory);
    notifyListeners();
  }

  deleteItem(int index) {
    // final box = Hive.box<TableUsage>(_tableusageBox);

    // box.deleteAt(index);
    boxes[1].delete(index);
    getItem();

    notifyListeners();
  }
}
