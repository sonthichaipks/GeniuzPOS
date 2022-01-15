import 'package:com_csith_geniuzpos/utility/hiveHelper.dart';
import 'package:hive/hive.dart';

class SalesItemRequest {
  //-------INITIAL FUNCTION-----------------
  HiveCtrl con = new HiveCtrl();

  Future<String> initDataFiles() {
    var result = con.hiveDataInit();
    return result;
  }

  Future<String> closeDataFiles(List<Box> boxList) {
    var result = con.closeBox(boxList);
    return result;
  }
}
