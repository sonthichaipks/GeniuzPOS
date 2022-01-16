import 'package:com_csith_geniuzpos/screens/posacm/components/posacm_searchresult.dart';
import 'package:com_csith_geniuzpos/screens/posacm/posacm_pages.dart';
import 'package:com_csith_geniuzpos/screens/poscontrol/posctrl_pages.dart';
import 'package:com_csith_geniuzpos/screens/posparams/components/posparam_searchresult.dart';
import 'package:com_csith_geniuzpos/screens/posparams/posparams_pages.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/models/oldsobjs/cusicons.dart';

class Palette {
  Palette();
  static const String sysname_label = "Geniuz";
  static const String subsysname_label = "POS Front office";
  static const String sysmenu_label = "MAIN MENU";
  static const String sysmenu1_label = "CUSTOMER SERVICE";
  static const String sysinfo_label =
      "[text] [DB] [text1] [BRANCH] [text2] [POSNO]";
  static const String sysversion_label =
      "GeniuzPOS FRONT OFFICE VERSION [V] [EDITION]";
  static const String sysregisterd_label =
      "REGISTERED TO [COMPFULLNAME] AUTHORIZED TO [COMPFULLNAME]";

  static const String sales_register_title = "SIGN-IN";
  //------mode type of internal trans------

  static const String modeType_BDC = "BDC";
  static const String modeType_RCP = "RCP";
  //------sales--discount-coupon----
  static const String searchCASHCARD_title = "เลือกประเภทบัตรเงินสด";
  static const String searchCASHCOUPON_title = "เลือกประเภทคูปองเงินสด";
  static const String searchdisccoup_title = "เลือกประเภทคูปองส่วนลด";
  static const String searchCURRENCY_title = "เลือกสกุลเงิน";
  static const String searchOTHERCASH_title = "เลือกประเภทเงินอื่นๆ";
  static const String searchCREDITCARD_title = "เลือกประเภทบัตรเครดิต";
  static const String searchDEBITCARD_title = "เลือกประเภทบัตรเดบิต";
  //------POS PARAMS--ok----
  static const String posctrl_posid_lbl = "POS ID.";
  static const String posctrl_shopid_lbl = "SHOP ID - NAME";
  static const String posctrl_dataurl_lbl = "DATA SERVER IP.";
  static const String possmt_title = "POS STATION ENTRY";
  //-----
  static const String posparam_title = "POS PARAMS LOAD - TO UPDATE";
  static const String posparam_f1 = "CONFIG.ID";
  static const String posparamf11 = "ITEM.NAME";
  static const String posparamf111 = "CURRENT SETTING\r\nChange click here >>";
  static const String posparamf2 = "Description";
  static const String searchparam_title = "PARAMS LOAD ITEMS - TO UPDATE  ";
  //------POS CONTROL--ok----
  static const String posctrl_title = "POS CONFIGURATION";
  static const String posctrl_f1 = "CONFIG.ID";
  static const String posctrlf11 = "ITEM.NAME";
  static const String posctrlf111 = "CURRENT SETTING\r\nChange click here >>";
  static const String posctrlf2 = "Description";
  static const String searchps_title = "POS CONFIGURATION ITEMS LIST";
  //------POS ACCUM--ok----
  static const String posacm_title = "POS ACCUMURATES VALUES";
  static const String posacm_f1 = "ACM.ID";
  static const String posacmf11 = "ACM.NAME";
  static const String posacmf111 =
      "CURRENT VALUES (I/T)\r\nChange click here >>";
  static const String posacmf2 = "Description";
  static const String searchacm_title = "POS CONFIGURATION ITEMS";
  //------plu--ok----
  static const String checkprice_title =
      "PRICE CHECK \r\n ENTRY WORDS FOR SEARCH PLU BY CODE,NAME or BOTH  (CODE & NAME)";
  static const String plu_title =
      "PLU SEARCH \r\n ENTRY WORDS FOR SEARCH PLU BY CODE,NAME or BOTH (CODE & NAME)";
  static const String plu_f1 = "Barcode   or     Name   or     Both";
  static const String plu_f11 = "Plu Detail";
  static const String plu_f111 = "Unit";
  static const String plu_f1111 = "Default Price"; // or \r\nMember Price";
  static const String searchplu_title = "Search result";
  static const String promo_f1 =
      "Promotion Code\r\n\r\nPromotion  Price\r\n\r\nStart - End";
  static const String promo_f2 = "Search result";
  static const String promo_f3 = "Search result";
  //------sales--man--ok----
  static const String salesman_title = "ป้อนรหัสพนักงานขาย";
  static const String salesman_f1 = "รหัสพนักงานขาย";
  static const String salesman_f11 = "ชื่อพนักงานขาย";
  static const String searchsm_title = "ค้นหาพนักงานขาย";
  //------sales-member-ok----
  static const String sales_member_configID = "10064";
  static const String sales_member_title = "ป้อนรหัสสมาชิก";
  static const String sales_member_f1 = "รหัสสมาชิก";
  static const String sales_member_f11 = "ชื่อสมาชิก";
  static const String sales_member_f2 = "ประเภทสมาชิก";
  static const String sales_member_f3 = "วันเกิด";
  static const String sales_member_f4 = "แต้มสะสมคงเหลือ";
  static const String sales_member_f5 = "บัตรเงินสดคงเหลือ";
  static const String sales_member_f6 = "บันทึกช่วยจำ";
  static const String sales_member_f7 = "วันหมดอายุ";
  static const String sales_member_f8 = "RFID CARD";
  //------Memebr_Search_List----------
  static const String search_mblist_title = "ค้นหาสมาชิก";
  static const String search_mblist_Label =
      "ป้อนหมายเลขโทรศัพท์ / ชื่อต้นบางส่วน / ชื่อสกุลบางส่วน";
  static const String search_radio1_title = "ค้นหาด้วยหมายเลขโทรศัพท์";
  static const String search_radio2_title = "ค้นหาด้วยชื่อ-นามสกุลบางส่วน";
  //------Cash In / Out----
  static const String cashbeg_title = "ป้อนยอดเงินตั้งต้นเข้าลิ้นชัก";
  static const String cashin_title = "ป้อนยอดเงินนำเข้าลิ้นชัก";
  static const String cashout_title = "ป้อนยอดเงินนำออกลิ้นชัก";
  static const String cashbeg_label = "เงินเริ่มต้น รอบขายใหม่";
  static const String cashin_label = "นำเงินเข้า ในรอบขาย";
  static const String cashout_label = "นำเงินออก ในรอบขาย";
  //------Receipts-Pages---
  static const String receipts_title = "ป้อนรายการรับชำระเงิน";

