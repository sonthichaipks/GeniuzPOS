import 'dart:io';

// import 'package:com_csith_geniuzpos/config/os.dart';
// import 'package:com_csith_geniuzpos/data/possales/bdcitemmodel.dart';
// import 'package:com_csith_geniuzpos/data/possales/rcpitemmodel.dart';
// import 'package:com_csith_geniuzpos/models/buttons/hive_tableusages.dart';
// import 'package:com_csith_geniuzpos/models/posctrls/poscontrol.dart';
// import 'package:com_csith_geniuzpos/config/csiconfig.dart';
// import 'package:com_csith_geniuzpos/models/possales/salesitem.dart';
// import 'package:com_csith_geniuzpos/utility/normal_dialog.dart';
import 'package:com_csith_geniuzpos/models/buttons/hive_tableusages.dart';
import 'package:com_csith_geniuzpos/models/posctrls/poscontrol.dart';
import 'package:com_csith_geniuzpos/models/possales/salesitem.dart';
import 'package:com_csith_geniuzpos/resources/csiconfig.dart';
import 'package:com_csith_geniuzpos/utility/os.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class HiveCtrl {
  Future<String> hiveDataInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    String _path = '';
    if (OS.deviceinfo() == 'Windows') {
      _path = MyConfig().winData;
      Hive.init(_path);
    } else if (OS.deviceinfo() == 'Web') {
      Directory directory = await getApplicationDocumentsDirectory();
      _path = directory.path;
      Hive.init(_path);
    } else {
      Directory directory = await getApplicationDocumentsDirectory();
      _path = directory.path;
      Hive.init(_path);
    }
    debugPrint(OS.deviceinfo() + ':' + _path);
    Hive.registerAdapter(PosControlAdapter());
    Hive.registerAdapter(TableUsageAdapter());
    Hive.registerAdapter(SalesItemAdapter()); //use for [sales, bill , receipt]

    return "OK";
  }

  Future<List<Box>> openBox() async {
    List<Box> boxList = [];
    var boxsales = await Hive.openBox<SalesItem>(MyConfig().salesitemName);
    var boxtables = await Hive.openBox<TableUsage>(MyConfig().tablesUsageName);
    var boxtposctrl = await Hive.openBox<PosControl>(MyConfig().poscontrolName);
    var boxbdc = await Hive.openBox<SalesItem>(MyConfig().salesbdcName);
    var boxreceipt = await Hive.openBox<SalesItem>(MyConfig().salesrcpName);
    var boxpsparam = await Hive.openBox<PosControl>(MyConfig()
        .poscycleName
        .replaceAll('YYMMDD', DateFormat('yyMMdd').format(DateTime.now())));
    boxList.add(boxsales); // ---0
    boxList.add(boxtables);
    boxList.add(boxtposctrl); //--2
    boxList.add(boxbdc); //---3
    boxList.add(boxreceipt); //---4
    boxList.add(boxpsparam); //--5
    return boxList;
  }

  Future<List<Box>> openBoxT(String casherId) async {
    List<Box> boxTList = [];
    String poscycleFileName =
        MyConfig().poscycleName.replaceAll('XXXXX', casherId);
    var boxposcycle = await Hive.openBox<PosControl>(poscycleFileName);

    boxTList.add(boxposcycle);

    return boxTList;
  }

  Future<String> closeBox(List<Box> boxList) async {
    for (Box box in boxList) await box.close();
    return "OK";
  }

  Future<String> closeBoxT(List<Box> boxList) async {
    for (Box box in boxList) await box.close();
    return "OK";
  }
}
