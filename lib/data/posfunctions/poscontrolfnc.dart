import 'dart:convert';
import 'dart:typed_data';
import 'package:com_csith_geniuzpos/resources/csiconfig.dart';
import 'package:com_csith_geniuzpos/resources/fnccal.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/resources/posacm_data.dart';
import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolmodel.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/pospanelctrl.dart';
import 'package:com_csith_geniuzpos/data/possales/bdcitemmodel.dart';
import 'package:com_csith_geniuzpos/data/possales/rcpitemmodel.dart';
import 'package:com_csith_geniuzpos/data/possales/salesitemmodel.dart';
import 'package:com_csith_geniuzpos/models/posctrls/poscontrol.dart';
import 'package:com_csith_geniuzpos/models/posmodels/posshiftlogin.dart';
import 'package:com_csith_geniuzpos/models/possales/salesItemSummary.dart';
import 'package:com_csith_geniuzpos/models/possales/salesitem.dart';
import 'package:com_csith_geniuzpos/screens/fullsales/full_salespage.dart';
import 'package:com_csith_geniuzpos/screens/resturants/rest_salespage.dart';
import 'package:com_csith_geniuzpos/screens/retails/retail_salespage.dart';
import 'package:com_csith_geniuzpos/services/response/posdata_response.dart';

import 'package:com_csith_geniuzpos/services/response/posresponse.dart';
import 'package:com_csith_geniuzpos/utility/crc.dart';
import 'package:com_csith_geniuzpos/utility/normal_dialog.dart';
import 'package:crclib/crclib.dart';
import 'package:crclib/reveng.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:show_network_interface_info/model/NetworkDevice.dart';
import 'package:show_network_interface_info/show_network_interface_info.dart';
import 'package:string_to_hex/string_to_hex.dart';

import 'fncitems.dart';

class PosControlFnc {
  PosControlFnc();
  String _urlHost = 'assets';
  get urlHost => _urlHost;
  // String _urlHostPD = 'http://localhost:8080';
  // get urlHostPD => _urlHost;

  void getDefaultScreen(
      BuildContext context, PosFncCallResponse _responseInput) {
    //---stdButtuonMenu = 14.Retail Page, 15.full, 16. seat, 17. F&B
    //---depends on POSCONTROL->...Set to...default page
    var _model = Provider.of<PosControlModel>(context, listen: false);
    try {
      //_urlHost = 'http://' + _model.poscontrolList[0].posctrldata;

      String posScreenType = PosControlFnc().getCurrentSettingValues(
          context, getPosCtrlFmPosControl(_model.poscontrolList[1]));
      posScreenType = posScreenType.split('-')[0].trim();

      List<PosCtrl> screentypes = posCtrlListOpt
          .where((e) => (e.itemcode == _model.poscontrolList[1].posctrlkey))
          .toList();

      if (posScreenType == screentypes[0].valuetext.split('-')[0].trim()) {
        //Std Retail Theme
        FncItems().menucenter(context, _responseInput, stdButtuonMenu[14]);
      } else if (posScreenType ==
          screentypes[1].valuetext.split('-')[0].trim()) {
        //FullSales Retail Theme
        FncItems().menucenter(context, _responseInput, stdButtuonMenu[15]);
      } else if (posScreenType == screentypes[2].valuetext.split('-')[0]) {
        //Food & Beverage Theme
        FncItems().menucenter(context, _responseInput, stdButtuonMenu[16]);
        // } else if (posScreenType == screentypes[3].valuetext.split('-')[0].trim()) {
        //   //Seat zone (Restuarant Theme)

        //   FncItems().menucenter(context, _responseInput, stdButtuonMenu[17]);
      } else {
        FncItems().menucenter(context, _responseInput, stdButtuonMenu[14]);
      }
    } catch (e) {
      FncItems().menucenter(context, _responseInput, stdButtuonMenu[14]);
    }
  }

  void startRefundItem(BuildContext context) async {
    //---clear sales item
    // var salesitem = Provider.of<SalesItemHiveModel>(context, listen: false);
    // salesitem.getItem();
    // await salesitem.deleteAllItem();
    //---clear bill disc/charge
    // var bdcitems = Provider.of<BillDCItemHiveModel>(context, listen: false);
    // bdcitems.getItem();
    // await bdcitems.deleteAllItem();
    //---clear receipt item
    var receiptitems =
        Provider.of<ReceiptItemHiveModel>(context, listen: false);
    receiptitems.getItem();
    await receiptitems.deleteAllItem();
  }

  void startSalesItem(BuildContext context) async {
    //---clear sales item
    var salesitem = Provider.of<SalesItemHiveModel>(context, listen: false);
    salesitem.getItem();
    await salesitem.deleteAllItem();
    //---clear bill disc/charge
    var bdcitems = Provider.of<BillDCItemHiveModel>(context, listen: false);
    bdcitems.getItem();
    await bdcitems.deleteAllItem();
    //---clear receipt item
    var receiptitems =
        Provider.of<ReceiptItemHiveModel>(context, listen: false);
    receiptitems.getItem();
    await receiptitems.deleteAllItem();
  }