  static const String receipts_totaldue = "รวมยอดที่ต้องชำระ";
  static const String receipts_totaldueExVat = "TOTAL DUE + EX.VAT";
  static const String receipts_totaldueE = "TOTAL DUE";

  static const String receipts_totalreceipts = "รวมยอดรับเงิน";
  static const String receipts_totalreceiptsE = "TOTAL RECEIPT";
  static const String receipts_balance = "ยอดคงเหลือ";
  static const String receipts_balanceE = "BALANCE DUE";

  static const String receipts_mcardtype = "ชนิดบัตร";
  static const String receipts_mcardid = "เลขที่บัตร";
  static const String receipts_mcardexpd = "วันหมดอายุ";
  static const String receipts_mcardcode = "รหัสอนุมัติ";
  static const String receipts_mcoupuntype = "ประเภทคูปอง";
  static const String receipts_mOthertype = "ประเภท";
  static const String receipts_mcoupunid = "เลขที่คูปอง";
  static const String receipts_mOtherid = "เลขที่";
  static const String receipts_mcurrencytype = "สกุลเงิน";
  static const String receipts_mcurrencyRate = "อัตราแลกเปลี่ยน";
  static const String receipts_mcurrencydate = "ณ วันที่";
  static const String receipts_mOtherdate = "ลง วันที่";
  static const String receipts_label =
      "ป้อนจำนวนเงิน\r\nแล้วเลือกชนิดการรับเงิน";

  static const String receipts_listtitle = "รายการรับชำระเงิน";

  //------Bill Discount Chargge-Pages---
  static const String billdischg_title = "ป้อนรายการส่วนลด/ชาร์จท้ายบิล";
  static const String billdischg_label =
      "ป้อนค่าส่วนลด/ชาร์จ\r\nแล้วเลือกชนิดลด/ชาร์จ";
  static const String billdischg_totalsales = "รวมยอดก่อนลด&ชาร์จ";
  static const String billdischg_totalsalesE = "BEFORE DISC.&CHARGE";

  static const String billdischg_totaldischg = "รวมส่วนลด/ชาร์จ";
  static const String billdischg_totaldischgE = "TOTAL DISC.&CHARGE";

  static const String billdischg_totalduepay = "ยอดคงเหลือ";
  static const String billdischg_totalduepayE = "TOTAL DUE TO PAY";

  static const String dischg_coupontitle = "ป้อนข้อมูลคูปอง";
  static const String billdischg_coupontype = "ประเภทคูปอง";
  static const String billdischg_coupondisc = "ส่วนลดคูปอง";
  static const String billdischg_couponnumber = "เลขที่คูปอง";
  static const String billdischg_couponexpd = "วันหมดอายุ";

