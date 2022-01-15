import 'dart:io';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/screens/searchplu/plu_info_ok.dart';
import 'package:path_provider/path_provider.dart';

enum representCharacter { plu, style, setPlu }
enum touchCharacter { RT, FB }

class MyConfig {
  MyConfig();
  //realtimestock url
  String urlSysUser = '/users';
  String urlRtohAll = '/WSO_RTohAll';
  String urlRtohLocation = '/WSO_RTohAWH';
  //authentication variable
  String headApiKey = 'pos2000develpmen_csiAPIm_pos2021_flutter_TaeChannel';
  String authusername = '999';
  String authpassword = '999';
  String initToken = 'Initial Token, will change when call authenticate events';
  String urlAuthToken = '/users/authenticate';

  String urlLogin = '/users';

//other variable
  String urlPlu = '/api/plu';
  String urlProduct = '/api/product';
  String urlReport = '/api/SalesReport';
  String urlSysPrdGroup = '/api/SysPrdGroup';
  String urlBranch = '/api/Branch';

//windows paras
  String winData =
      Directory.current.path + '\\' + Palette.sysname_label + '\\Data';

  String androidData = '/' + Palette.sysname_label + '/Data';
  String tablesUsageName = 'tableusage';
  String salesitemName = 'salesItem';
  String salesbdcName = 'bdcItem';
  String salesrcpName = 'rcpItem';
  String poscontrolName = 'poscontrol';
  String poscycleName = 'poscycle_YYMMDD';
  String hiveSp = ']';
  String hiveF1 = 'key';
  String hiveF2 = 'info';
  String hiveF3 = 'data';

  //Sales Register pages constant
  String sales_register_user = "รหัสแคชเชียร์/ผู้ใช้\n(Cashier/userid.)";
  String sales_register_pass = "รหัสผ่าน\n(Password)";

  //---Config.Id
  int i_configPanel = 1;
  int i_salesVatType = 47;
  int i_configShopId = 58;
  int i_posId = 59;
  int i_pId = 7;
  int i_pluWSurl = 56;
  int i_memWSurl = 57;
  int i_configCashier = 60;
  int i_configSaleman = 61;
  int i_configMember = 62;

  //---Accum.Cycle.Id
  int a_cycleShiftId = 4;
  int a_cyclePromptPay = 63;
  int a_cycleQRpayId = 64; //change to QR PAY
  int a_cycleCashBeg = 65;
  int a_cycleSignInDT = 66;
  int a_cycleSignOutDt = 67;
  //---17-12-21---Getting Runno by BillMode
  int a_SalesBillMode = 3;
  int a_cycleRcptBegEnd = 68;
  int a_cycleRfndBegEnd = 69;
  //----summary---
  int i_TotalItemExPrice = 77;
  int i_totaldisc = 78;
  int i_totalchg = 79;
  int i_totalAmount = 80;
  int i_totalallocdisc = 81;
  int i_totallnetSales = 82;
  int i_totalvat = 83;
  int i_totalalldisc = 84;
  int i_totalallchg = 85;

  //---Screen Config
  int i_srcDisplayStyle = 1;
  //---Printing Config
  int i_sitDisplayStyle = 46;
  //---Printing HeaderFooter
  int i_headerline1 = 21;
  int i_headerline2 = 22;
  int i_headerline3 = 23;
  int i_headerline4 = 24;
  int i_headerline5 = 25;
  int i_headerline6 = 26;

  int i_footerline1 = 27;
  int i_footerline2 = 28;
  int i_footerline3 = 29;
  int i_footerline4 = 30;
  int i_footerline5 = 31;
  int i_footerline6 = 32;
  int i_footerline7 = 33;
  int i_footerline8 = 34;
  int i_footerline9 = 35;
  int i_footerlineA = 36;
}