  void clearACM(BuildContext context) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
  }

  bool checkSIT(SalesItem ss) {
    String vatcode;

    vatcode = '';
    var f = ss.salesinfo.split(']');
    if (f.length > 2) {
      vatcode = f[2];
      if (vatcode.isEmpty || vatcode == '') {
      } else {
        if (vatcode == Palette.modeType_BDC ||
            vatcode == Palette.modeType_RCP) {
          return false;
        }
      }
    }

    return true;
  }

  bool checkSITBDC(SalesItem ss) {
    String vatcode;

    vatcode = '';
    var f = ss.salesinfo.split(']');
    if (f.length > 2) {
      vatcode = f[2];
      if (vatcode.isEmpty || vatcode == '') {
      } else {
        if (vatcode == Palette.modeType_RCP) {
          return false;
        }
      }
    }

    return true;
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

  bool checkRCP(SalesItem ss) {
    String vatcode;

    vatcode = '';
    var f = ss.salesinfo.split(']');
    if (f.length > 2) {
      vatcode = f[2];
      if (vatcode.isEmpty || vatcode == '') {
      } else {
        if (vatcode == Palette.modeType_RCP) {
          return true;
        } else {
          return false;
        }
      }
    }

    return true;
  }

//----------UPDATE CONFIG FUNCTION-------
  void addPosControl(BuildContext context, PosCtrl _posCtrl) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    int id = getPosCtrlID(_posCtrl.itemcode);
    model.getAItem(id);
    if (model.poscontrol != null) {
      model.updateItem(id, getPocControlFmPosCtrl(_posCtrl));
    } else {
      int dataLen = model.poscontrolList.length;
      int confLen = posCtrlList.length;
      if (confLen - dataLen > 1) {
        normalDialog(
            context,
            'have new Config.ToUpdate=' +
                confLen.toString() +
                '-' +
                dataLen.toString());
        addGapDataWithConf(model, dataLen, confLen);
      } else {
        model.addItem(getPocControlFmPosCtrl(_posCtrl));
      }
    }
  }

  void updatePosControl(BuildContext context, PosCtrl _posCtrl) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    // int id = getPosCtrlID(_posCtrl.itemcode);
    int id = _posCtrl.valueint;
    model.getAItem(id);
    if (model.poscontrol != null) {
      model.updateItem(id, getPocControlFmPosCtrl(_posCtrl));
    } else {
      int dataLen = model.poscontrolList.length;
      int confLen = posCtrlList.length;
      if (confLen - dataLen > 1) {
        // normalDialog(
        //     context,
        //     'have new Config.ToUpdate=' +
        //         confLen.toString() +
        //         '-' +
        //         dataLen.toString());
        addGapDataWithConf(model, dataLen, confLen);
      } else {
        model.addItem(getPocControlFmPosCtrl(_posCtrl));
      }
    }
  }

  void updatePosACM(BuildContext context, PosCtrl _posCtrl) async {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    int id = _posCtrl.valueint;
    model.getAItem(id);
    if (model.poscontrol != null) {
      await model.updateItem(id, getPocControlFmPosCtrl(_posCtrl));
    } else {
      int dataLen = model.poscontrolList.length;
      int confLen = posCtrlList.length;
      if (confLen - dataLen > 1) {
        addGapDataWithConf(model, dataLen, confLen);
      } else {
        await model.addItem(getPocControlFmPosCtrl(_posCtrl));
      }
    }
  }

  void updatePosControlByItemCode(
      BuildContext context, String _itemcode, PosCtrl _posctrl) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    int id = getPosCtrlID(_itemcode) - 1;
    int dataLen = model.poscontrolList.length;
    if (_posctrl != null && id < dataLen) {
      model.updateItem(id, getPocControlFmPosCtrl(_posctrl));
    }
  }

  void addGapDataWithConf(
      PosControlModel model, int dataLen, int confLen) async {
    for (int i = dataLen; i < confLen; i++) {
      PosCtrl posctrl = posCtrlList[i];
      await model.addItem(getPocControlFmPosCtrl(posctrl));
    }
  }

  //---GetFunction of PosConfig
  int getPosCtrlID(String itemcode) {
    return int.parse(itemcode) - 10001;
  }

  String getCurrentSettingValues(BuildContext context, PosCtrl _posCtrl) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    var result = model.poscontrolList
        .where((e) => e.posctrlkey == _posCtrl.itemcode)
        .toList();
    if (result.isNotEmpty) {
      String _result;
      for (PosControl posctrl in result) {
        _result = posctrl.posctrldata;
      }
      return _result;
    } else {
      return _posCtrl.valuetext;
    }
  }

  String getCurrentSettingValuesById(BuildContext context, String itemcode) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    var result =
        model.poscontrolList.where((e) => e.posctrlkey == itemcode).toList();
    if (result.isNotEmpty) {
      String _result;
      for (PosControl posctrl in result) {
        _result = posctrl.posctrldata;
      }
      return _result;
    } else {
      return '';
    }
  }

  PosCtrl getPosCtrlOpt(PosCtrl _posCtrl, String valuetext) {
    try {
      List<PosCtrl> _posCtrlListOpt = posCtrlListOpt
          .where((e) => e.groupcode == _posCtrl.itemcode)
          .where((f) => f.valuetext == valuetext)
          .toList();
      if (_posCtrlListOpt.length > 0) {
        return _posCtrlListOpt[0];
      } else {
        //--incase URL or edit text
        if (_posCtrl.valuetext != valuetext) {
          return PosCtrl(
              itemcode: _posCtrl.itemcode,
              description: _posCtrl.description,
              groupcode: _posCtrl.groupcode,
              valuetext: valuetext,
              valueint: _posCtrl.valueint,
              valuedbl: _posCtrl.valuedbl,
              image: _posCtrl.image);
        }
      }
    } catch (e) {}
    return _posCtrl;
  }

  PosCtrl getPosCtrlFmPosControl(PosControl _posCtorl) {
    return PosCtrl(
        valuetext: _posCtorl.posctrldata,
        description: _posCtorl.posctrlinfo,
        itemcode: _posCtorl.posctrlkey);
  }

  PosControl getPocControlFmPosCtrl(PosCtrl _posCtrl) {
    return PosControl(
        posctrldata: _posCtrl.valuetext,
        posctrlinfo: _posCtrl.description,
        posctrlkey: _posCtrl.itemcode);
  }

  Future<PosCtrl> getResultSearchToPosCtrl(PosCtrl posCtrl, int index) async {
    if (posCtrl != null) {
      return PosCtrl(
          itemcode: posCtrl.itemcode,
          description: posCtrl.description,
          groupcode: posCtrl.groupcode,
          valuetext: posCtrl.valuetext,
          valueint: index,
          valuedbl: posCtrl.valuedbl,
          image: posCtrl.image);
    }

    return null;
  }

  //-----------
  //-----------service pos control data ------
  String getMbDiscMethod(BuildContext context) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    PosCtrl _searchpslist = posCtrlList[0];
    String result =
        PosControlFnc().getCurrentSettingValues(context, _searchpslist);
    return result;
  }

  String getPLUurl(BuildContext context) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_pluWSurl];
    String result =
        PosControlFnc().getCurrentSettingValues(context, _searchpslist);
    // http://192.168.1.34:9393/getsaleitem/999
    //--this is funtion get only posid/member plulist !
    return result + '/getsaleitem';
  }

  void getBackScreenType(BuildContext context) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_configPanel];
    String result =
        PosControlFnc().getCurrentSettingValues(context, _searchpslist);
    if (result.split('-').length > 0) {
      result = result.split('-')[0].trim();
    }
    List<PosCtrl> screentypes = posCtrlListOpt
        .where((e) => (e.itemcode == model.poscontrolList[1].posctrlkey))
        .toList();
    MaterialPageRoute route;
    try {
      if (result == screentypes[0].valuetext.split('-')[0].trim()) {
        route = MaterialPageRoute(builder: (value) => RetailSalesPages());
      } else if (result == screentypes[1].valuetext.split('-')[0].trim()) {
        route = MaterialPageRoute(builder: (value) => FullSalesPages());
      } else if (result == screentypes[2].valuetext.split('-')[0].trim()) {
        route = MaterialPageRoute(builder: (value) => ResturantSalesPages());
      } else {
        route = MaterialPageRoute(builder: (value) => RetailSalesPages());
      }
      Navigator.push(context, route);
    } catch (e) {
      Navigator.pop(context);
    }
  }

  String getActivePosUrl(BuildContext context, String posid) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_pluWSurl];
    String result =
        PosControlFnc().getCurrentSettingValues(context, _searchpslist);
    // http://192.168.1.34:9393/getsaleitem/999
    //--this is funtion get only posid/member plulist !
    return result + '/getActivePosStation/' + posid;
  }

  String getRefundUrl(BuildContext context, String docno, String params) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_pluWSurl];
    String result =
        PosControlFnc().getCurrentSettingValues(context, _searchpslist);
    //-- http://127.0.0.1:9393/savePosTrans/1GS00200122000037/2/3/4/5/6
    if (params.isEmpty || params != '') {
      return result + '/savePosTrans/' + docno + '/' + params; //--DT,Disc,Recv
    } else {
      return result + '/savePosTrans/' + docno; // --HD
    }
  }

  String getVatExurl(BuildContext context) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_pluWSurl];
    String result =
        PosControlFnc().getCurrentSettingValues(context, _searchpslist);
    String docno = getRunno(context, MyConfig().a_cycleRcptBegEnd);
    docno = 'EV-' + docno;
    return result + '/savePosTrans/ve/' + docno;
  }

  String getPromoDesc(BuildContext context) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_memWSurl];
    String result =
        PosControlFnc().getCurrentSettingValues(context, _searchpslist);
    // http://192.168.1.34:9393/getsaleitem/999
    //--this is funtion get only posid/member plulist !
    return result;
  }

  String getMemberurl(BuildContext context) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_pluWSurl];
    String result;
    try {
      result = PosControlFnc().getCurrentSettingValues(context, _searchpslist);
      result = result.replaceAll('//', '#');
      result = result + '/csmembers';
      result = result.replaceAll('#', '//');
    } catch (e) {
      normalDialog(context, e.toString());
    }
    return result;
  }

  String getSalesmanurl(BuildContext context) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);

    PosCtrl _searchpslist = posCtrlList[MyConfig().i_pluWSurl];
    String result =
        PosControlFnc().getCurrentSettingValues(context, _searchpslist);

    return result + '/cssalesman';
  }

  String getCsParamUrl(BuildContext context) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    model.getItem();
    String wsparam, result, posid;
    wsparam = '/csparam';
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_posId];
    PosCtrl _searchpslist2 = posCtrlList[MyConfig().i_pluWSurl];
    try {
      posid = PosControlFnc().getCurrentSettingValues(context, _searchpslist);
      result = PosControlFnc().getCurrentSettingValues(context, _searchpslist2);
      result = result.replaceAll('//', '#');
      result = result + wsparam + '/' + posid;
      result = result.replaceAll('#', '//');
      // result = result.replaceAll(wsplu, wsparam) + '/' + posid;
    } catch (e) {
      normalDialog(context, e.toString());
    }

    return result;
  }

  String getPosSignInurl(BuildContext context) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    String wsparam, result, posid;
    wsparam = '/GetPosSIgnIn';
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_posId];
    PosCtrl _searchpslist2 = posCtrlList[MyConfig().i_pluWSurl];
    try {
      posid = PosControlFnc().getCurrentSettingValues(context, _searchpslist);
      result = PosControlFnc().getCurrentSettingValues(context, _searchpslist2);
      result = result.replaceAll('//', '#');
      result = result + wsparam + '/i/' + posid;
      result = result.replaceAll('#', '//');
      // result = result.replaceAll(wsplu, wsparam) + '/' + posid;
    } catch (e) {
      normalDialog(context, e.toString());
    }

    return result;
  }

  String getAddShifturl(BuildContext context) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    String wsparam, result, posid;
    //Posshift/a/00125/002/2000
    wsparam = '/Posshift/a/';
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_posId];
    PosCtrl _searchpslist2 = posCtrlList[MyConfig().i_pluWSurl];
    try {
      posid = PosControlFnc().getCurrentSettingValues(context, _searchpslist);
      result = PosControlFnc().getCurrentSettingValues(context, _searchpslist2);
      result = result.replaceAll('//', '#');
      result = result + wsparam + posid;
      result = result.replaceAll('#', '//');
      // result = result.replaceAll(wsplu, wsparam) + '/' + posid;
    } catch (e) {
      normalDialog(context, e.toString());
    }

    return result;
  }

  String getUpStatusShifturl(
      BuildContext context, String posshiftid, String status) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    String wsparam, result, posid;
    wsparam = '/Posshift/' + posshiftid + '/' + status;
    PosCtrl _searchpslist2 = posCtrlList[MyConfig().i_pluWSurl];
    try {
      result = PosControlFnc().getCurrentSettingValues(context, _searchpslist2);
      result = result.replaceAll('//', '#');
      result = result + wsparam;
      result = result.replaceAll('#', '//');
    } catch (e) {
      normalDialog(context, e.toString());
    }

    return result;
  }

  String getConfigCashier(BuildContext context) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    String wsplu, wsmember, result;
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_configCashier];
    result = PosControlFnc().getCurrentSettingValues(context, _searchpslist);

    return (result == null) ? '' : result;
  }

  String getSalesVateType(BuildContext context) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    String wsplu, wsmember, result;
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_salesVatType];
    result = PosControlFnc().getCurrentSettingValues(context, _searchpslist);

    return (result == null) ? '' : result.substring(0, 1);
  }

  String getConfigSalesman(BuildContext context) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    String wsplu, wsmember, result;
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_configSaleman];
    result = PosControlFnc().getCurrentSettingValues(context, _searchpslist);

    return (result == null) ? '' : result;
  }

  String getConfigMember(BuildContext context) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    String wsplu, wsmember, result;
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_configMember];
    result = PosControlFnc().getCurrentSettingValues(context, _searchpslist);

    return (result == null) ? '' : result;
  }