  static const String billdischg_listtitle = "รายการส่วนลด/ชาร์จท้ายบิล";
  static const String title_amount = "จำนวนเงิน";
  //--------------------SALES TITLES------------

  static const String branch_lbl = " สาขา: ";
  static const String posst_lbl = " POS ID: ";
  static const String cashier_lbl = " CASHIER: ";
  static const String salesman_lbl = " SALESMAN: ";
  static const String member_lbl = " MEMBER: ";

  //--------------------SALES DISCOUNT CHARGE-CODES------------
  static const String dischg_space = "      ";
  static const String btncmd_CHGP = "CHGP";
  static const String lblcmd_CHGP = "ชาร์จ ";
  static const String btncmd_CHGB = "CHGB";
  static const String lblcmd_CHGB = "ชาร์จ ";
  static const String btncmd_DISCP = "DISCP";
  static const String lblcmd_DISCP = "ส่วนลด ";
  static const String btncmd_DISCB = "DISCB";
  static const String lblcmd_DISCB = "ส่วนลด ";
  static const String btncmd_DISCM = "DISCM";
  static const String lblcmd_DISCM = "ส่วนลดสมาชิก ";
  static const String btncmd_DISCCP = "DISCCP";
  static const String lblcmd_DISCCP = "ส่วนลดคูปอง #";
  static const String btncmd_DISCCB = "DISCCB";
  static const String lblcmd_DISCCB = "ส่วนลดคูปอง #";
  static const String btncmd_DISCPM = "DISCPM";
  static const String lblcmd_DISCPM = "ส่วนลดโปรโมชั่น ";

  //------ Printing Labels
  static const String lbl_cashbeg = "รับเงินสด ตั้งต้นเข้าลิ้นชัก";
  static const String lbl_cashin = "รับเงินสด นำเข้าลิ้นชัก";
  static const String lbl_cashout = "จ่ายเงินสด นำออกลิ้นชัก";

  //------VOID & REFUND LABELS
  static const String lbl_voidTitle = "VOID SALES ITEM";
  static const String lbl_voidConfirmTitle = "CONFIRM TO VOID ALL SALES ITEM";
  static const String lbl_refundTitle = "REFUND BILL";
  static const String lbl_billno = "เลขที่ใบเสร็จฯ : ";
  static const String lbl_refundno = "เลขที่ใบรับคืน : ";
  static const String lbl_totalBill = "รวมราคาทั้งสิ้น";
  //------------Theme Colors
  static const Color scaffold = Color(0xFFFFFFFFFF);
  static const Color stdHeader_border = Color(0xFFDDDDDD);
  static const Color facebookBlue = Color(0xFF1777F2);
  static const Color facebookbluee = Color(0xFF40C4FF);
  static const Color facebookRed = Color(0xFFFF0000);
  static const Color facebookGreen = Color(0xFF00FF00);

  static const Color lineshadow = Color(0xFFFFFFFF);

  static const Color stdbutton_theme_0 = Color(0xFFFFFFF);
  static const Color stdbutton_theme_0_1 = Color(0xFFF2F2F2);
  static const Color stdbutton_theme_1 = Color(0xFFC5E0B4);
  static const Color stdbutton_theme_2 = Color(0xFFD9D9D9);
  static const Color stdbutton_theme_3 = Color(0xFFBFBFBF);
  static const Color stdbutton_theme_4 = Color(0xFFa6e4ff); //DBEEF4
  static const Color stdbutton_theme_5 = Color(0xFFbfb88f);
  static const Color stdbutton_theme_51 = Color(0xFFDFCDB3);
  static const Color stdbutton_theme_6 = Color(0xFFDDD9C3);
  static const Color stdbutton_theme_7 = Color(0xFFFCD5B5);
  static const Color stdbutton_theme_71 = Color(0xFFF2DCDB);
  //#E6E0EC

  static const Color stdbutton_theme_8 = Color(0xFFEEECE1);
  static const Color stdbutton_theme_9 = Color(0xFFE6E0EC);
  static const Color stdbutton_theme_a = Color(0xFFF2DCDB);
  static const Color stdbutton_theme_b = Color(0xFFEBF1DE);
  static const Color stdbutton_theme_c = Color(0xFFDBEEF4);

  static const LinearGradient createRoomGradient = LinearGradient(
    colors: [Color(0xFF496AE1), Color(0xFFCE48B1)],
  );

  static const Color online = Color(0xFF4BCB1F);

  static const Color brownlight = Color(0xFFD7CCC8);

