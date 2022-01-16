import 'package:com_csith_geniuzpos/resources/posacm_data.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';
import 'package:com_csith_geniuzpos/models/posctrls/poscontrol.dart';
import 'package:com_csith_geniuzpos/utility/hiveHelper.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class PosControlModel with ChangeNotifier {
  HiveCtrl con = new HiveCtrl();
  List _poscontrolList = <PosControl>[];
  PosControl _poscontrolByID;
  List get poscontrolList => _poscontrolList;
  get poscontrol => _poscontrolByID;
  List<Box> boxes;

  addItem(PosControl posctrl) async {
    // boxes = await con.openBox();
    if (boxes[2] != null) {
      boxes[2].add(posctrl);
    }

    notifyListeners();
  }

  getItem() async {
    boxes = await con.openBox();
    if (boxes[2] != null) {
      _poscontrolList = boxes[2].values.toList();
    }

    notifyListeners();
  }

  // HiveCtrl con = new HiveCtrl();

  // List<Box> boxes;

  // List _poscontrolList = <PosControl>[];

  // PosControl _poscontrolByID;

  // List get poscontrolList => _poscontrolList;
  // get poscontrol => _poscontrolByID;

  // getItem() async {
  //   boxes = await con.openBox();
  //   _poscontrolList = boxes[2].values.toList();
  //   notifyListeners();
  // }

  getAItem(int key) async {
    boxes = await con.openBox();
    if (boxes[2] != null) {
      _poscontrolByID = boxes[2].getAt(key);
    }

    notifyListeners();
  }

  openBox() async {
    boxes = await con.openBox();
  }

  // addItem(PosControl inventory) async {
  //   boxes[2].add(inventory);

  //   notifyListeners();
  // }

  updateItem(int index, PosControl inventory) {
    boxes[2].putAt(index, inventory);
    notifyListeners();
  }

  deleteItem(int index) {
    boxes[2].delete(index);
    getItem();

    notifyListeners();
  }

  PosControl getPosControlByID(int key) {
    // openBox();
    _poscontrolByID = boxes[2].getAt(key);
    return _poscontrolByID;
  }

  // //-----------------------------------
  // List<Box> boxesACM;

  // List _posAcmList = <PosControl>[];

  // PosControl _posacmByID;

  // List get posacmList => _posAcmList;
  // get posacm => _posacmByID;

  // getItemACM(String cshID) async {
  //   //_posAcmList = PosAcm().posCycleAcm;
  //   // boxesACM = await openBoxACM(cshID);
  //   // _posAcmList = boxesACM[1].values.toList();
  //   notifyListeners();
  // }

  // getAItemACM(int key, String cshID) async {
  //   _posacmByID =
  //       PosControlFnc().getPocControlFmPosCtrl(PosAcm().posCycleAcm[key]);
  //   // boxesACM = await openBoxACM(cshID);
  //   // _posacmByID = boxesACM[1].getAt(key);
  //   notifyListeners();
  // }

  // openBoxACM(String cshID) async {
  //   // boxesACM = await con.openBoxT(cshID);
  // }

  // addItemACM(PosControl inventory) async {
  //   // boxesACM[1].add(inventory);

  //   notifyListeners();
  // }

  // updateItemACM(int index, PosControl inventory) {
  //   // boxesACM[1].putAt(index, inventory);
  //   notifyListeners();
  // }

  // deleteItemACM(int index, String cshID) {
  //   // boxesACM[1].delete(index);
  //   // getItemACM(cshID);

  //   notifyListeners();
  // }

  // PosControl getPosACMByID(int key) {
  //   // openBox();
  //   // _posacmByID = boxesACM[1].getAt(key);
  //   return _posacmByID;
  // }
}
