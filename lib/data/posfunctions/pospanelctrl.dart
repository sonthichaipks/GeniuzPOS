import 'package:com_csith_geniuzpos/resources/csiconfig.dart';
import 'package:com_csith_geniuzpos/resources/fnccal.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolmodel.dart';
import 'package:com_csith_geniuzpos/data/wsHelper.dart';
import 'package:com_csith_geniuzpos/models/buttons/buttuns.dart';
import 'package:com_csith_geniuzpos/models/posctrls/poscontrol.dart';
import 'package:com_csith_geniuzpos/models/posmodels/groupPanel.dart';
import 'package:com_csith_geniuzpos/models/posmodels/itemPanel.dart';
import 'package:com_csith_geniuzpos/models/posmodels/touchPanel.dart';
import 'package:com_csith_geniuzpos/utility/normal_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:show_network_interface_info/model/NetworkDevice.dart';
import 'package:show_network_interface_info/show_network_interface_info.dart';

class PosPanelCtrl {
  PosPanelCtrl();
  List<GroupPanel> groupPanelList;
  List<ItemPanel> itemPanelList;

  Future<List<TouchPanel>> getPanelFromWS(String pnlurl) async {
    List<TouchPanel> list;
    var data = await wsList(pnlurl);
    if (data != null) {
      list = touchPanelFromJson(data);
    }
    return list;
  }

  Future<String> exeAboutPanelToWS(String pnlurl) async {
    return await wsExec(pnlurl);
  }

  void setCurImgUrl() async {
    for (var itm in itemPanelList) {
      itm.itemButtonImage =
          await PosControlFnc().getCurrentIP(itm.itemButtonImage);
    }
  }

  void setCurGroupImgUrl() async {
    for (var itm in groupPanelList) {
      itm.groupButtonImage =
          await PosControlFnc().getCurrentIP(itm.groupButtonImage);
    }
  }

  Future<List<GroupPanel>> getGrpPanelFromWS(String pnlurl) async {
    List<GroupPanel> list;
    var data = await wsList(pnlurl);
    if (data != null) {
      groupPanelList = groupPanelFromJson(data);
      setCurGroupImgUrl();
      return groupPanelList;
    }
    return list;
  }

  Future<List<ItemPanel>> getItemPanelFromWS(String pnlurl) async {
    List<ItemPanel> list;
    var data = await wsList(pnlurl);
    if (data != null) {
      itemPanelList = itemPanelFromJson(data);
      setCurImgUrl();
      return itemPanelList;
    }
    return list;
  }

  PosButtonX getGBFromGpnl(GroupPanel _grpPnl) {
    PosButtonX grpButtuons;
    if (_grpPnl != null) {
      if (_grpPnl != null) {
        return new PosButtonX(
          label: getLabel(_grpPnl.groupButtonLabel),
          imageUrl: getImgUrl(_grpPnl.groupButtonImage),
          cmdCode: 'grpInput',
          kybCode: _grpPnl.groupButtonId.toString(),
          btnColor: getColorFromHex(_grpPnl.bgColor),
          btnXwid: 1.5,
          btnFSize: _grpPnl.txtFontSize,
          txtColor: getColorFromHex(_grpPnl.txtColor),
          replresentOf: 0,
          id: _grpPnl.id,
          panelId: _grpPnl.touchPanelType,
          groupId: _grpPnl.id,
        );
      }
    }

    return grpButtuons;
  }

  PosButtonX getListFromItemPnl(ItemPanel _itemPnl) {
    PosButtonX grpButtuons;
    //if (itemPanelList != null && itemPanelList.length > 0) {
    // for (ItemPanel _itemPnl in itemPanelList) {
    if (_itemPnl != null) {
      return new PosButtonX(
        label: getLabel(_itemPnl.itemButtonLabel),
        imageUrl: getImgUrl(_itemPnl.itemButtonImage),
        // 'http://192.168.2.67:8080/food/Capusino.jpg', //_itemPnl.itemButtonImage,
        cmdCode: 'txtInput',
        kybCode: _itemPnl.linkCode,
        btnColor: getColorFromHex(_itemPnl.bgColor),
        btnXwid: 1 * (8 / 6),
        btnFSize: _itemPnl.txtFontSize,
        txtColor: getColorFromHex(_itemPnl.txtColor),
        replresentOf: _itemPnl.linkCodeFg,
        id: _itemPnl.id,
        panelId: _itemPnl.touchPanelType,
        groupId: _itemPnl.groupButtonId,
        itemId: _itemPnl.itemButtonId,
      );
    }
    //   }
    // }

    return grpButtuons;
  }