  static const LinearGradient storyGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Colors.black26],
  );

  static const LinearGradient stdButtonGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.topCenter,
    colors: [Colors.transparent, brownlight],
  );

  static LinearGradient setThemesButton(Color color) {
    return new LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.topCenter,
      colors: [Colors.transparent, color],
    );
  }

  //---POS BUTTUNS SIZE---EFFECT TO WINDOWS SIZE
  static const double stdbutton_width = 78; //85;
  static const double stdbutton_height = 67;
  static const double stdspacer_widht = 4; // 5;
  static const double stdicon_width = 35;
  static const double stdicon_height = 32;
  static const double stdscr_verposi = 441;

  static double windowswidth() {
    return stdbutton_width * 12.5 + (stdspacer_widht * 13);
  }

  static double windowsheight() {
    return stdbutton_height * 10.4 + (stdspacer_widht * 12);
  }

  static double salesitemwidth() {
    return stdbutton_width * 7 + (stdspacer_widht * 12);
  }

  static double restsalesitemwidth() {
    return stdbutton_width * 4.6 + (stdspacer_widht * 3);
  }

  static double restsalesheadwidth() {
    return stdbutton_width * 3 + (stdspacer_widht * 3);
  }

  static double restsalesitemheigth() {
    return stdbutton_height * 5.8;
  }

  static double salesitemheigth() {
    return stdbutton_height * 4.8;
  }

  static double fullsalesitemheigth() {
    return stdbutton_height * 5.4;
  }

  static double promdescwidth() {
    return stdbutton_width * 4.7 - 1;
  }

  static double entrypanelwidth() {
    return stdbutton_width * 4 - 5;
  }

  static double restentrypanelwidth() {
    return stdbutton_width * 4.6 + (stdspacer_widht * 3);
  }

  static double pluinoutwidth() {
    return stdbutton_width * 2;
  }

  static double promdescheigth() {
    return stdbutton_height * 0.9;
  }

  static double onelineheigth() {
    return stdbutton_height * 0.8;
  }

  static double salespromwidth() {
    return stdbutton_width * 4.5 + (stdspacer_widht * 3);
  }

  static double salespromheigth() {
    return stdbutton_height * 1 + (stdspacer_widht * 1);
  }

  static double salesheadcwidth() {
    return stdbutton_width * 5.6;
  }

  static double fullsalesheadcwidth() {
    return stdbutton_width * 4 + (stdspacer_widht * 11);
  }

  static double fullsalesitemwidth() {
    return stdbutton_width * 13.5 + (stdspacer_widht * 11) + 2;
  }

  static double fullsalesheadcheight() {
    return stdbutton_width * 1.1;
  }

  Image iconShow(int index) {
    final CusIcon cusicon = cusIcons[0];
    return Image.asset(cusicon.imageUrl,
        height: cusicon.btnXwid, width: cusicon.btnXwid);
  }

  Container showLogo() {
    return Container(
        child: Image.asset(
      'assets/Logo_csi.jpg',
      height: 130,
      width: 150,
    ));
  }

  Container showConfigf1(BuildContext context) {
    return Container(
        child: GestureDetector(
      onTap: () {
        showPopupTask(context, "ACCUM");
      },
      child: Image.asset(
        'assets/main_config.png',
        height: 130,
        width: 150,
      ),
    ));
  }

  Container showLogof1(BuildContext context) {
    return Container(
        child: GestureDetector(
      onTap: () {
        showPopupTask(context, "CONFIG");
      },
      child: Image.asset(
        'assets/logo_frontmain.png',
        height: 130,
        width: 150,
      ),
    ));
  }

  Future<void> showPopupTask(BuildContext context, String mnuName) async {
    switch (mnuName) {
      case "CONFIG":
        {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.white,
                insetAnimationDuration: const Duration(milliseconds: 100),
                child: Stack(
                  children: [
                    Container(
                      // use container to change width and height
                      height: Palette.stdbutton_height * 8,
                      width: Palette.stdbutton_width * 10.5,
                      child: PosCtrlPages(),
                    ),
                  ],
                ),
              );
            },
          );
        }
        break;
      case "ACCUM":
        {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.white,
                insetAnimationDuration: const Duration(milliseconds: 100),
                child: Stack(
                  children: [
                    Container(
                      height: Palette.stdbutton_height * 9.8,
                      width: Palette.stdbutton_width * 7.3,
                      child: PosAcmSearchPages(),
                    ),
                  ],
                ),
              );
            },
          );
        }
        break;
    }
  }

  static Color colorConvert(String color) {
    if (color != null) {
      color = color.replaceAll("#", "");
      color =
          color.replaceAll("(", "").replaceAll(")", "").replaceAll("Color", "");
      var converted;
      if (color.length == 6) {
        converted = Color(int.parse("0xFF" + color));
      } else if (color.length == 8) {
        converted = Color(int.parse("0x" + color));
      } else {
        converted = Color(int.parse("0xFF" + color.replaceAll("0xff", "")));
      }
      return converted;
    } else {
      return Colors.blue;
    }
  }
}
