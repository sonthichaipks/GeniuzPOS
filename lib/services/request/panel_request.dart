import 'package:com_csith_geniuzpos/data/posfunctions/pospanelctrl.dart';
import 'package:com_csith_geniuzpos/models/posmodels/groupPanel.dart';
import 'package:com_csith_geniuzpos/models/posmodels/itemPanel.dart';
import 'package:com_csith_geniuzpos/models/posmodels/touchPanel.dart';

class PosPanelRequest {
  PosPanelCtrl con = new PosPanelCtrl();
  // List<GroupPanel> groupPanelList;
  // List<ItemPanel> itemPanelList;

  Future<List<TouchPanel>> loadTouchPanel(String pnlurl) {
    return con.getPanelFromWS(pnlurl);
  }

  Future<String> exeAboutPanelToWS(String pnlurl) {
    return con.exeAboutPanelToWS(pnlurl);
  }

  Future<List<GroupPanel>> loadGrpPanel(String pnlurl) {
    //http://192.168.2.67:9393/grppnl/

    return con.getGrpPanelFromWS(pnlurl);
  }

  Future<List<ItemPanel>> loadItemPanel(String pnlurl) {
    // http://192.168.2.67:9393/pnlitem/RT002/2/
    return con.getItemPanelFromWS(pnlurl);
  }

  // void setCurImgUrl() async {
  //   for (var itm in itemPanelList) {
  //     itm.itemButtonImage =
  //         await PosPanelCtrl().getCurrentIP(itm.itemButtonImage);
  //   }
  // }

  // void setCurGroupImgUrl() async {
  //   for (var itm in groupPanelList) {
  //     itm.groupButtonImage =
  //         await PosPanelCtrl().getCurrentIP(itm.groupButtonImage);
  //   }
  // }
}