//----
  void loginShiftId(BuildContext context, PosShiftLogin activeposShift) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    //  PosCtrl update;
    if (activeposShift != null) {
      //------Config.Pos Shift ID -- use for change Shift Status
      model.updateItem(
          MyConfig().a_cycleShiftId,
          getPocControlFmPosCtrl(_PosCtrlupdate(
              activeposShift.posshiftID.toString(),
              posCtrlList[MyConfig().a_cycleShiftId])));
    }
  }

  String getShiftId(BuildContext context) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    //  PosCtrl update;
    PosCtrl _searchpslist = posCtrlList[MyConfig().a_cycleShiftId];
    return PosControlFnc().getCurrentSettingValues(context, _searchpslist);
  }

  String getPromptPayNumber(BuildContext context) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    //  PosCtrl update;
    PosCtrl _searchpslist = posCtrlList[MyConfig().a_cyclePromptPay];
    return PosControlFnc().getCurrentSettingValues(context, _searchpslist);
  }

  String getQRPayNumber(BuildContext context) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    //  PosCtrl update;
    PosCtrl _searchpslist = posCtrlList[MyConfig().a_cycleQRpayId];
    return PosControlFnc().getCurrentSettingValues(context, _searchpslist);
  }

  String getQrPayData(String epayid, double rcpamount) {
    String C00 = '000201';
    String C01 =
        '010211'; // '010211'-static QR payment, '010212'-dynamic QR payment
    String epaydata = '0016A0000006770101110315' + epayid.trim();
    String epaylen = '29' + epaydata.length.toString().padLeft(2, '0');
    String C30 = epaylen + epaydata;
    String C53 = '5303' + '764';
    String payamt = c2rnd.format(rcpamount);
    String amtlen =
        payamt.length.toString().padLeft(2, '0'); //764 is Currency of Bath
    String C54 = '54' + amtlen + payamt;
    String C58 = '5802' + 'TH';
    String C63 = '6304';
    String result = C00 + C01 + C30 + C53 + C54 + C58 + C63;
    result = result + '46C7';
    return result;
  }

  void updateConfigCashier(BuildContext context, String cashierOnShift) {
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_configCashier];
    updatePosControl(
        context,
        PosCtrl(
            itemcode: _searchpslist.itemcode,
            description: _searchpslist.description,
            groupcode: _searchpslist.groupcode,
            valuetext: cashierOnShift,
            valueint: _searchpslist.valueint,
            valuedbl: _searchpslist.valuedbl,
            image: _searchpslist.image));
  }

  //-------CONFIG UPDATE BY SHIFT LOGIN--------
  void newShift(
      BuildContext context, PosShiftLogin activeposShift, double cashbegin) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    PosCtrl update;
    if (activeposShift != null) {
      //------Config.Cashier
      //      int a_cycleCashier = 60;
      model.updateItem(
          MyConfig().i_configCashier,
          getPocControlFmPosCtrl(_PosCtrlupdate(
              (activeposShift.cashierId + ' - ' + activeposShift.cashierName)
                  .padRight(30, ' '),
              posCtrlList[MyConfig().i_configCashier])));

      model.updateItem(
          MyConfig().i_configShopId,
          getPocControlFmPosCtrl(_PosCtrlupdate(
              activeposShift.shopId.padRight(34, ' '),
              posCtrlList[MyConfig().i_configShopId])));

      model.updateItem(
          MyConfig().i_configSaleman,
          getPocControlFmPosCtrl(_PosCtrlupdate(''.padRight(30, '_'),
              posCtrlList[MyConfig().i_configSaleman]))); //Clear Salemans

      model.updateItem(
          MyConfig().i_configMember,
          getPocControlFmPosCtrl(_PosCtrlupdate(''.padRight(45, '_'),
              posCtrlList[MyConfig().i_configMember]))); //Clear member
      //------Config.Start/End Receipt/Refund Running

      int a_MbDicsMethod = 0;
      String s_MbDiscMethod = '';
      if (activeposShift.startReceiptNo == '1') {
        s_MbDiscMethod = '1 - Total sales';
      } else {
        s_MbDiscMethod = '2 - Each line of sales';
      }
      model.updateItem(
          a_MbDicsMethod,
          getPocControlFmPosCtrl(
              _PosCtrlupdate(s_MbDiscMethod, posCtrlList[a_MbDicsMethod])));

      int a_AllowOverStock = 2;
      String s_AllowOverStock = '';
      if (activeposShift.endReceiptNo == '1') {
        s_AllowOverStock = '1 - Allow';
      } else {
        s_AllowOverStock = '2 - NOT Allow';
      }
      model.updateItem(
          a_AllowOverStock,
          getPocControlFmPosCtrl(
              _PosCtrlupdate(s_AllowOverStock, posCtrlList[a_AllowOverStock])));

      // ---- start running
      int a_startReceiptNo = MyConfig().a_cycleRcptBegEnd;
      String s_startReceiptNo = getFirstRunno(a_startReceiptNo, 1, '1',
          activeposShift.shopId, activeposShift.posId);

      model.updateItem(
          a_startReceiptNo,
          getPocControlFmPosCtrl(_PosCtrlupdate(
              s_startReceiptNo + ',' + s_startReceiptNo,
              posCtrlList[a_startReceiptNo])));

      int a_startRefundNo = MyConfig().a_cycleRfndBegEnd;
      String s_startRefundNo = getFirstRunno(
          a_startRefundNo, 1, '2', activeposShift.shopId, activeposShift.posId);

      model.updateItem(
          a_startRefundNo,
          getPocControlFmPosCtrl(_PosCtrlupdate(
              s_startRefundNo + ',' + s_startRefundNo,
              posCtrlList[a_startRefundNo])));

      model.updateItem(
          MyConfig().a_cycleCashBeg,
          getPocControlFmPosCtrl(_PosCtrlupdate(oCcy.format(cashbegin) + ':_:_',
              posCtrlList[MyConfig().a_cycleCashBeg])));

      model.updateItem(
          MyConfig().a_cycleSignInDT,
          getPocControlFmPosCtrl(_PosCtrlupdate(
              dateFormat.format(DateTime.now()),
              posCtrlList[MyConfig().a_cycleSignInDT])));

      model.updateItem(
          MyConfig().a_cycleSignOutDt,
          getPocControlFmPosCtrl(
              _PosCtrlupdate(' ', posCtrlList[MyConfig().a_cycleSignOutDt])));
    }
  }

  void saveActivePIP(BuildContext context, String curIP,
      ExActivePIPResponse responseActivePip) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    //--save to Server.
    //http://127.0.0.1:9393/getActivePosStation/00122/001/[192.168.1.39:9393
    //_responseActivePip.exActivePip(pluUrl);
    PosCtrl _searchposid = posCtrlList[MyConfig().i_posId];
    String posid =
        PosControlFnc().getCurrentSettingValues(context, _searchposid);
    if (posid.split('-').length > 0) {
      posid = posid.split('-')[0].trim();
    }
    PosCtrl _searchcashier = posCtrlList[MyConfig().i_configCashier];
    String cashier =
        PosControlFnc().getCurrentSettingValues(context, _searchcashier);
    if (cashier.split('-').length > 0) {
      cashier = cashier.split('-')[0].trim();
    }
    String url = curIP +
        '/getActivePosStation/' +
        posid +
        '/' +
        cashier +
        '/' +
        curIP.replaceAll('http://', '[').replaceAll('https://', '[[');
    responseActivePip.exActivePip(url);
  }

  void checkCurIP_pluWSurl(BuildContext context, String curIP) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    //----
    //--save to config.
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_pluWSurl];

    updatePosControl(
        context,
        PosCtrl(
            itemcode: _searchpslist.itemcode,
            description: _searchpslist.description,
            groupcode: _searchpslist.groupcode,
            valuetext: curIP,
            valueint: _searchpslist.valueint,
            valuedbl: _searchpslist.valuedbl,
            image: _searchpslist.image));
  }

  Future<String> getCurrentIP(String dataimgUrl) async {
    List<NetworkDevice> getCurIpList = await getIPinfoList();

    if (getCurIpList != null) {
      String chkIP, MyIp;
      for (var ntw in getCurIpList) {
        chkIP = ntw.networkInfoList[0].ip;
        int rgip = int.parse(chkIP.split('.')[2]);
        if (rgip > 0 && rgip < 5) {
          MyIp = chkIP;
          break;
        }
      }
      if (MyIp == null || MyIp == '0.0.0.0') {
        MyIp = '127.0.0.1';
      }
      dataimgUrl = dataimgUrl.replaceAll('http://', '');
      dataimgUrl = dataimgUrl.replaceAll('https://', '');
      String getCurIp;
      if (MyIp != '') {
        if (dataimgUrl.lastIndexOf(':') > 0) {
          getCurIp = MyIp + ':' + dataimgUrl.split(':')[1];
        } else {
          dataimgUrl = dataimgUrl.replaceAll(dataimgUrl.split('/')[0], '');
          getCurIp = MyIp + '/' + dataimgUrl;
        }
        getCurIp = getCurIp.replaceAll('/getsaleitem', '');
        return 'http://' + getCurIp;
      }
    } else {
      dataimgUrl = 'http://127.0.0.1:9393';
    }
    return dataimgUrl;
  }

  Future<List<NetworkDevice>> getIPinfoList() async {
    try {
      return await ShowNetworkInterfaceInfo.getNetWorkInfo;
    } catch (exception) {
      return exception.message;
    }
  }

  void updateSetPanel(BuildContext context, int index, String values) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);

    PosCtrl _searchpslist = posCtrlList[index + 56];

    updatePosControl(
        context,
        PosCtrl(
            itemcode: _searchpslist.itemcode,
            description: _searchpslist.description,
            groupcode: _searchpslist.groupcode,
            valuetext: values,
            valueint: _searchpslist.valueint,
            valuedbl: _searchpslist.valuedbl,
            image: _searchpslist.image));

    // model.updateItem(
    //     index + 56,
    //     getPocControlFmPosCtrl(
    //         _PosCtrlupdate(values, posCtrlList[index + 56])));
  }

  void updateSalesman(BuildContext context, String curSalesman) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);

    model.updateItem(
        MyConfig().i_configSaleman,
        getPocControlFmPosCtrl(_PosCtrlupdate(
            curSalesman, posCtrlList[MyConfig().i_configSaleman])));
  }

  Future<void> updateCashier(BuildContext context, String curCashier) async {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);

    await model.updateItem(
        MyConfig().i_configCashier,
        getPocControlFmPosCtrl(_PosCtrlupdate(
            curCashier, posCtrlList[MyConfig().i_configCashier])));
  }

  void updateMember(BuildContext context, String curMember) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);

    model.updateItem(
        MyConfig().i_configMember,
        getPocControlFmPosCtrl(
            _PosCtrlupdate(curMember, posCtrlList[MyConfig().i_configMember])));
  }

  void updatePromoDesc(BuildContext context, String promoDesc) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);

    model.updateItem(
        MyConfig().i_memWSurl,
        getPocControlFmPosCtrl(
            _PosCtrlupdate(promoDesc, posCtrlList[MyConfig().i_memWSurl])));
  }

  String getTouchPanel(BuildContext context) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    //  PosCtrl update;
    PosCtrl _searchpslist = posCtrlList[MyConfig().i_configPanel];
    return PosControlFnc().getCurrentSettingValues(context, _searchpslist);
  }

  void updatePanel(BuildContext context, String curPanel) {
    updateACM(context, posCtrlList[MyConfig().i_configPanel], curPanel);
  }

  void updateConfigCashIn(BuildContext context, double _cash) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    PosCtrl update = posCtrlList[MyConfig().a_cycleCashBeg];
    String result = PosControlFnc().getCurrentSettingValues(context, update);
    if (result.isEmpty || result == '') {
      result = '_:_:_';
    }
    List<String> cash = result.split(':');
    String cashin;
    if (_cash > 0 && cash.length > 1) {
      if (FncItems().isNumeric(cash[1].replaceAll(',', ''))) {
        double cashintotal = double.parse(cash[1].replaceAll(',', '')) + _cash;
        cashin = cash[0] + ':' + oCcy.format(cashintotal) + ':' + cash[2];
      } else {
        cashin = cash[0] + ':' + oCcy.format(_cash) + ':' + cash[2];
      }

      model.updateItem(
          MyConfig().a_cycleCashBeg,
          getPocControlFmPosCtrl(
              _PosCtrlupdate(cashin, posCtrlList[MyConfig().a_cycleCashBeg])));
    }
  }

  String getCashBegInOut(BuildContext context) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    PosCtrl update = posCtrlList[MyConfig().a_cycleCashBeg];
    String result = PosControlFnc().getCurrentSettingValues(context, update);
    if (result.isEmpty || result == '') {
      result = '_:_:_';
    }
    return result;
  }

  void updateConfigCashOut(BuildContext context, double _cash) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    PosCtrl update = posCtrlList[MyConfig().a_cycleCashBeg];
    String result = PosControlFnc().getCurrentSettingValues(context, update);
    if (result.isEmpty || result == '') {
      result = '_:_:_';
    }
    if (result.split(':').length < 2) {
      result = result + ':_:_';
    }
    List<String> cash = result.split(':');

    String cashout;
    if (_cash > 0 && cash.length > 1) {
      if (FncItems().isNumeric(cash[2].replaceAll(',', ''))) {
        double cashouttotal = double.parse(cash[2].replaceAll(',', '')) + _cash;
        cashout = cash[0] + ':' + cash[1] + ':' + oCcy.format(cashouttotal);
      } else {
        cashout = cash[0] + ':' + cash[1] + ':' + oCcy.format(_cash);
      }

      model.updateItem(
          MyConfig().a_cycleCashBeg,
          getPocControlFmPosCtrl(
              _PosCtrlupdate(cashout, posCtrlList[MyConfig().a_cycleCashBeg])));
    }
  }

  int getBillmode(BuildContext context) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    //---get BillMode---
    PosCtrl _billmode = posCtrlList[MyConfig().a_SalesBillMode];
    String BillMode =
        PosControlFnc().getCurrentSettingValues(context, _billmode);
    if (BillMode.isNotEmpty && BillMode.substring(0, 1) != '') {
      return int.parse(BillMode.substring(0, 1));
    } else {
      return 1;
    }
  }

  void setBIllMode(BuildContext context, int mode, String referDocno) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    String billmode;
    if (mode == 2) {
      billmode = '2 - ' + referDocno;
    } else {
      billmode = '1 - SALES';
    }

    model.updateItem(
        MyConfig().a_cycleCashBeg,
        getPocControlFmPosCtrl(
            _PosCtrlupdate(billmode, posCtrlList[MyConfig().a_SalesBillMode])));
  }

  String getRunno(BuildContext context, int configID) {
    //---Call active docno when start;
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    //---get BillMode---
    int mode = getBillmode(context);
    PosCtrl _billmode = posCtrlList[MyConfig().a_SalesBillMode];
    String BillMode =
        PosControlFnc().getCurrentSettingValues(context, _billmode);
    //--Get Runno by bill mode
    String referBill;
    PosCtrl _searchpslist;
    if (mode == 2) {
      _searchpslist = posCtrlList[MyConfig().a_cycleRfndBegEnd];
      referBill = BillMode.replaceAll('2 -', '').trim();
    } else {
      _searchpslist = posCtrlList[configID];
    }
    //---get current value
    String result =
        PosControlFnc().getCurrentSettingValues(context, _searchpslist);
    if (result.isNotEmpty &&
        result != '000-000-000]000-000-000]' &&
        result.split(',').length > 1) {
      if (mode == 2) {
        return result.split(',')[1] + '\r\n' + referBill;
      } else {
        return result.split(',')[1];
      }
    }

    return result;
  }

  void nextRunno(BuildContext context, int configID) {
    //---when save ready then set next Runno to active docno;
    //---when close shift must set end docno = active docno -1;

    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    PosCtrl _searchpslist = posCtrlList[configID];
    String result =
        PosControlFnc().getCurrentSettingValues(context, _searchpslist);
    if (result.isNotEmpty &&
        result != '000-000-000]000-000-000]' &&
        result.split(',').length > 1) {
      try {
        result = result.trim();
        if (result.length > 6) {
          String srunno = result.substring(result.length - 6);
          int nextrunno = int.parse(srunno) + 1;
          result = result.substring(0, result.length - 6) +
              nextrunno.toString().trim().padLeft(6, '0');
          model.updateItem(
              configID,
              getPocControlFmPosCtrl(
                  _PosCtrlupdate(result, posCtrlList[configID])));
        }
      } catch (e) {
        showToast(context, e.toString());
      }
    }
    //---Clear salesMan & Member
    model.updateItem(
        MyConfig().i_configSaleman,
        getPocControlFmPosCtrl(_PosCtrlupdate(''.padRight(30, '_'),
            posCtrlList[MyConfig().i_configSaleman]))); //Clear Salemans

    model.updateItem(
        MyConfig().i_configMember,
        getPocControlFmPosCtrl(_PosCtrlupdate(''.padRight(45, '_'),
            posCtrlList[MyConfig().i_configMember]))); //Clear member
  }

  String getFirstRunno(int configid, int startORend, String doctype,
      String shopid, String posid) {
    PosCtrl update = posCtrlList[configid];
    String result = update.valuetext;
    String shopcode = shopid.split('-')[0].trim();
    if (result.isNotEmpty &&
        result != '000-000-000]000-000-000]' &&
        result.split(',').length > 1) {
      String runno = update.valuetext
          .split(',')[startORend]
          .replaceAll(doctype + shopid + posid, '');
      if (runno.isNotEmpty && int.parse(runno) > 0) {
        return doctype +
            shopcode +
            posid.trim() +
            (int.parse(runno) + 1).toString().trim().padLeft(6, '0');
      } else {
        return doctype +
            shopcode +
            posid.trim() +
            1.toString().trim().padLeft(6, '0');
      }
    } else {
      return doctype +
          shopcode +
          posid.trim() +
          1.toString().trim().padLeft(6, '0');
    }
    return result;
  }

  PosCtrl _PosCtrlupdate(String values, PosCtrl _posCtrlID) {
    return PosCtrl(
        itemcode: _posCtrlID.itemcode,
        description: _posCtrlID.description,
        groupcode: _posCtrlID.groupcode,
        valuetext: values,
        valueint: _posCtrlID.valueint,
        valuedbl: _posCtrlID.valuedbl,
        image: _posCtrlID.image);
  }

  //-----Printing Values Function
  String getConfigValue(BuildContext context, int id, String defaValue) {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);
    PosCtrl update = posCtrlList[id];
    String result = getCurrentSettingValues(context, update);
    if (result.isEmpty || result == '') {
      result = defaValue;
    }
    return result;
  }

  //----------Summary-------------

  Future<String> setACMBySalesItemSummary(
      BuildContext context, SalesItemSummary _salesitemsum) async {
    //--------SetVariables and check null------
    return saveSalesSUm(context, _salesitemsum);
  }

  String saveSalesSUm(BuildContext context, SalesItemSummary _salesitemsum) {
    double totalAmount, totalQty, totaldisc, totalcharge, totalvat;
    int _d = 0;
    try {
      totalAmount =
          (_salesitemsum.totalamount.isNaN) ? 0.0 : _salesitemsum.totalamount;
      totalQty = (_salesitemsum.totalqty.isNaN) ? 0.0 : _salesitemsum.totalqty;
      totaldisc =
          (_salesitemsum.totaldisc.isNaN) ? 0.0 : _salesitemsum.totaldisc;
      totalcharge =
          (_salesitemsum.totalchagre.isNaN) ? 0.0 : _salesitemsum.totalchagre;
      totalvat = (_salesitemsum.totalvat.isNaN) ? 0.0 : _salesitemsum.totalvat;
      ++_d;
      //--77.TotalItemExPrice = totalAmount - totaldisc + totalcharge
      updateACM(context, posCtrlList[MyConfig().i_TotalItemExPrice],
          oCcy.format(totalAmount + totaldisc - totalcharge));

      //--78.TotalDiscAmt = totaldisc
      updateACM(
          context, posCtrlList[MyConfig().i_totaldisc], oCcy.format(totaldisc));

      //--79.TotalCharge= totalchg
      updateACM(context, posCtrlList[MyConfig().i_totalchg],
          oCcy.format(totalcharge));

      //--80.TotalItemNetExPrice = totalAmount
      updateACM(context, posCtrlList[MyConfig().i_totalAmount],
          oCcy.format(totalAmount));

      //---81--alloocate discout
      double alldisc = 0.0; //--next implement--
      updateACM(context, posCtrlList[MyConfig().i_totalallocdisc],
          oCcy.format(alldisc));
      //--82---netsale  (= totalAmount - alloocate discout )
      updateACM(context, posCtrlList[MyConfig().i_totallnetSales],
          oCcy.format(totalAmount - alldisc));
      //--83.TotalItemVat = totalvat
      // if (_salesitemsum.totalvat.isNaN)
      updateACM(
          context, posCtrlList[MyConfig().i_totalvat], oCcy.format(totalvat));

      //--84--all discount = allocate discount + items discount,
      updateACM(
          context, posCtrlList[MyConfig().i_totalalldisc], oCcy.format(0.00));
      // 85.TotalChargeAmount = totalcharge
      updateACM(
          context, posCtrlList[MyConfig().i_totalallchg], oCcy.format(0.00));
      return 'OK';
    } catch (e) {
      showToast(context, e.toString() + ':' + _d.toString());
    }
    return 'OK';
  }

  Future<String> clearACMBySalesItemSummary(BuildContext context) async {
    //--------SetVariables and check null------
    double totalAmount, totalQty, totaldisc, totalcharge, totalvat;
    totalAmount = 0.0;
    //(_salesitemsum.totalamount.isNaN) ? 0 : _salesitemsum.totalamount;
    totalQty = 0.0;
    //(_salesitemsum.totalqty.isNaN) ? 0 : _salesitemsum.totalqty;
    totaldisc = 0.0;
    //(_salesitemsum.totaldisc.isNaN) ? 0 : _salesitemsum.totaldisc;
    totalcharge = 0.0;
    // (_salesitemsum.totalchagre.isNaN) ? 0 : _salesitemsum.totalchagre;
    totalvat = 0.0;
    // (_salesitemsum.totalvat.isNaN) ? 0 : _salesitemsum.totalvat;

    //--77.TotalItemExPrice = totalAmount - totaldisc + totalcharge
    updateACM(context, posCtrlList[MyConfig().i_TotalItemExPrice],
        oCcy.format(totalAmount + totaldisc - totalcharge));

    //--78.TotalDiscAmt = totaldisc
    updateACM(
        context, posCtrlList[MyConfig().i_totaldisc], oCcy.format(totaldisc));

    //--79.TotalCharge= totalchg
    updateACM(
        context, posCtrlList[MyConfig().i_totalchg], oCcy.format(totalcharge));

    //--80.TotalItemNetExPrice = totalAmount
    updateACM(context, posCtrlList[MyConfig().i_totalAmount],
        oCcy.format(totalAmount));

    //---81--alloocate discout
    double alldisc = 0.0; //--next implement--
    updateACM(context, posCtrlList[MyConfig().i_totalallocdisc],
        oCcy.format(alldisc));
    //--82---netsale  (= totalAmount - alloocate discout )
    updateACM(context, posCtrlList[MyConfig().i_totallnetSales],
        oCcy.format(totalAmount - alldisc));
    //--83.TotalItemVat = totalvat
    // if (_salesitemsum.totalvat.isNaN)
    updateACM(
        context, posCtrlList[MyConfig().i_totalvat], oCcy.format(totalvat));

    //--84--all discount = allocate discount + items discount,
    updateACM(
        context, posCtrlList[MyConfig().i_totalalldisc], oCcy.format(0.00));
    // 85.TotalChargeAmount = totalcharge
    updateACM(
        context, posCtrlList[MyConfig().i_totalallchg], oCcy.format(0.00));
    return 'OK';
  }

  Future<void> updateACM(
      BuildContext context, PosCtrl _posCtrl, String values) {
    updatePosACM(
        context,
        PosCtrl(
            itemcode: _posCtrl.itemcode,
            description: _posCtrl.description,
            groupcode: _posCtrl.groupcode,
            valuetext: values,
            valueint: _posCtrl.valueint,
            valuedbl: _posCtrl.valuedbl,
            image: _posCtrl.image));
    return null;
  }
}