  PosButtonX getBlankPnl() {
    return new PosButtonX(
      label: 'Blank',
      imageUrl: null,
      cmdCode: '',
      kybCode: '',
      btnColor: Palette.stdbutton_theme_0,
      btnXwid: 1 * (8 / 6),
      btnFSize: 13,
      txtColor: Palette.stdbutton_theme_0,
      replresentOf: 0,
      id: 1,
      panelId: '',
      groupId: 0,
    );
  }

  int maxPanelListByColumns(int pnlCols, int itemlistCnt) {
    if (itemlistCnt > 0) {
      int modValue = int.parse(cno.format(itemlistCnt / pnlCols));
      bool checkFit = (modValue) == (itemlistCnt / pnlCols);
      int maxrow = (checkFit) ? (modValue) : (modValue) + 1;
      return maxrow; // * pnlCols;
    } else {
      return -1;
    }
  }

  String getLabel(String lbl) {
    if (lbl == '...') {
      return '';
    } else {
      return lbl;
    }
  }

  String getImgUrl(String Url) {
    String result = Url.replaceAll('[[', 'https://')
        .replaceAll('[', 'http://')
        .replaceAll('=', '/');
    return result;
  }

  Color getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    } else {
      return Color(int.parse("0xffffffff"));
    }
  }

  Color colorConvert(String color) {
    color = color.replaceAll("#", "");
    if (color.length == 6) {
      color = "0xFF" + color;
    } else if (color.length == 8) {
      color = "0x" + color;
    }
    return Color(int.parse(color));
  }

  String getPnlUploadUrl(BuildContext context) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_memWSurl];
    String result =
        PosControlFnc().getCurrentSettingValues(context, _searchpslist);
    PosCtrl _searchpslist2 = posCtrlList[MyConfig().i_pluWSurl];
    String result2 =
        PosControlFnc().getCurrentSettingValues(context, _searchpslist2);

    return result.replaceAll('', '');
  }

  String getPLUpnlurl(BuildContext context, String _body) {
    //http://192.168.2.67:9393/PnlItem
    //-----item id -- bgColor/txtColor/FontSize -- lingFg/LinkCode --label/imageUrl
    //u/e/ 17/        ff898989/000000/14           /1/FB0103-3-75    /LabMooTod/11947746eb5d4df69a06bca1d485008d.jpg

    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_pluWSurl];
    String result;
    try {
      result = PosControlFnc().getCurrentSettingValues(context, _searchpslist);
      result = result.replaceAll('//', '#');
      result = result + '/csplus/i/' + _body;
      result = result.replaceAll('#', '//');
    } catch (e) {
      normalDialog(context, e.toString());
    }
    return result;
  }

  String getPanelurl(BuildContext context) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_pluWSurl];
    String result;
    try {
      result = PosControlFnc().getCurrentSettingValues(context, _searchpslist);
      result = result.replaceAll('//', '#');
      result = result + '/TouchPanel';
      result = result.replaceAll('#', '//');
    } catch (e) {
      normalDialog(context, e.toString());
    }
    return result;
  }

  String getItemPanelurl(BuildContext context) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_pluWSurl];
    String result;
    try {
      result = PosControlFnc().getCurrentSettingValues(context, _searchpslist);
      result = result.replaceAll('//', '#');
      result = result + '/pnlitem';
      result = result.replaceAll('#', '//');
    } catch (e) {
      normalDialog(context, e.toString());
    }
    return result;
  }

  String getUpdateItemlurl(BuildContext context, String _body) {
    //http://192.168.2.67:9393/PnlItem
    //-----item id -- bgColor/txtColor/FontSize -- lingFg/LinkCode --label/imageUrl
    //u/e/ 17/        ff898989/000000/14           /1/FB0103-3-75    /LabMooTod/11947746eb5d4df69a06bca1d485008d.jpg

    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_pluWSurl];
    String result;
    try {
      result = PosControlFnc().getCurrentSettingValues(context, _searchpslist);
      result = result.replaceAll('//', '#');
      //result = result.split('/')[0] + '/PnlItem/u/e/' + _body; -- old
      result = result + '/PnlItem/u/' + _body;
      result = result.replaceAll('#', '//');
    } catch (e) {
      normalDialog(context, e.toString());
    }
    return result;
  }

  String getAddItemlurl(BuildContext context, String _body) {
    //http://192.168.2.67:9393/GrpPnl/a/
    //RT002/21/21002   /ff898989/fffff/18/    1/FB0103-3-75/   TomYamKung/11947746eb5d4df69a06bca1d485008d.jpg
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_pluWSurl];
    String result;
    try {
      result = PosControlFnc().getCurrentSettingValues(context, _searchpslist);
      result = result.replaceAll('//', '#');
      result = result + '/PnlItem/a/' + _body;
      result = result.replaceAll('#', '//');
    } catch (e) {
      normalDialog(context, e.toString());
    }
    return result;
  }

  String getPasteIpnlurl(BuildContext context, String _body) {
    //----Id/ Panel/GroupId
    // http://192.168.2.57:9393/PnlItem/p/  72/  RT002/31/ 26

    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_pluWSurl];
    String result;
    try {
      result = PosControlFnc().getCurrentSettingValues(context, _searchpslist);
      result = result.replaceAll('//', '#');
      result = result + '/PnlItem/p/' + _body;
      result = result.replaceAll('#', '//');
    } catch (e) {
      normalDialog(context, e.toString());
    }
    return result;
  }

  String getSortItpnlurl(BuildContext context, String _body) {
    //http://192.168.2.57:9393/PnlItem/s/FB001/26

    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_pluWSurl];
    String result;
    try {
      result = PosControlFnc().getCurrentSettingValues(context, _searchpslist);
      result = result.replaceAll('//', '#');
      result = result + '/PnlItem/s/' + _body;
      result = result.replaceAll('#', '//');
    } catch (e) {
      normalDialog(context, e.toString());
    }
    return result;
  }

  String getSortGPpnlurl(BuildContext context, String _body) {
    // http://192.168.2.57:9393/GrpPnl/s/RT002/u

    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_pluWSurl];
    String result;
    try {
      result = PosControlFnc().getCurrentSettingValues(context, _searchpslist);
      result = result.replaceAll('//', '#');
      result = result + '/grppnl/s/' + _body + '/u';
      result = result.replaceAll('#', '//');
    } catch (e) {
      normalDialog(context, e.toString());
    }
    return result;
  }

  String getDelItemPanelurl(BuildContext context, String _body) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_pluWSurl];
    String result;
    try {
      result = PosControlFnc().getCurrentSettingValues(context, _searchpslist);
      result = result.replaceAll('//', '#');
      result = result + '/PnlItem/d/' + _body;
      result = result.replaceAll('#', '//');
    } catch (e) {
      normalDialog(context, e.toString());
    }
    return result;
  }

  String getGrpPanelurl(BuildContext context) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_pluWSurl];
    String result;
    try {
      result = PosControlFnc().getCurrentSettingValues(context, _searchpslist);
      result = result.replaceAll('//', '#');
      result = result + '/grppnl';
      result = result.replaceAll('#', '//');
    } catch (e) {
      normalDialog(context, e.toString());
    }
    return result;
  }

  String getAddGpnlurl(BuildContext context, String _body) {
    //----Panel/GroupId ---bgColor/txtColor/FontSize --Label/imageUrl
    // http://192.168.2.67:9393/GrpPnl/a/
    // RT003/33/  ff898989/00000000/18.0/  ของชำร่วย/temp.jpg
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_pluWSurl];
    String result;
    try {
      result = PosControlFnc().getCurrentSettingValues(context, _searchpslist);
      result = result.replaceAll('//', '#');
      result = result + '/GrpPnl/a/' + _body;
      result = result.replaceAll('#', '//');
    } catch (e) {
      normalDialog(context, e.toString());
    }
    return result;
  }

  String getPasteGpnlurl(BuildContext context, String _body) {
    //----Id/ Panel/GroupId
    // http://192.168.2.57:9393/GrpPnl/p/  31/  RT002/  25

    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_pluWSurl];
    String result;
    try {
      result = PosControlFnc().getCurrentSettingValues(context, _searchpslist);
      result = result.replaceAll('//', '#');
      result = result + '/GrpPnl/p/' + _body;
      result = result.replaceAll('#', '//');
    } catch (e) {
      normalDialog(context, e.toString());
    }
    return result;
  }

  String getUpdateGpnlurl(BuildContext context, String _body) {
    //http://192.168.2.67:9393/GrpPnl
    //-----id-Panel/Group ID -- bgColor/txtColor/FontSize -- label/imageUrl
    ///u/e/  24/RT003/33/       ff242424/11111111/22         /TEST/temp.jpg
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_pluWSurl];
    String result;
    try {
      result = PosControlFnc().getCurrentSettingValues(context, _searchpslist);
      result = result.replaceAll('//', '#');
      result = result + '/GrpPnl/u/e/' + _body;
      result = result.replaceAll('#', '//');
    } catch (e) {
      normalDialog(context, e.toString());
    }
    return result;
  }

  String getDelGroupPanelurl(BuildContext context, String _body) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_pluWSurl];
    String result;
    try {
      result = PosControlFnc().getCurrentSettingValues(context, _searchpslist);
      result = result.replaceAll('//', '#');
      result = result + '/GrpPnl/d/' + _body;
      result = result.replaceAll('#', '//');
    } catch (e) {
      normalDialog(context, e.toString());
    }
    return result;
  }

  String getAddPanelurl(BuildContext context, String _body) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_pluWSurl];
    String result;
    try {
      result = PosControlFnc().getCurrentSettingValues(context, _searchpslist);
      result = result.replaceAll('//', '#');
      result = result + '/TouchPanel/a/' + _body;
      result = result.replaceAll('#', '//');
    } catch (e) {
      normalDialog(context, e.toString());
    }
    return result;
  }

  String getSavePanelurl(BuildContext context, String _body) {
    //http://192.168.2.67:9393/TouchPanel/u/e/1/RT/Snack Choice
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_pluWSurl];
    String result;
    try {
      result = PosControlFnc().getCurrentSettingValues(context, _searchpslist);
      result = result.replaceAll('//', '#');
      result = result + '/TouchPanel/u/e/' + _body;
      result = result.replaceAll('#', '//');
    } catch (e) {
      normalDialog(context, e.toString());
    }
    return result;
  }

  String getDelPanelurl(BuildContext context, String _body) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_pluWSurl];
    String result;
    try {
      result = PosControlFnc().getCurrentSettingValues(context, _searchpslist);
      result = result.replaceAll('//', '#');
      result = result + '/TouchPanel/d/' + _body;
      result = result.replaceAll('#', '//');
    } catch (e) {
      normalDialog(context, e.toString());
    }
    return result;
  }

  // Future<List<NetworkDevice>> getIPinfoList() async {
  //   try {
  //     return await ShowNetworkInterfaceInfo.getNetWorkInfo;
  //   } catch (exception) {
  //     return exception.message;
  //   }
  // }

  // Future<String> getCurrentIP(String dataimgUrl) async {
  //   List<NetworkDevice> getCurIpList = await getIPinfoList();

  //   if (getCurIpList != null) {
  //     String chkIP, MyIp;
  //     for (var ntw in getCurIpList) {
  //       chkIP = ntw.networkInfoList[0].ip;
  //       if (chkIP.split('.')[2] == '1' || chkIP.split('.')[2] == '') {
  //         MyIp = chkIP;
  //         break;
  //       }
  //     }
  //     //String MyIp = getCurIpList[3].networkInfoList[0].ip;
  //     dataimgUrl = dataimgUrl.replaceAll('http://', '');
  //     dataimgUrl = dataimgUrl.replaceAll('https://', '');
  //     String getCurIp;
  //     if (MyIp != '') {
  //       if (dataimgUrl.lastIndexOf(':') > 0) {
  //         getCurIp = MyIp + ':' + dataimgUrl.split(':')[1];
  //       } else {
  //         dataimgUrl = dataimgUrl.replaceAll(dataimgUrl.split('/')[0], '');
  //         getCurIp = MyIp + '/' + dataimgUrl;
  //       }
  //       //  getCurIp = getCurIp.replaceAll('/getsaleitem', '');
  //       return 'http://' + getCurIp;
  //     }
  //   }
  //   return '';
  // }
}
