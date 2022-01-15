import 'package:com_csith_geniuzpos/resources/os.dart';
import 'package:com_csith_geniuzpos/models/posctrls/poscontrol.dart';
import 'package:com_csith_geniuzpos/utility/hiveHelper.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class PosAcmModel with ChangeNotifier {
  HiveCtrl con = new HiveCtrl();

  List<Box> boxes;

  List _poscontrolList = <PosControl>[];

  PosControl _poscontrolByID;

  List get poscontrolList => _poscontrolList;
  get poscontrol => _poscontrolByID;

  getItem() async {
    boxes = await con.openBox();
    _poscontrolList = boxes[5].values.toList();
    notifyListeners();
  }

  getAItem(int key) async {
    boxes = await con.openBox();
    _poscontrolByID = boxes[5].getAt(key);

    notifyListeners();
  }

  getByKey(String keys) async {
    // boxes = await con.openBox();
    _poscontrolByID = boxes[5].get(keys);

    notifyListeners();
  }

  openBox() async {
    boxes = await con.openBox();
  }

  addItem(PosControl inventory) async {
    boxes[5].add(inventory);
    getItem();
  }

  updateItem(int index, PosControl inventory) {
    boxes[5].putAt(index, inventory);
    getItem();
  }

  deleteItem(int index) {
    boxes[5].delete(index);
    getItem();
  }

  deleteAllItem() async {
    boxes[5].clear();
    // OS().deletePosCycleFile();
    getItem();
  }

  deleteAll() {
    boxes[5].clear();
    getItem();
  }

  PosControl getPosControlByID(int key) {
    // openBox();
    _poscontrolByID = boxes[5].getAt(key);
    return _poscontrolByID;
  }
}
